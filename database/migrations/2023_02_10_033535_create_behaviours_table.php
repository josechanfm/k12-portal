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
        Schema::create('behaviours', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('klass_student_id');
            $table->bigInteger('term_id');
            $table->string('genre');
            $table->integer('qty');
            $table->string('description');
            $table->text('remark');
            $table->timestamps();
            $table->unique(['klass_student_id','term_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('behaviours');
    }
};
