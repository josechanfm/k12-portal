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
use PhpParser\Builder\Trait_;

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
        $templates=$klassStudent->klass->grade->transcriptTemplates();
        $student=$klassStudent->student;
        //dd($klassStudent);
        //dd($template['PERSONAL']['name_zh']);
        //$template['PERSONAL']['name_zh']['value']='abc';
        //dd($templates);

        //dd($transcripts);
        $data=[];
        //dd($data['PERSONAL']['name_zh']);
        foreach($templates['SUMMARY'] as $key=>$template){
            $data['SUMMARY'][$key]=
                Transcript::where('klass_student_id',$klassStudent->id)
                    ->where('field_name',$key)
                    ->first()->value;
        };
        foreach($templates['PERSONAL'] as $key=>$template){
            $data['PERSONAL'][$key]=
                Transcript::where('klass_student_id',$klassStudent->id)
                    ->where('field_name',$key)
                    ->first()->value;
        };
        foreach($templates['GENERAL'] as $key=>$template){
            $terms=Transcript::select('term_id')->where('klass_student_id',$klassStudent->id)
                ->where('reference_code',$key)
                ->groupBy('term_id')
                ->get()->pluck('term_id');
            foreach($terms as $term){
                $data['GENERAL'][$term][$key]=
                    Transcript::where('klass_student_id',$klassStudent->id)
                        ->where('term_id',$term)
                        ->where('field_name',$key)
                        ->first()->value;
            }
        };
        foreach($templates['SUBJECT'] as $key=>$template){
            // dd($template);
            $terms=Transcript::select('term_id')->where('klass_student_id',$klassStudent->id)
                ->where('reference_code',$key)
                ->groupBy('term_id')
                ->get()->pluck('term_id');
            foreach($terms as $term){
                $data['SUBJECT'][$term][$key]=
                array_column(
                    Transcript::where('klass_student_id',$klassStudent->id)
                        ->where('term_id',$term)
                        ->where('reference_code',$key)
                        ->get()->toArray(),
                    'value',
                    'field_name'
                );
            }
        }
        //dd($data);
        return Inertia::render('Manage/StudentTranscript',[
            // 'yearTerms'=>Config::item('year_terms'),
            // 'transcriptTemplates'=>$transcriptTemplates,
            // 'transcripts'=>$transcripts,
            'templates'=>$templates,
            'klassStudent'=>$klassStudent,
            'fields'=>$data
        ]);

    }
    public function klass(Klass $klass, Request $request){
        $year=Year::find(Year::currentYear()->id);
        $year->klasses;
        $year->grades;
        $transcripts=$klass->transcripts();
        if($request->get('type') && $request->get('type')=='summary'){
            return Inertia::render('Manage/KlassTranscriptsSummary',[
                'year'=>$year,
                'klass'=>$klass,
                'year_terms'=>Config::item('year_terms'),
                'transcripts'=>$transcripts,
            ]);
        }else{
            return Inertia::render('Manage/KlassTranscriptsBigTable',[
                'year'=>$year,
                'klass'=>$klass,
                'year_terms'=>Config::item('year_terms'),
                'students_courses_scores'=>$transcripts['students'],
                'transcripts'=>$transcripts
            ]);
        }
    }

    public function migrate(Klass $klass)
    {
        $transcripts=$klass->transcripts();
        $templateGroups=$klass->grade->transcriptTemplates();
        //dd($templateGroups);
        $yearTerms=Config::item('year_terms');

        //SUMMARY category data
        $data=[];
        foreach($transcripts['students'] as $ksid=>$student){
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'SUMMARY',
                'reference_code'=>'total_score',
                'field_name'=>'total_score',
                'value'=>''
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'SUMMARY',
                'reference_code'=>'average_score',
                'field_name'=>'average_score',
                'value'=>''
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'SUMMARY',
                'reference_code'=>'class_size',
                'field_name'=>'class_size',
                'value'=>''
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'SUMMARY',
                'reference_code'=>'ranking',
                'field_name'=>'ranking',
                'value'=>''
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'SUMMARY',
                'reference_code'=>'late',
                'field_name'=>'late',
                'value'=>''
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'SUMMARY',
                'reference_code'=>'absent',
                'field_name'=>'absent',
                'value'=>''
            ];
        };
        Transcript::upsert(
            $data, 
            ['klass_student_id','term_id','category','reference_code','field_name'],
            ['value']
        );

        //GENERAL category data
        $data=[];
        foreach($transcripts['students'] as $ksid=>$student){
            foreach($yearTerms as $term){
                foreach($templateGroups['GENERAL'] as $referenceCode=>$template){
                    $data[]=[
                        'klass_student_id'=>$ksid,
                        'term_id'=>$term->value,
                        'category'=>'GENERAL',
                        'reference_code'=>$referenceCode,
                        'field_name'=>$referenceCode,
                        'value'=>''
                    ];
                };
            }
        };
        Transcript::upsert(
            $data, 
            ['klass_student_id','term_id','category','reference_code','field_name'],
            ['value']
        );

        //PERSONAL category data
        $data=[];
        foreach($transcripts['students'] as $ksid=>$student){
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'PERSONAL',
                'reference_code'=>'name_ch',
                'field_name'=>'name_ch',
                'value'=>$student->name_zh
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'PERSONAL',
                'reference_code'=>'name_fn',
                'field_name'=>'name_fn',
                'value'=>$student->name_fn
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'PERSONAL',
                'reference_code'=>'academic_year',
                'field_name'=>'academic_year',
                'value'=>''
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'PERSONAL',
                'reference_code'=>'grade_class',
                'field_name'=>'grade_class',
                'value'=>''
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'PERSONAL',
                'reference_code'=>'student_number',
                'field_name'=>'student_number',
                'value'=>$student->pivot->student_number
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'PERSONAL',
                'reference_code'=>'id_number',
                'field_name'=>'id_number',
                'value'=>''
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'term_id'=>9,
                'category'=>'PERSONAL',
                'reference_code'=>'issue_date',
                'field_name'=>'issue_date',
                'value'=>''
            ];
        }
        //dd($data);
        Transcript::upsert(
            $data, 
            ['klass_student_id','term_id','category','reference_code','field_name'],
            ['value']
        );
        //behaviours to transcripts, only apply for grade year 1-3
        /*
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
        Transcript::upsert(
            $data, 
            ['klass_student_id','term_id','field_name','reference_code'],
            ['value']
        );
        */
        //SUBJECT category data
        $data=[];
        foreach($transcripts['students'] as $ksid=>$student){
                foreach($yearTerms as $term){
                    foreach($transcripts['courses'] as $course){
                        if(isset($templateGroups['SUBJECT'][$course->code])){
                            foreach($course->scoreColumns->where('for_transcript',true)->where('course_id',$course->id)->where('term_id',$term->value) as $column){
                                $data[]=[
                                    'klass_student_id'=>$ksid,
                                    'term_id'=>$term->value,
                                    'category'=>'SUBJECT',
                                    'reference_code'=>$course->code,
                                    'field_name'=>$column->field_name,
                                    'value'=>$transcripts['scores'][$ksid][$course->id][$column->id]['point']??0
                                ];
                            }
                        }
                    }
                }
        }
        Transcript::upsert($data, ['klass_student_id','term_id','field_name','reference_code'],['value']);
        
        
        $klass->transcript_migrated=true;
        $klass->save();
        $result=[
            'transcript template ID:'=>$klass->grade->transcript_template_id,
            'transcript Template:'=>array_keys($templateGroups->toArray()),
            'students count:'=>count($transcripts['students']),
            'total records:'=>count($data)
        ];
        dd($result);
        return response()->json($result);
        return response()->json($data);
    }    

}
