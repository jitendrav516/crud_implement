<?php

namespace App\Http\Controllers;
use App\Models\Contact;
use App\Models\CustomFieldDefinition;
use App\Models\CustomFieldValue;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

use App\Models\ContactMergeLog;
use App\Models\ContactEmail;
use App\Models\ContactPhone;
use Illuminate\Support\Facades\DB;

class ContactController extends Controller
{
    public function index(Request $request)
    {
        // basic filters
        $query = Contact::query();

        if ($request->filled('name')) {
            $query->where('name','like','%'.$request->name.'%');
        }
        if ($request->filled('email')) {
            $query->where('email','like','%'.$request->email.'%');
        }
        if ($request->filled('gender')) {
            $query->where('gender',$request->gender);
        }

        // optional filter by custom field: expects field_key and value
        if ($request->filled('custom_key') && $request->filled('custom_value')) {
            $key = $request->custom_key;
            $value = $request->custom_value;
            $query->whereHas('customValues.definition', function($q) use ($key, $value) {
                $q->where('field_key', $key)
                  ->whereHas('values', function($q2) use ($value){
                      $q2->where('value', 'like', '%'.$value.'%');
                  });
            });
        }

        $contacts = $query->with('customValues.definition')->orderBy('id','desc')->paginate(10);

        $customFields = CustomFieldDefinition::all();

        // If AJAX request for filter/pagination, return partial
        if ($request->ajax()) {
            $html = view('contacts.partials.table', compact('contacts'))->render();
            return response()->json(['html' => $html]);
        }

        return view('contacts.index', compact('contacts','customFields'));
    }

    public function store(Request $request)
    {
        $rules = [
            'name' => 'required|string|max:255',
            'email'=> 'nullable|email|max:255',
            'phone'=> 'nullable|string|max:50',
            'gender'=> 'nullable|in:male,female,other',
            'profile_image' => 'nullable|file|mimes:jpg,jpeg,png|max:5120',
            'additional_file' => 'nullable|file|mimes:pdf,doc,docx,txt|max:10240',
        ];

        $data = $request->validate($rules);

        // handle files
        if ($request->hasFile('profile_image')) {
            $data['profile_image'] = $request->file('profile_image')->store('contacts/profile','public');
        }
        if ($request->hasFile('additional_file')) {
            $data['additional_file'] = $request->file('additional_file')->store('contacts/files','public');
        }

        $contact = Contact::create($data);

        // handle custom fields: expected as custom[field_key] => value
        $custom = $request->input('custom', []);
        foreach ($custom as $key => $value) {
            $definition = CustomFieldDefinition::where('field_key',$key)->first();
            if ($definition) {
                CustomFieldValue::updateOrCreate(
                    ['contact_id'=>$contact->id, 'field_definition_id'=>$definition->id],
                    ['value'=>$value]
                );
            }
        }

        return response()->json(['success'=>true,'message'=>'Contact created']);
    }

    public function update(Request $request, Contact $contact)
    {
        $rules = [
            'name' => 'required|string|max:255',
            'email'=> 'nullable|email|max:255',
            'phone'=> 'nullable|string|max:50',
            'gender'=> 'nullable|in:male,female,other',
            'profile_image' => 'nullable|file|mimes:jpg,jpeg,png|max:5120',
            'additional_file' => 'nullable|file|mimes:pdf,doc,docx,txt|max:10240',
        ];

        $data = $request->validate($rules);

        if ($request->hasFile('profile_image')) {
            // delete old if exists
            if ($contact->profile_image) Storage::disk('public')->delete($contact->profile_image);
            $data['profile_image'] = $request->file('profile_image')->store('contacts/profile','public');
        }
        if ($request->hasFile('additional_file')) {
            if ($contact->additional_file) Storage::disk('public')->delete($contact->additional_file);
            $data['additional_file'] = $request->file('additional_file')->store('contacts/files','public');
        }

        $contact->update($data);

        $custom = $request->input('custom', []);
        foreach ($custom as $key => $value) {
            $definition = CustomFieldDefinition::where('field_key',$key)->first();
            if ($definition) {
                CustomFieldValue::updateOrCreate(
                    ['contact_id'=>$contact->id, 'field_definition_id'=>$definition->id],
                    ['value'=>$value]
                );
            }
        }

        return response()->json(['success'=>true,'message'=>'Contact updated']);
    }

    public function destroy(Contact $contact)
    {
        // remove files
        if ($contact->profile_image) Storage::disk('public')->delete($contact->profile_image);
        if ($contact->additional_file) Storage::disk('public')->delete($contact->additional_file);

        $contact->delete();

        return response()->json(['success'=>true,'message'=>'Contact deleted']);
    }


    public function showJson(Contact $contact)
    {
        $custom = $contact->customValues->mapWithKeys(function($cv){
            return [$cv->definition->field_key => $cv->value];
        });

        return response()->json([
            'contact' => $contact,
            'custom' => $custom
        ]);
    }



