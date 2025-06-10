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
        Schema::create('studies', function (Blueprint $table) {
            $table->id();
            $table->tinyInteger('version');
            $table->foreignId('year_id')->nullable(); //要做每年記錄
            $table->tinyInteger('grade_year');
            $table->integer('sequence')->nullable();
            $table->string('title_zh');
            $table->string('title_en')->nullable();
            $table->string('stream');
            $table->boolean('active');
            $table->text('description')->nullable();
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
        Schema::dropIfExists('studies');
    }
};
