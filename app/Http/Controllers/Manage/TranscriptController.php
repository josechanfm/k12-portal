<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\KlassStudent;
use App\Models\Transcript;
use App\Models\TranscriptTemplate;
use App\Models\Klass;
use App\Models\Course;

class TranscriptController extends Controller
{
    public function index(){
        $transcriptTemplate=TranscriptTemplate::all();
        $transcript=Transcript::where('klass_student_id',1)->get();
        // return response($transcriptTemplate);
        return Inertia::render('Manage/Transcript',[
            'transcriptTemplate'=>$transcriptTemplate,
            'transcript'=>$transcript
        ]);
    }

    public function KlassStudent($id){
        $klassStudent=KlassStudent::find($id);
        return response($klassStudent);

    }
    public function klass(Klass $klass){
        $scores=[];
        $students=$klass->students;
        $coursesStudents=$klass->coursesStudents;
        dd($students);
        foreach($students as $student){
            $scores[$student->id]=array("name_zh"=>$student->name_zh);
            foreach($coursesStudents as $course){
                foreach($course->students as $s){
                    if($s->id==$student->id){
                        $scores[$student->id][$course->id]=$s->pivot->course_student_id;
                    }
                }
            }
        }
        echo json_encode($scores);
        echo '<hr>';
        $coursesStudents=$klass->coursesScores;
        echo json_encode($coursesStudents);
        return true;

        $studentsCoursesScores=$klass->studentsCoursesScores;
        dd($studentsCoursesScores);

        return Inertia::render('Manage/ScoreBigTable',[
            'students_courses_scores'=>$studentsCoursesScores,
            'courses'=>$klass->courses
        ]);

        $courses=Course::whereBelongsTo($klass)->with('scores')->with('students')->orderBy('id')->get();
        foreach($courses as $course){
            //echo json_encode($course);
            foreach($course->scores as $score){
                echo json_encode($score);
                echo '<hr>';
            }
            echo '<hr>';
        }
        //dd($klass->scores);
    }
}
