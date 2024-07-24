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
        Schema::create('relatives', function (Blueprint $table) {
            $table->id();
            $table->foreignId('student_id')->constrained('students')->onDelete('restrict')->onUpdate('cascade');
            $table->string('relation');
            $table->string('kinship');
            $table->string('name_zh')->nullable();
            $table->string('name_fn')->nullable();
            $table->string('birth_year')->nullable();
            $table->string('organization')->nullable();
            $table->string('occupation')->nullable();
            $table->string('mobile')->nullable();
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
        Schema::dropIfExists('relatives');
    }
};