    public function possibleMasters(Contact $contact)
{
    $masters = Contact::where('id','!=',$contact->id)
                      ->where('is_merged', false)
                      ->orderBy('name')
                      ->take(50)
                      ->get(['id','name','email','phone']);
    return response()->json(['masters' => $masters]);
}


public function mergeModal(Contact $contact)
{
    // include contact data + custom fields
    $contact->load('customValues.definition','emails','phones');
    return response()->json(['contact' => $contact]);
}

//-----------------------------------

public function merge(Request $request)
{
    $request->validate([
        'master_id' => 'required|exists:contacts,id',
        'secondary_id' => 'required|exists:contacts,id'
    ]);

    $master = Contact::with('customValues.definition','emails','phones')->findOrFail($request->master_id);
    $secondary = Contact::with('customValues.definition','emails','phones')->findOrFail($request->secondary_id);

    if ($master->id == $secondary->id) {
        return response()->json(['success'=>false,'message'=>'Master and secondary cannot be same.'], 422);
    }
    if ($secondary->is_merged) {
        return response()->json(['success'=>false,'message'=>'Secondary is already merged.'], 422);
    }

    DB::beginTransaction();
    try {
        $logPayload = [
            'master_before' => $master->toArray(),
            'secondary_before' => $secondary->toArray(),
            'emails_added' => [],
            'phones_added' => [],
            'custom_fields_copied' => [],
            'custom_fields_conflicts' => []
        ];

        // 1) Emails: copy any email from secondary not present in master
        $masterEmails = $master->emails->pluck('email')->map(function($e) { return strtolower($e); })->toArray();
        foreach ($secondary->emails as $se) {
            $emailLower = strtolower($se->email);
            if (!in_array($emailLower, $masterEmails)) {
                $new = ContactEmail::create([
                    'contact_id' => $master->id,
                    'email' => $se->email,
                    'is_primary' => false
                ]);
                $logPayload['emails_added'][] = $new->toArray();
            }
        }

        // If your legacy contacts table had single email value, add it too if exists
        if (!empty($secondary->email)) {
            $secSingle = strtolower($secondary->email);
            if (!in_array($secSingle, $masterEmails)) {
                $new = ContactEmail::firstOrCreate(
                    ['contact_id' => $master->id, 'email' => $secondary->email],
                    ['is_primary' => false]
                );
                $logPayload['emails_added'][] = $new->toArray();
            }
        }

        // 2) Phones: same logic
        $masterPhones = $master->phones->pluck('phone')->map(function($p){ return preg_replace('/\D/','',$p); })->toArray();
        foreach ($secondary->phones as $sp) {
            $normalized = preg_replace('/\D/','',$sp->phone);
            if (!in_array($normalized, $masterPhones)) {
                $new = ContactPhone::create([
                    'contact_id' => $master->id,
                    'phone' => $sp->phone,
                    'is_primary' => false
                ]);
                $logPayload['phones_added'][] = $new->toArray();
            }
        }
        if (!empty($secondary->phone)) {
            $norm = preg_replace('/\D/','',$secondary->phone);
            if (!in_array($norm, $masterPhones)) {
                $new = ContactPhone::firstOrCreate(
                    ['contact_id' => $master->id, 'phone' => $secondary->phone],
                    ['is_primary' => false]
                );
                $logPayload['phones_added'][] = $new->toArray();
            }
        }

        // 3) Custom fields: copy missing, record conflicts
        $masterCustom = $master->customValues->keyBy(function($cv){ return $cv->definition->field_key; });
        foreach ($secondary->customValues as $scv) {
            $key = $scv->definition->field_key;
            $secVal = $scv->value;
            if (!isset($masterCustom[$key]) || empty($masterCustom[$key]->value)) {
                // copy to master
                \App\Models\CustomFieldValue::updateOrCreate(
                    ['contact_id' => $master->id, 'field_definition_id' => $scv->field_definition_id],
                    ['value' => $secVal]
                );
                $logPayload['custom_fields_copied'][] = ['key'=>$key,'value'=>$secVal];
            } else {
                $masterVal = $masterCustom[$key]->value;
                if ($masterVal != $secVal) {
                    // conflict — we keep master, record conflict
                    $logPayload['custom_fields_conflicts'][] = [
                        'key' => $key,
                        'master_value' => $masterVal,
                        'secondary_value' => $secVal
                    ];
                }
            }
        }

        // 4) Mark secondary as merged (do not delete)
        $secondary->is_merged = true;
        $secondary->merged_into = $master->id;
        $secondary->save();

        // 5) Create merge log
        $mergeLog = ContactMergeLog::create([
            'master_contact_id' => $master->id,
            'secondary_contact_id' => $secondary->id,
            'payload' => $logPayload,
            'merged_at' => now()
        ]);

        DB::commit();

        return response()->json(['success'=>true,'message'=>'Contacts merged successfully','merge_log_id'=>$mergeLog->id]);

    } catch (\Exception $e) {
        DB::rollBack();
        return response()->json(['success'=>false,'message'=>'Merge failed: '.$e->getMessage()], 500);
    }
}


public function mergeLogs(Contact $contact) {
    $logs = ContactMergeLog::where('master_contact_id',$contact->id)->orWhere('secondary_contact_id',$contact->id)->orderBy('merged_at','desc')->get();
    return view('contacts.merge_logs', compact('logs','contact'));
}


//-----------------------------
}