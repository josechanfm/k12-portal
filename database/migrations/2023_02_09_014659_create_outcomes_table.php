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
        Schema::create('outcomes', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('klass_student_id');
            $table->bigInteger('terim_id');
            $table->integer('late');
            $table->integer('absent');
            $table->string('reward');
            $table->string('leisure_name');
            $table->string('leisure_perform');
            $table->string('comment');
            $table->string('appraisal');
            $table->unique(['klass_student_id','term_id']);
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
        Schema::dropIfExists('outcomes');
    }
};
