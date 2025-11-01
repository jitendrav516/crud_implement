<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Contact extends Model
{
    protected $fillable = ['name','email','phone','gender','profile_image','additional_file'];

    public function customValues()
    {
        return $this->hasMany(CustomFieldValue::class, 'contact_id');
    }

    // helper to get value by key
    public function getCustomValue($key)
    {
        $value = $this->customValues()
            ->whereHas('definition', function($q) use ($key) { $q->where('field_key', $key); })
            ->with('definition')
            ->first();
        return $value ? $value->value : null;
    }

    public function emails() { return $this->hasMany(ContactEmail::class,'contact_id'); }
public function phones() { return $this->hasMany(ContactPhone::class,'contact_id'); }
public function mergeLogsAsMaster() { return $this->hasMany(ContactMergeLog::class,'master_contact_id'); }
public function mergeLogsAsSecondary() { return $this->hasMany(ContactMergeLog::class,'secondary_contact_id'); }

}

