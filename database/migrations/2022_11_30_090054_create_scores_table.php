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
        Schema::create('scores', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('klass_student_id')->on('klass_student')->onDelete('restrict')->onUpdate('cascade');
            $table->bigInteger('score_column_id')->on('score_columns')->onDelete('restrict')->onUpdate('cascade');            
            $table->string('point')->nullable();
            $table->string('remark')->nullable();
            $table->timestamps();
            $table->unique(['klass_student_id','score_column_id'],'student_score');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('scores');
    }
};
