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
        Schema::create('subjects', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('grade_id');
            $table->string('code');
            $table->string('title_zh')->nullable();
            $table->string('title_en')->nullable();
            $table->string('type',6)->nullable();
            $table->string('stream',6)->nullable();
            $table->string('elective',6)->nullable();
            $table->text('description')->nullable();
            $table->integer('version');
            $table->boolean('active');
            $table->bigInteger('subject_template_id')->nullable();
            $table->timestamps();
            $table->unique(['grade_id', 'code']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('subjects');
    }
};
