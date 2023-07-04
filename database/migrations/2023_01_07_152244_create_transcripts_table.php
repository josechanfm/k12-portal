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
        Schema::create('transcripts', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('klass_student_id')->on('klass_student')->onDelete('restrict')->onUpdate('cascade');
            $table->enum('column',['PSN','T1','T2','T3','T4','T1E','T1P','T1A','T2E','T2P','T2A','T3E','T3P','T3A','T4E','T4P','T4A','FIN']);
            $table->enum('category',['PERSONAL','SUBJECT','ATTITUDE','SUMMARY','GENERAL']);
            $table->string('reference_code')->nullable();
            //$table->string('field_name')->nullable();
            $table->string('value');
            $table->timestamps();
            $table->unique(['klass_student_id','reference_code'],'klass_student_reference_code');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('transcripts');
    }
};
