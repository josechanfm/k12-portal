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
        Schema::create('grades', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('year_id');
            $table->integer('rank');
            $table->char('initial',1);
            $table->integer('level');            
            $table->string('tag',5)->nullable();
            $table->string('title_zh')->nullable();
            $table->string('title_en')->nullable();
            $table->text('description')->nullable();
            $table->integer('version')->default(0);
            $table->boolean('active')->default(true);
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
        Schema::dropIfExists('grades');
    }
};
