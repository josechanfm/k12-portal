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
        Schema::create('klass_students', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('klass_id');
            $table->bigInteger('student_id');
            $table->char('state',3)->default('ACT');
            $table->char('stream',3)->default('ART');
            $table->tinyInteger('promote');
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
        Schema::dropIfExists('klass_students');
    }
};
