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
        $students=array_column($klass->students->map->only('id','name_zh')->toArray(),null,'id');
        $courses=$klass->courses->map->only('id','title_zh');
        $scores=$students;
        foreach($students as $i=>$student){
            foreach($courses as $course){
                $scores[$i][$course['id']]='';
            }
        };
        // echo json_encode($courses);
        // echo '<hr>';
        $coursesScores=$klass->coursesScores;
        echo json_encode($coursesScores);
        foreach($coursesScores as $cs){
            foreach($cs->all_scores as $s){
                $scores[$s->student_id][$cs->id]=$s->point;
            }
        }
        echo json_encode($scores);
        return Inertia::render('Manage/ScoreBigTable',[
            'students_courses_scores'=>$students,
            'courses'=>$klass->courses
        ]);
    }
}
