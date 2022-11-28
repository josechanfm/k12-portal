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
        Schema::create('student_gardians', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('student_id')->on('students')->onDelete('restrict');
            $table->bigInteger('gardian_id')->on('gardians')->onDelete('restrict');
            $table->string('relation');
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
        Schema::dropIfExists('student_gardians');
    }
};
