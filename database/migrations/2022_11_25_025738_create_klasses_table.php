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
        Schema::create('klasses', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('grade_id')->on('grades')->onDelete('restrict');
            $table->bigInteger('head_id')->on('teachers')->onDelete('restrict')->nullable();
            $table->char('letter',5)->nullable();
            $table->char('tag',5)->nullable();
            $table->string('byname')->nullable();
            $table->string('room')->nullable();
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
        Schema::dropIfExists('klasses');
    }
};
