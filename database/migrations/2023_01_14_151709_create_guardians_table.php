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
        Schema::create('guardians', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->on('users')->onDelete('restrict')->onUpdate('cascade')->nullable();
            $table->string('name_zh')->nullable();
            $table->string('name_fn')->nullable();
            $table->char('gender',1)->nullable();
            $table->date('dob')->nullable();
            $table->string('phone')->nullable();
            $table->string('organization')->nullable();
            $table->string('organization_phone')->nullable();
            $table->string('job')->nullable();
            $table->string('stay_together')->nullable();
            $table->string('zone')->nullable();
            $table->string('road_name')->nullable();
            $table->string('address')->nullable();
            $table->string('post_code')->nullable();
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
        Schema::dropIfExists('guardians');
    }
};
