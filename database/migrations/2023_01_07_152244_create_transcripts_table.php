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
        Schema::create('transcripts', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('klass_student_id')->on('klass_student')->onDelete('restrict')->onUpdate('cascade');
            $table->integer('term_id');
            $table->string('column');
            $table->string('category');
            $table->string('reference_code')->nullable();
            $table->string('field_name')->nullable();
            $table->string('value');
            $table->timestamps();
            $table->unique(['klass_student_id','reference_code'],'klass_student_reference_code');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('transcripts');
    }
};
