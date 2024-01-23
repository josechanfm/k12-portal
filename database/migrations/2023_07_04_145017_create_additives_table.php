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
        Schema::create('additives', function (Blueprint $table) {
            $table->id();
            $table->integer('term_id');
            $table->foreignId('klass_student_id');
            $table->string('reference_code');
            $table->integer('value');
            $table->date('assign_at')->default(DB::raw('CURRENT_TIMESTAMP'));;
            $table->boolean('confirmed')->default(false);
            $table->date('submit_at')->nullable();
            $table->date('confirmed_at')->nullable();
            $table->foreignId('user_id');
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
        Schema::dropIfExists('additives');
    }
};
