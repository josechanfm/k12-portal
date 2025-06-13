<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('messages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('notice_id');
            $table->foreignId('messageable_id');
            $table->string('messageable_type');
            $table->string('category')->nullable();
            $table->string('title')->nullable();
            $table->text('content')->nullable();
            $table->boolean('acknowledge')->nullable();
            $table->string('question_body')->nullable();
            $table->string('question_option')->nullable();
            $table->string('answer')->nullable();            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('messages');
    }
};
