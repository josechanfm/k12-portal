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
        Schema::create('transcript_templates', function (Blueprint $table) {
            $table->id();
            $table->integer('template_id');
            $table->enum('category',['PERSONAL','SUBJECT','ATTITUDE','SUMMARY','GENERAL']);
            $table->string('reference_code')->nullable();
            //$table->string('field_name')->nullable();
            $table->string('value')->nullable();
            $table->string('title_zh')->nullable();
            $table->string('title_en')->nullable();
            $table->text('remark')->nullable();
            $table->integer('version')->nullable();
            $table->timestamps();
            $table->unique(['template_id','reference_code'],'template_id_reference_code');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('transcript_templates');
    }
};
