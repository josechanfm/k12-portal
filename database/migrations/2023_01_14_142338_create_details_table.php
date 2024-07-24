
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
        Schema::create('details', function (Blueprint $table) {
            $table->id();
            $table->foreignId('student_id')->constrained('students')->onDelete('restrict')->onUpdate('cascade');;
            $table->string('holy_name')->nullable();
            $table->date('baptized')->nullable();
            $table->date('first_communion')->nullable();
            $table->integer('sibling')->nullable();
            $table->integer('sibling_at_work')->nullable();
            $table->string('previour_school')->nullable();
            $table->string('previour_grade')->nullable();
            $table->date('entry_date')->nullable();
            $table->string('entry_klass')->nullable();
            $table->date('stay_issue')->nullable();
            $table->date('stay_expired')->nullable();
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
        Schema::dropIfExists('details');
    }
};
