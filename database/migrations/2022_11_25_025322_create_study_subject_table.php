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
            $table->foreignId('study_id');
            $table->foreignId('subject_id');
            $table->string('subject_head_ids')->nullable();
            $table->tinyInteger('unit')->nullable();
            $table->string('main')->nullable();
            $table->string('type',6)->nullable();
            $table->string('stream',6)->nullable();
            $table->string('is_letter')->nullable();
            $table->string('elective')->nullable();
            $table->Integer('sort_num')->nullable();
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
        Schema::dropIfExists('study_subject');
    }
};
