<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;

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
        
        for($g=1;$g<=12;$g++){
            $grade=Grade::find($g);
            foreach($initial as $ini){
                // DB::table('klasses')->insert([
                //KlassObserver will autometically create course according to study plan with subjects
                Klass::create([
                    'grade_id'=>$g,
                    'letter'=>$ini,
                    'tag'=>$grade->tag.$ini,
                    'study_id'=>1
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


        $courses=Klass::where('tag','P1A')->first()->courses;
        $students=Klass::where('tag','P1A')->first()->students;
        foreach($courses as $course){
            foreach($students as $student){
                DB::table('course_student')->insert([
                    'course_id'=>$course->id,
                    'student_id'=>$student->id
                ]);
            }
        }


    }
}
