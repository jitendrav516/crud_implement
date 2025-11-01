<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateContactPhonesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
   public function up()
{
    Schema::create('contact_phones', function (Blueprint $table) {
        $table->id();
        $table->unsignedBigInteger('contact_id')->index();
        $table->string('phone')->index();
        $table->boolean('is_primary')->default(false);
        $table->timestamps();

        $table->foreign('contact_id')->references('id')->on('contacts')->onDelete('cascade');
        $table->unique(['contact_id','phone']);
    });
}

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('contact_phones');
    }
}
