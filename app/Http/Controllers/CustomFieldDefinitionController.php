<?php

namespace App\Http\Controllers;

use App\Models\CustomFieldDefinition;
use Illuminate\Http\Request;

class CustomFieldDefinitionController extends Controller
{
    public function index()
    {
        $fields = CustomFieldDefinition::all();
        return view('custom-fields.index', compact('fields'));
    }

    public function create()
    {
        return view('custom-fields.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'label' => 'required',
            'field_key' => 'required|alpha_dash|unique:custom_field_definitions,field_key',
            'type' => 'required',
            'options' => 'nullable'
        ]);

        $field = new CustomFieldDefinition();
        $field->label = $request->label;
        $field->field_key = strtolower($request->field_key);
        $field->type = $request->type;
        $field->options = $request->type == 'select'
                            ? explode(',', $request->options)
                            : null;

        $field->save();

        return redirect()->route('custom-fields.index')->with('success', 'Custom field added successfully!');
    }

    public function edit($id)
    {
        $field = CustomFieldDefinition::findOrFail($id);
        return view('custom-fields.edit', compact('field'));
    }

    public function update(Request $request, $id)
    {
        $field = CustomFieldDefinition::findOrFail($id);

        $request->validate([
            'label' => 'required',
            'type' => 'required',
            'options' => 'nullable'
        ]);

        $field->label = $request->label;
        $field->type = $request->type;
        $field->options = $request->type == 'select'
                            ? explode(',', $request->options)
                            : null;

        $field->save();

        return redirect()->route('custom-fields.index')->with('success', 'Custom field updated successfully!');
    }

    public function destroy($id)
    {
        $field = CustomFieldDefinition::findOrFail($id);
        $field->delete();

        return redirect()->route('custom-fields.index')->with('success', 'Custom field deleted!');
    }
}
