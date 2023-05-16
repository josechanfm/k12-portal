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
use App\Models\Config;

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
        //$courses=$klass->courses->map->only('id','title_zh','score_columns');
        $courses=$klass->courses;

        $scores=$students;
        foreach($students as $sid=>$student){
            foreach($courses as $course){
                $course['terms']=Config::item('year_terms');
                foreach($course->terms as $term){
                    $term->columns=array_reduce(json_decode($course->scoreColumns,true),function($carry, $key) use($term){
                        if($key['term_id']==$term->value) $carry++;
                        return $carry;
                    }, 0);
                };
                foreach($course->scoreColumns as $column){
                    $scores[$sid][$course->id][$column->id]='';
                }
            }
        };
        // echo json_encode($courses);
        // echo '<hr>';
        // return;
        $coursesScores=$klass->coursesScores;
        //echo json_encode($coursesScores);
        foreach($coursesScores as $cs){
            foreach($cs->all_scores as $s){
                $scores[$s->student_id][$cs->id][$s->score_column_id]=$s->point;
            }
        }
    //    echo json_encode($scores);
    //     return ;
        return Inertia::render('Manage/ScoreBigTable',[
            'students_courses_scores'=>$students,
            'courses'=>$klass->courses,
            'scores'=>$scores
        ]);
    }
}
