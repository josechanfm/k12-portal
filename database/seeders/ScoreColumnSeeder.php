<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ScoreColumnSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('score_columns')->insert([
            'term_id'=>1,
            'course_id'=>1,
            'sequence'=>1,
            'field_name'=>'test1',
            'field_label'=>'Test1',
        ]);
        DB::table('score_columns')->insert([
            'term_id'=>1,
            'course_id'=>1,
            'sequence'=>2,
            'field_name'=>'exam',
            'field_label'=>'Exam',
        ]);
        DB::table('score_columns')->insert([
            'term_id'=>2,
            'course_id'=>1,
            'sequence'=>3,
            'field_name'=>'test2',
            'field_label'=>'Test2',
        ]);
        DB::table('score_columns')->insert([
            'term_id'=>2,
            'course_id'=>1,
            'sequence'=>4,
            'field_name'=>'exam',
            'field_label'=>'Exam',
        ]);

    }
}
