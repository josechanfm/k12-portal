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
        Schema::create('medicnotes', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('student_id');
            $table->string('hospital')->nullable();
            $table->string('health_state')->nullable();
            $table->date('vaccinated')->nullable();
            $table->integer('last_vaccine')->nullable();
            $table->string('vaccine count')->nullable();
            $table->integer('covid_19')->nullable();
            $table->string('illness')->nullable();
            $table->string('trauma')->nullable();
            $table->string('trauma_treatment')->nullable();
            $table->string('food_allergy')->nullable();
            $table->string('medicine_allergy')->nullable();
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
        Schema::dropIfExists('medicnotes');
    }
};
