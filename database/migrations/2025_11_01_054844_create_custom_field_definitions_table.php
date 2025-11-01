<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCustomFieldDefinitionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
{
    Schema::create('custom_field_definitions', function (Blueprint $table) {
        $table->id();
        $table->string('label');             // e.g. "Birthday"
        $table->string('field_key')->unique(); // e.g. "birthday"
        $table->enum('type', ['text','textarea','date','number','select'])->default('text');
        $table->text('options')->nullable(); // JSON for select options
        $table->timestamps();
    });
}

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('custom_field_definitions');
    }
}
