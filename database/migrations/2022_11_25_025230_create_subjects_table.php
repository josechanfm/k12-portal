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
        Schema::create('subjects', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('year');
            $table->string('abbr')->nullable();
            $table->string('title_zh')->nullable();
            $table->string('title_en')->nullable();
            $table->string('type',3)->nullable();
            $table->string('stream',3)->nullable();
            $table->tinyInteger('elective');
            $table->text('description')->nullable();
            $table->tinyInteger('active');
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
        Schema::dropIfExists('subjects');
    }
};
