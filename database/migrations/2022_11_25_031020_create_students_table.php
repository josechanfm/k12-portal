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
        Schema::create('students', function (Blueprint $table) {
            $table->id();
            $table->string('name_zh');
            $table->string('name_fn')->nullable();
            $table->string('name_display')->nullable();
            $table->char('gender',1);
            $table->date('dob')->nullable();
            $table->string('pob')->nullable();
            $table->string('start_letter')->nullable();
            $table->string('start_grade')->nullable();
            $table->string('sic')->nullable();
            $table->string('phone')->nullable();
            $table->string('dsej_num')->nullable();
            $table->string('medical_num')->nullable();
            $table->date('entry_date')->nullable();

            $table->string('past_school_name')->nullable();
            $table->string('religion')->nullable();
            $table->string('phone_sms')->nullable();
            $table->string('phone_home')->nullable();
            $table->string('carer')->nullable();

            $table->text('address')->nullable();
            $table->text('id_card')->nullable();
            $table->text('bank')->nullable();

            $table->string('holy_name')->nullable();
            $table->date('baptized')->nullable();
            $table->date('first_communion')->nullable();
            $table->string('past_entry_grade')->nullable();
            $table->date('past_entry')->nullable();
            $table->string('past_grade')->nullable();
            $table->date('validat_stay')->nullable();
            $table->integer('sibling')->nullable();
            $table->integer('sibling_at_work')->nullable();

            $table->text('parent')->nullable();
            $table->text('garidan')->nullable();
            $table->text('liaison')->nullable();

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
        Schema::dropIfExists('students');
    }
};
