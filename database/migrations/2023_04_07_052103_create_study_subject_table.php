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
            $table->foreignId('year_id'); //要做每年記錄
            $table->string('subject_head_ids')->nullable();
            $table->string('unit')->nullable();
            $table->string('main')->nullable();
            $table->string('is_letter')->nullable();
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
