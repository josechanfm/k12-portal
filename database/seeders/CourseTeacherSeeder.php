<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CourseTeacherSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        for($c=1;$c<=10;$c++){
            DB::table('course_teacher')->insert([
                'course_id'=>$c,
                'staff_id'=>$c+10
            ]);
        }
    }
}
