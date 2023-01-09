<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ScoreSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('scores')->insert([
            'klass_student_id'=>3,
            'course_id'=>1,
            'score_column_id'=>1,
            'scope'=>'scope',
            'type'=>'type',
            'point'=>100
        ]);
        DB::table('scores')->insert([
            'klass_student_id'=>5,
            'course_id'=>1,
            'score_column_id'=>1,
            'scope'=>'scope',
            'type'=>'type',
            'point'=>80
        ]);
        DB::table('scores')->insert([
            'klass_student_id'=>3,
            'course_id'=>1,
            'score_column_id'=>2,
            'scope'=>'scope',
            'type'=>'type',
            'point'=>90
        ]);
    }
}
