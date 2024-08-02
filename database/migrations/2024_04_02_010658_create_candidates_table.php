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
        Schema::create('candidates', function (Blueprint $table) {
            $table->id();
            $table->string('name_zh');
            $table->string('name_fn')->nullable();
            $table->string('name_display')->nullable();
            $table->char('gender',1);
            $table->date('dob')->nullable();
            $table->string('pob')->nullable();
            $table->string('pob_other')->nullable();
            $table->string('nationality')->nullable();
            $table->string('native')->nullable();
            $table->string('religion')->nullable();

            $table->string('id_num')->nullable();
            $table->string('id_type')->nullable();
            $table->string('id_type_other')->nullable();
            $table->string('id_issue')->nullable();
            $table->string('id_expired')->nullable();
            $table->string('hrc_num')->nullable();
            $table->string('hrc_issue')->nullable();
            $table->string('hrc_expired')->nullable();
            $table->string('dsedj_num')->nullable();
            $table->string('ssm_num')->nullable();

            $table->string('previour_school')->nullable();
            $table->string('previour_grade')->nullable();
            $table->string('start_grade_tag',5)->nullable();
            $table->string('start_klass_tag',5)->nullable();
            
            $table->string('phone')->nullable();
            $table->string('phone_home')->nullable();
            $table->boolean('confirmed')->default(false);
            $table->foreignId('student_id')->nullable();
            $table->boolean('enrolled')->default(false);

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
        Schema::dropIfExists('candidates');
    }
};
