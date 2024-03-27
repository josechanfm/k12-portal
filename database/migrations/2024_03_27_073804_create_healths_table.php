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
        Schema::create('healths', function (Blueprint $table) {
            $table->id();
            $table->foreignId('student_id')->on('students')->onDelete('restrict')->onUpdate('cascade');
            $table->string('hospital')->nullable(); 
            $table->string('status')->nullable(); 
            $table->string('chironic')->nullable(); 
            $table->string('hereditary')->nullable(); 
            $table->string('allergy ')->nullable(); 
            $table->string('disease')->nullable(); 
            $table->text('remark')->nullable(); 
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
        Schema::dropIfExists('healths');
    }
};
