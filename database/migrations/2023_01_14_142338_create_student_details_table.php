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
        Schema::create('student_details', function (Blueprint $table) {
            $table->id();
            $table->foreignId('student_id');
            $table->string('holy_name')->nullable();
            $table->date('baptized')->nullable();
            $table->date('first_communion')->nullable();
            $table->string('past_entry_grade')->nullable();
            $table->date('past_entry_date')->nullable();
            $table->string('past_grade')->nullable();
            $table->date('valid_stay')->nullable();
            $table->integer('sibling')->nullable();
            $table->integer('sibling_at_work')->nullable();
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
        Schema::dropIfExists('student_details');
    }
};
