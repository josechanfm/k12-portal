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
        //dd($klassStudent->klass->grade);
        //$templates=array_column(TranscriptTemplate::where('template_id',$klassStudent->klass->grade->transcript_template_id)->get()->toArray(),null,'id');
        //dd($templates);
        $transcripts=array_column(Transcript::where('klass_student_id',$klassStudent->id)->get()->toArray(),null,'transcript_template_id');
        // foreach($transcripts as $transcript){
        //     $templates[$transcript['transcript_template_id']]['value']=$transcript['value'];
        // }
        //dd($transcripts);
        
        $student=$klassStudent->student;
        //dd($klassStudent);
        //dd($template['PERSONAL']['name_zh']);
        //$template['PERSONAL']['name_zh']['value']='abc';
        //dd($templates);

        //dd($transcripts);
        $data=[];
        //dd($data['PERSONAL']['name_zh']);
        // foreach($templates['SUMMARY'] as $key=>$template){
        //     $data['SUMMARY'][$key]=
        //         Transcript::where('klass_student_id',$klassStudent->id)
        //             ->where('field_name',$key)
        //             ->first()->value;
        // };
        // foreach($templates['PERSONAL'] as $key=>$template){
        //     $data['PERSONAL'][$key]=
        //         Transcript::where('klass_student_id',$klassStudent->id)
        //             ->where('field_name',$key)
        //             ->first()->value;
        // };
        // foreach($templates['GENERAL'] as $key=>$template){
        //     $terms=Transcript::select('term_id')->where('klass_student_id',$klassStudent->id)
        //         ->where('reference_code',$key)
        //         ->groupBy('term_id')
        //         ->get()->pluck('term_id');
        //     foreach($terms as $term){
        //         $data['GENERAL'][$term][$key]=
        //             Transcript::where('klass_student_id',$klassStudent->id)
        //                 ->where('term_id',$term)
        //                 ->where('field_name',$key)
        //                 ->first()->value;
        //     }
        // };
        // foreach($templates['SUBJECT'] as $key=>$template){
        //     // dd($template);
        //     $terms=Transcript::select('term_id')->where('klass_student_id',$klassStudent->id)
        //         ->where('reference_code',$key)
        //         ->groupBy('term_id')
        //         ->get()->pluck('term_id');
        //     foreach($terms as $term){
        //         $data['SUBJECT'][$term][$key]=
        //         array_column(
        //             Transcript::where('klass_student_id',$klassStudent->id)
        //                 ->where('term_id',$term)
        //                 ->where('reference_code',$key)
        //                 ->get()->toArray(),
        //             'value',
        //             'field_name'
        //         );
        //     }
        // }
        //dd($data);
        return Inertia::render('Manage/StudentTranscript2',[
            // 'yearTerms'=>Config::item('year_terms'),
            // 'transcriptTemplates'=>$transcriptTemplates,
            // 'transcripts'=>$transcripts,
            'templates'=>$templates,
            'klassStudent'=>$klassStudent,
            'fields'=>$data,
            'transcripts'=>$transcripts
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
        //dd($klass);
        $yearTerms=Config::item('year_terms');
        $transcripts=$klass->transcripts();
        //dd($transcripts['scores'][316][153]);
        //dd($transcripts['courses']);
        //dd($transcripts);
       
        $templateCategories=$klass->grade->transcriptTemplates();
        //$templateCategories=$templateCategories->jsonSerialize();
        //dd($templateCategories);
        foreach($transcripts['students'] as $ksid=>$student){
            $data=[];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['name_zh']['id'],
                'value'=>$student->name_zh
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['name_fn']['id'],
                'value'=>$student->name_fn
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['academic_year']['id'],
                'value'=>Year::find($student->pivot->pivotParent->grade->year_id)->title
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['grade_class']['id'],
                'value'=>$student->pivot->pivotParent->grade->tag
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['student_number']['id'],
                'value'=>$student->pivot->student_number
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['id_number']['id'],
                'value'=>'birm_number'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['issue_date']['id'],
                'value'=>'birm issue date'
            ];

            //SUMMARY
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['total_score']['id'],
                'value'=>'0'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['average_score']['id'],
                'value'=>'0'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['class_size']['id'],
                'value'=>'0'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['ranking']['id'],
                'value'=>'0'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['late']['id'],
                'value'=>'0'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['absent']['id'],
                'value'=>'0'
            ];
            //Exception for template based
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['APPRAISAL']['appraisal']['id'],
                'value'=>'---'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PASSING']['passing']['id'],
                'value'=>'50'
            ];

            //GENERAL
            foreach($templateCategories['GENERAL'] as $termId=>$general){
                foreach($general as $referenceCode=>$item){
                    $data[]=[
                        'klass_student_id'=>$ksid,
                        'transcript_template_id'=>$item->id,
                        'value'=>'0'
                    ];
                };
            }
            //SUBJECT scores
            foreach($templateCategories['SUBJECT'] as $termId=>$subjects){
                foreach($subjects as $subject){
                    foreach($subject as $field){
                        foreach($transcripts['courses'] as $course){
                            if($course->code==$field['reference_code'] && $course['in_transcript']==true){
                                foreach($course->scoreColumns as $scoreColumn){
                                    if($scoreColumn->field_name==$field['field_name']){
                                        $data[]=[
                                            'klass_student_id'=>$ksid,
                                            'transcript_template_id'=>$field['id'],
                                            'value'=>$transcripts['scores'][$ksid][$course->id][$scoreColumn->id]['point']??0
                                        ];
                                    }
                                }
                            }
                        }
                        //dd($transcripts['courses']->where('code',$field['reference_code'])->get());
                    }
                    //dd($transcript['courses']->where('code',));
                };
            }
            Transcript::upsert(
                $data, 
                ['klass_student_id','transcript_template_id'],
                ['value']
            );
        }
        dd($data);
    }    

}
