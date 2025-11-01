<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CustomFieldDefinition extends Model
{
    protected $fillable = ['label','field_key','type','options'];

    protected $casts = [
        'options' => 'array'
    ];

    public function values()
    {
        return $this->hasMany(CustomFieldValue::class, 'field_definition_id');
    }
}

