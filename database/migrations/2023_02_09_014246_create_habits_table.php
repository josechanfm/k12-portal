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
        Schema::create('habits', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('klass_student_id');
            $table->bigInteger('term_id');
            $table->char('health_1',1)->nullable();
            $table->char('health_2',1)->nullable();
            $table->char('health_3',1)->nullable();
            $table->char('health_4',1)->nullable();
            $table->char('health_5',1)->nullable();
            $table->char('behaviour_1',1)->nullable();
            $table->char('behaviour_2',1)->nullable();
            $table->char('behaviour_3',1)->nullable();
            $table->char('behaviour_4',1)->nullable();
            $table->char('behaviour_5',1)->nullable();
            $table->char('behaviour_6',1)->nullable();
            $table->char('social_1',1)->nullable();
            $table->char('social_2',1)->nullable();
            $table->char('social_3',1)->nullable();
            $table->char('social_4',1)->nullable();
            $table->char('social_5',1)->nullable();
            $table->unique(['klass_student_id','term_id']);
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
        Schema::dropIfExists('lives');
    }
};
