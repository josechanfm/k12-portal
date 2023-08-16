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
        Schema::create('certificates', function (Blueprint $table) {
            $table->id();
            $table->string('certificate_type');
            $table->text('certificate_meta');
            $table->date('issue_date');
            $table->string('issue_number');
            $table->bigInteger('year_id');
            $table->integer('term_id')->nullable();
            $table->bigInteger('student_id');
            $table->bigInteger('student_number');
            $table->bigInteger('klass_id');
            $table->string('klass_tag')->nullable();
            $table->string('name_display')->nullable();
            $table->text('extra')->nullable();
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
        Schema::dropIfExists('certificates');
    }
};
