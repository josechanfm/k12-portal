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
        // $subjects=Subject::where('grade_id',1)->get();
        // $klasses=Klass::take(2)->get();
        // foreach($klasses as $klass){
        //     foreach($subjects as $subject){
        //         Course::create([
        //             'klass_id'=>$klass->id,
        //             'code'=>$subject->code,
        //             'title_zh'=>$subject->title_zh,
        //             'title_en'=>$subject->title_en,
        //             'stream'=>$subject->stream,
        //             'elective'=>$subject->elective,
        //             'active'=>$subject->active,
        //             'study_id'=>$subject->id
        //         ]);
        //     }
        // }
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
