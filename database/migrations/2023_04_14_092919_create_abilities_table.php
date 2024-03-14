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
        Schema::create('abilities', function (Blueprint $table) {
            $table->id();
            $table->foreignId('klass_student_id');
            $table->integer('term_id');
            $table->foreignId('topic_id');
            $table->string('credit')->nullable();
            $table->text('remark')->nullable();
            $table->timestamps();
            $table->unique(['klass_student_id','term_id','topic_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('abilities');
    }
};
