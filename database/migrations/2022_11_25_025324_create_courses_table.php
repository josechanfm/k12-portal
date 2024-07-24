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
        Schema::create('courses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('klass_id')->constrained('klasses')->onDelete('restrict')->onUpdate('restrict');
            $table->string('code');
            $table->string('title_zh');
            $table->string('title_en')->nullable();
            $table->string('type',6)->nullable();
            $table->string('stream',6)->nullable();
            $table->string('elective',6)->nullable();
            $table->text('description')->nullable();
            $table->string('score_column')->nullable();
            $table->string('score_scheme')->nullable();
            $table->boolean('in_transcript');
            $table->tinyInteger('unit');
            $table->boolean('active');
            $table->string('subject_head_ids')->default('[]');
            $table->tinyInteger('current_term')->default(1);
            $table->timestamps();
            $table->unique(['klass_id','code'],'klass_id_code');
        });

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('courses');
    }
};
