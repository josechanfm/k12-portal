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
        Schema::create('parentals', function (Blueprint $table) {
            $table->id();
            $table->foreignId('student_id')->constrained('students')->onDelete('restrict')->onUpdate('cascade');;
            $table->string('father_name')->nullable();
            $table->string('father_phone')->nullable();
            $table->string('father_organization')->nullable();
            $table->string('father_job')->nullable();
            $table->string('father_address')->nullable();
            $table->string('mother_name')->nullable();
            $table->string('mother_phone')->nullable();
            $table->string('mother_organization')->nullable();
            $table->string('mother_job')->nullable();
            $table->string('mother_address')->nullable();
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
        Schema::dropIfExists('parents');
    }
};
