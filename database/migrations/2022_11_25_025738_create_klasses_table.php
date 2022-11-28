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
            $table->bigInteger('year_id')->on('years')->onDelete('restrict');
            $table->bigInteger('head_id')->on('staffs')->onDelete('restrict');
            $table->char('grade',2);
            $table->char('initial',1);
            $table->char('acronym',5)->nullable();
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
