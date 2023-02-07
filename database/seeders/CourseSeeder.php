<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Year;
use App\Models\Subject;
use App\Models\Course;
use App\Models\Klass;

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
    }
}
