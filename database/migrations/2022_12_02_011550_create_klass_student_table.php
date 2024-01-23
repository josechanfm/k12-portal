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
        Schema::create('klass_student', function (Blueprint $table) {
            $table->id();
            $table->foreignId('klass_id')->on('klasses')->onDelete('restrict')->onUpdate('cascade');
            $table->foreignId('student_id')->on('students')->onDelete('restrict')->onUpdate('cascade');
            $table->string('student_number')->default(0);
            $table->char('state',3)->default('ACT');
            $table->char('stream',3)->default('ART');
            $table->bigInteger('promote')->default(0);
            $table->bigInteger('promote_to')->default(0);
            $table->string('score_scheme')->nullable();
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
        Schema::dropIfExists('klass_student');
    }
};
