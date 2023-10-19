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
            $table->bigInteger('theme_template_id');
            $table->integer('sequence')->nullable();
            $table->string('section_code');
            $table->string('section');
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
        Schema::dropIfExists('topic_templates');
    }
};
