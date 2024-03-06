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
        Schema::create('grades', function (Blueprint $table) {
            $table->id();
            $table->foreignId('year_id')->on('years')->onDelete('restrict')->onUpdate('cascade');
            $table->integer('grade_year');
            $table->char('initial',2);
            $table->integer('level');            
            $table->string('tag',5)->nullable();
            $table->string('byname',5)->nullable();
            $table->string('title_zh')->nullable();
            $table->string('title_en')->nullable();
            $table->integer('klass_num')->default(0);
            $table->text('description')->nullable();
            $table->text('behaviour_scheme')->nullable();
            $table->foreignId('transcript_template_id');
            $table->integer('version')->nullable();
            $table->boolean('active')->default(true);
            $table->boolean('transcript_locked')->default(false);
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
        Schema::dropIfExists('grades');
    }
};
