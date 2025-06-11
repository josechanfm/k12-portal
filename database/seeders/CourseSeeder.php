<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Student;

class CourseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $courses=[
            ['code'=>'CHN','title_zh'=>'中文','in_transcript'=>true,'unit'=>2],
            ['code'=>'ENG','title_zh'=>'英文','in_transcript'=>true,'unit'=>2],
            ['code'=>'MAT','title_zh'=>'數學','in_transcript'=>true,'unit'=>2],
            ['code'=>'PHY','title_zh'=>'物理','in_transcript'=>true,'unit'=>2],
            ['code'=>'CHM','title_zh'=>'化學','in_transcript'=>true,'unit'=>2],
        ];
        $students=Student::all();
        foreach($students as $student){
            $student->courses()->createMany($courses);
        }
    }
}
