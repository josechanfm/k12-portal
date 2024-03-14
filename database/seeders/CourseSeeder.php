<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CourseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        
        for($c=1;$c<=10;$c++){
            for($s=1;$s<=21;$s++){
                DB::table('course_student')->insert([
                    'course_id'=>$c,
                    'student_id'=>$s
                ]);
            }
        }
    }
}
