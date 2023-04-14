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
        Schema::create('outcomes', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('klass_student_id');
            $table->bigInteger('term_id');
            $table->integer('late')->nullable();
            $table->integer('absent')->nullable();
            $table->string('reward')->nullable();
            $table->string('leisure_name')->nullable();
            $table->string('leisure_perform')->nullable();
            $table->string('comment')->nullable();
            $table->string('appraisal')->nullable();
            $table->unique(['klass_student_id','term_id'])->nullable();
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
        Schema::dropIfExists('outcomes');
    }
};
