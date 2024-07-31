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
        Schema::create('topic_templates', function (Blueprint $table) {
            $table->id();
            $table->foreignId('theme_template_id');
            $table->integer('sequence')->nullable();
            $table->string('ability_code')->nullable();
            $table->string('ability')->nullable();
            $table->string('abbr')->nullable();
            $table->string('section_code')->nullable();
            $table->string('section')->nullable();
            $table->string('title')->nullable();
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
        Schema::dropIfExists('topic_templates');
    }
};
