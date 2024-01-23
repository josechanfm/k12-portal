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
        Schema::create('score_templates', function (Blueprint $table) {
            $table->id();
            $table->string('batch')->nullable();
            $table->string('type',6);
            $table->integer('term_id');
            $table->string('name');
            $table->integer('sequence')->nullable();
            $table->string('scheme')->nullable();
            $table->boolean('for_transcript')->default(false);
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
        Schema::dropIfExists('score_templates');
    }
};
