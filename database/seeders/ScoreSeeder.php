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
            'course_student_id'=>3,
            'score_column_id'=>1,
            'point'=>100
        ]);
        DB::table('scores')->insert([
            'course_student_id'=>5,
            'score_column_id'=>1,
            'point'=>80
        ]);
        DB::table('scores')->insert([
            'course_student_id'=>3,
            'score_column_id'=>2,
            'point'=>90
        ]);
    }
}
