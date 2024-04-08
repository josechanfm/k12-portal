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
        Schema::create('bodychecks', function (Blueprint $table) {
            $table->id();
            $table->foreignId('healthcare_id');
            $table->foreignId('klass_student_id');
            $table->string('column_value');
            $table->string('value')->nullable();
            $table->timestamps();
            $table->unique(['healthcare_id','klass_student_id','field_name']);

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bodychecks');
    }
};
