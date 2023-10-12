<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\KlassStudent;
use App\Models\Transcript;
use App\Models\TranscriptTemplate;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;
use App\Models\Config;

use function GuzzleHttp\json_decode;

class TranscriptController extends Controller
{
    public function yearTranscripts(Year $year){
        dd($year->gradesKlasses[0]->klasses[0]);
    }
    public function gradeTranscripts(Grade $grade){
        dd($grade);
    }

    public function KlassStudent(KlassStudent $klassStudent){
        dd($klassStudent->student);
        $klassStudent=KlassStudent::find($klassStudentId);
        dd($klassStudent);
        return Inertia::render('Manage/Transcript',[
            'transcriptTemplate'=>$id,
            'student'=>$klassStudent
        ]);
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
                    $scores[$sid][$course->id][$column->id]=['point'=>0,'is_total'=>false,'term_id'=>$column->term_id,'field_name'=>$column->field_name];
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

        $year=Year::find(Year::currentYear()->id);
        $year->klasses;
        $year->grades;
        $transcripts=$klass->transcripts();
        //dd($transcripts['courses'][0]);
        if($request->get('type') && $request->get('type')=='summary'){
            return Inertia::render('Manage/TranscriptSummary',[
                'year'=>$year,
                'klass'=>$klass,
                'year_terms'=>Config::item('year_terms'),
                // 'students_courses_scores'=>$transcripts['students'],
                // 'courses'=>$transcripts['courses'],
                // 'scores'=>$transcripts['scores'],
                'transcripts'=>$transcripts,
                // 'students_courses_scores'=>$students,
                // 'courses'=>$klass->courses,
                // 'scores'=>$scores,
                //'behaviours'=>$klass->behaviourSummary()
            ]);
        }else{
            return Inertia::render('Manage/TranscriptBigTable',[
                'year'=>$year,
                'klass'=>$klass,
                'year_terms'=>Config::item('year_terms'),
                'students_courses_scores'=>$transcripts['students'],
                'courses'=>$transcripts['courses'],
                'scores'=>$transcripts['scores'],
                'behaviours'=>$klass->behaviourSummary(),
                'transcripts'=>$transcripts
            ]);
        }
    }

    public function migrate(Klass $klass)
    {
        $transcripts=$klass->transcripts();
        dd($transcripts);
        $templateGroups=$klass->grade->transcriptTemplates();
        $yearTerms=Config::item('year_terms');
        //behaviours to transcripts
        $data=[];
        foreach($transcripts['students'] as $ksid=>$student){
            foreach($yearTerms as $term){
                $data[]=[
                    'klass_student_id'=>$ksid,
                    'term_id'=>$term->value,
                    'field_name'=>'BEHAVIOUR',
                    'category'=>'BEHAVIOUR',
                    'reference_code'=>'BEHAVIOUR',
                    'value'=>$transcripts['behaviours'][$ksid][$term->value]
                ];
            }
        }
        //dd($data);
        Transcript::upsert($data, ['klass_student_id','term_id','field_name','reference_code'],['value']);
        //Subject score to transcripts
        $data=[];
        foreach($transcripts['students'] as $ksid=>$student){
            //foreach($templateGroups['SUBJECT'] as $template){
                foreach($yearTerms as $term){
                    foreach($transcripts['courses'] as $course){
                        if(isset($templateGroups['SUBJECT'][$course->code])){
                            // $columns=array_column($course->scoreColumns->where('for_transcript',true)->where('course_id',$course->id)->where('term_id',$term->value)->toArray(),null,'field_name');
                            // dd($columns);
                            foreach($course->scoreColumns->where('for_transcript',true)->where('course_id',$course->id)->where('term_id',$term->value) as $column){
                                // echo '<br>';
                                // echo '<br>';
                                //echo json_encode($column);
                                $data[]=[
                                    'klass_student_id'=>$ksid,
                                    'term_id'=>$term->value,
                                    'field_name'=>$column->field_name,
                                    'category'=>'SUBJECT',
                                    'reference_code'=>$course->code,
                                    'value'=>$transcripts['scores'][$ksid][$course->id][$column->id]['point']
                                ];
                            }
                        }
                    }
                    // echo '<hr>';
                }
            //}
            //dd($transcripts['scores'][$ksid]);
        }
        
        Transcript::upsert($data, ['klass_student_id','term_id','field_name','reference_code'],['value']);
        $klass->transcript_migrated=true;
        $klass->save();
        return response()->json($data);
    }    

}
