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

use function GuzzleHttp\json_decode;

class TranscriptController extends Controller
{
    public function index(Klass $klass){
        $coursesScores=$klass->transcriptCoursesScores;//all Courses in transcript with scores
        $students=$klass->students; //all student in the klass
        $courses=$klass->courses->where('in_transcript',1); //all Courses in the klass with score_columns

        //rebuild all scores in an array, index with student_id, course_id and score_column_id
        $tmpScores=[];
        foreach($coursesScores as $course){
            foreach($course->allScores as $score){
                $tmpScores[$score->student_id][$course->id][$score->score_column_id]=$score->point;
            }
        }

        //generate student list with personal info required in transcript
        //loop all scores in term_id==9 in all courses and put it in student array list
        $list=[];
        foreach($students as $student){
            $list[$student->id]['student_name']=$student->name_zh;
            $list[$student->id]['klass_student_id']=$student->pivot->klass_student_id;
            foreach($courses as $course){
                $scoreColumnId=$course->scoreColumns->where('term_id',9)->first()->id;
                $list[$student->id]['scores'][$scoreColumnId]=$tmpScores[$student->id][$course->id][$scoreColumnId];
            }
            // echo json_encode($student);
            // echo '<br>';
        }
        echo json_encode($list);
        echo '<hr>';
        // dd('done');
        echo '<hr>';
        dd('done');
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
    public function klass(Klass $klass, Request $request){
        $scores=[];
        //convert students record to associative array and set Record Id as key
        $students=array_column($klass->students->map->only('id','name_zh')->toArray(),null,'id');
        $courses=$klass->courses;

        $scores=$students;
        //form score table
        //score array table: $scores[student_id][course_id][term_id][score_column_id]
        foreach($students as $sid=>$student){
            foreach($courses as $course){
                $course['terms']=array_column(Config::item('year_terms'),null,'value');
                foreach($course->terms as $term){
                    //count number of columns in course by term_id
                    //this number of columns in course by terms,
                    //is use for merge table header cell
                    $term->column_count=array_reduce(json_decode($course->scoreColumns,true),function($carry, $key) use($term){
                        if($key['term_id']==$term->value) $carry++;
                            return $carry;
                    }, 0);
                    $term->total_column=0;
                };
                
                //create score array columns and init as empty value
                //$scores[$sid]['terms']=$course['terms'];
                //$scores[$sid]['terms'][$column->term_id]->score_columns[]=$column->id;
                foreach($course->scoreColumns as $column){
                    $scores[$sid][$course->id][$column->id]=['point'=>0,'is_total'=>false,'term_id'=>$column->term_id];
                    
                    if($column->is_total==1){
                        //$course['terms'][$column->term_id]->total_column=$column->id;
                        // $scores[$sid][$course->id]['terms'][$column->term_id]['score_columns'][]=$column->id;
                        $scores[$sid][$course->id][$column->id]['is_total']=true;
                    }
                }
            }
        };
        $coursesScores=$klass->coursesScores;
        //assign score value to the score array 
        foreach($coursesScores as $cs){
            foreach($cs->allScores as $s){
                $scores[$s->student_id][$cs->id][$s->score_column_id]['point']=$s->point;
            }
        }

        if($request->get('type') && $request->get('type')=='summary'){
            return Inertia::render('Manage/ScoreSummary',[
                'year_terms'=>Config::item('year_terms'),
                'students_courses_scores'=>$students,
                'courses'=>$klass->courses,
                'scores'=>$scores
            ]);
        }else{
            return Inertia::render('Manage/ScoreBigTable',[
                'students_courses_scores'=>$students,
                'courses'=>$klass->courses,
                'scores'=>$scores
            ]);
    
        }
    }
}
