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
        Schema::create('healthcares', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('student_id');
            $table->string('hospital');
            $table->string('health_state');
            $table->date('vaccinated');
            $table->integer('last_vaccine');
            $table->string('vaccine count');
            $table->integer('covid_19');
            $table->string('illness');
            $table->string('trauma');
            $table->string('trauma_treatment');
            $table->string('food_allergy');
            $table->string('medicine_allergy');
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
        Schema::dropIfExists('healthcares');
    }
};
