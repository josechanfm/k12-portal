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
            $table->integer('term_id');
            $table->bigInteger('staff_id');
            $table->string('reference_id')->nullable();
            $table->string('actor')->nullable();
            $table->integer('score')->nullable();
            $table->text('remark')->nullable();
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
        Schema::dropIfExists('behaviours');
    }
};
