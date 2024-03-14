<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;
use App\Models\Course;

class KlassSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {


        $initial=['A','B','C','D','E'];
        $grades=Grade::where('year_id',1)->get();
        foreach($grades as $grade){
            foreach($initial as $ini){
                // DB::table('klasses')->insert([
                //KlassObserver will autometically create course according to study plan with subjects
                Klass::create([
                    'grade_id'=>$grade->id,
                    'letter'=>$ini,
                    'tag'=>$grade->tag.$ini,
                    'study_id'=>1,
                    'klass_head_ids'=>[rand(1,50)]
                ]);
            }

        }

        //enroll student in to Klass
        $year=Year::currentYear();
        $studentId=1;
        $grades=Grade::where('year_id',$year->id)->get();
        foreach ($grades as $grade) {
            // echo json_encode($grade);
            $klasses=Klass::where('grade_id',$grade->id)->get();
            // echo json_encode($klasses);
            foreach ($klasses as $klass) {
                for($i=1;$i<=21;$i++){
                    DB::table('klass_student')->insert([
                        'klass_id' => $klass->id,
                        'student_id' => $studentId++,
                        'student_number'=>$i
                    ]);
                }
            }
        }


        $courses=Course::all();
        foreach($courses as $c=>$course){
            $course->subject_head_ids=[rand(1,50)];
            $course->save();
            $course->staffs()->attach(rand(1,50));
            $klass=Klass::find($course->klass_id);
            $students=$klass->students->pluck('id')->toArray();
            $course->students()->sync($students);
        }


    }
}
