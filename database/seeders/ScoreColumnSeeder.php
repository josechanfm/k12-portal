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
            'klass_id'=>1,
            'term_id'=>1,
            'course_id'=>1,
            'sequence'=>1,
            'name'=>'Test1',
        ]);
        DB::table('score_columns')->insert([
            'klass_id'=>1,
            'term_id'=>1,
            'course_id'=>1,
            'sequence'=>2,
            'name'=>'Exam',
        ]);
        DB::table('score_columns')->insert([
            'klass_id'=>1,
            'term_id'=>2,
            'course_id'=>1,
            'sequence'=>3,
            'name'=>'Test2',
        ]);
        DB::table('score_columns')->insert([
            'klass_id'=>1,
            'term_id'=>2,
            'course_id'=>1,
            'sequence'=>4,
            'name'=>'Exam',
        ]);

    }
}
