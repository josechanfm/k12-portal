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
        Schema::create('courses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('student_id')->constrained('students')->onDelete('restrict')->onUpdate('restrict');
            $table->string('code');
            $table->string('title_zh');
            $table->string('title_en')->nullable();
            $table->string('type',6)->nullable();
            $table->string('stream',6)->nullable();
            $table->string('elective',6)->nullable();
            $table->boolean('in_transcript')->default(false);
            $table->tinyInteger('unit')->default(2);
            $table->string('subject_head_ids')->default('[]');
            $table->boolean('active')->default(true);
            $table->text('description')->nullable();
            $table->tinyInteger('current_term')->default(1);
            $table->timestamps();
            $table->unique(['student_id','code'],'student_id_course_code');
        });

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('courses');
    }
};
