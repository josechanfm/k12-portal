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
        Schema::create('成績s', function (Blueprint $table) {
            $table->id();
            $table->foreignId('theme_template_id');
            $table->integer('sequence')->nullable();
            $table->string('ability_code');
            $table->string('ability');
            $table->string('abbr');
            $table->string('title');
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
        Schema::dropIfExists('成績s');
    }
};
