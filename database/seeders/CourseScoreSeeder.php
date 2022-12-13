<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CourseScoreSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        DB::table('course_scores')->truncate();
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        DB::table('course_scores')->insert([
            'course_id'=>1,
            'semester'=>1,
            'parent_id'=>NULL,
            'mark'=>10,
            'title'=>'平時分',
        ]);
        DB::table('course_scores')->insert([
            'course_id'=>1,
            'semester'=>1,
            'parent_id'=>1,
            'mark'=>6,
            'title'=>'平時分1',
        ]);
        DB::table('course_scores')->insert([
            'course_id'=>1,
            'semester'=>1,
            'parent_id'=>1,
            'mark'=>4,
            'title'=>'平時分2',
        ]);
        DB::table('course_scores')->insert([
            'course_id'=>1,
            'semester'=>1,
            'parent_id'=>3,
            'mark'=>4,
            'title'=>'平時分22',
        ]);
        DB::table('course_scores')->insert([
            'course_id'=>1,
            'semester'=>1,
            'parent_id'=>NULL,
            'mark'=>15,
            'title'=>'測驗分',
        ]);
        DB::table('course_scores')->insert([
            'course_id'=>1,
            'semester'=>1,
            'parent_id'=>5,
            'mark'=>15,
            'title'=>'平時分2',
        ]);

    }
}
