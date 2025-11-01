<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCustomFieldValuesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
{
    Schema::create('custom_field_values', function (Blueprint $table) {
        $table->id();
        $table->unsignedBigInteger('contact_id');
        $table->unsignedBigInteger('field_definition_id');
        $table->text('value')->nullable();

        $table->foreign('contact_id')->references('id')->on('contacts')->onDelete('cascade');
        $table->foreign('field_definition_id')->references('id')->on('custom_field_definitions')->onDelete('cascade');

        $table->unique(['contact_id','field_definition_id']);
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
        Schema::dropIfExists('custom_field_values');
    }
}
