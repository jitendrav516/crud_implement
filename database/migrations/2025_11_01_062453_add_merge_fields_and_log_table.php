<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddMergeFieldsAndLogTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
   public function up()
{
    Schema::table('contacts', function (Blueprint $table) {
        $table->boolean('is_merged')->default(false);
        $table->unsignedBigInteger('merged_into')->nullable()->index();
        $table->foreign('merged_into')->references('id')->on('contacts')->onDelete('set null');
    });

    Schema::create('contact_merge_logs', function (Blueprint $table) {
        $table->id();
        $table->unsignedBigInteger('master_contact_id')->index();
        $table->unsignedBigInteger('secondary_contact_id')->index();
        $table->json('payload'); // snapshot of what was copied/overridden etc
        $table->timestamp('merged_at')->nullable();
        $table->timestamps();

        $table->foreign('master_contact_id')->references('id')->on('contacts')->onDelete('cascade');
        $table->foreign('secondary_contact_id')->references('id')->on('contacts')->onDelete('cascade');
    });
}

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
