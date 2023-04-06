<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('study_subject', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('study_id');
            $table->bigInteger('subject_id');
            $table->timestamps();
            $table->unique(['study_id','subject_id'],'study_id_subject_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('study_subjects');
    }
};
