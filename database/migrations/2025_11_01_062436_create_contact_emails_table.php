<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateContactEmailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
   public function up()
{
    Schema::create('contact_emails', function (Blueprint $table) {
        $table->id();
        $table->unsignedBigInteger('contact_id')->index();
        $table->string('email')->index();
        $table->boolean('is_primary')->default(false);
        $table->timestamps();

        $table->foreign('contact_id')->references('id')->on('contacts')->onDelete('cascade');
        $table->unique(['contact_id','email']);
    });
}

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('contact_emails');
    }
}
