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
use PDF;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

use function GuzzleHttp\json_decode;

class TranscriptController extends Controller
{
    public function yearTranscripts(Year $year){
        dd($year->gradesKlasses[0]->klasses[0]);
    }
    public function gradeTranscripts(Grade $grade){
        dd($grade);
    }
    public function generateTranscripts(Klass $klass){
        $yearCode=$klass->grade->year->code;
        $pathTofile='app/public/2021/P1A/1_7e41808a-ea84-44cb-8c8b-e8ec84222e67.pdf';
        return response()->download(storage_path($pathTofile), null, [], null);
        return response()->file(
            Storage::disk('local')->get($pathTofile),
            ['content-type'=>'application/pdf']
        );

        return response()->file(storage_path($pathTofile),['content-type'=>'application/pdf']);

        return response()->file($pathTofile);
        dd($yearCode);
    }

    public function KlassStudent(KlassStudent $klassStudent){
        $templates=$klassStudent->klass->grade->transcriptTemplates();
        //dd($templates);
        $transcripts=array_column(Transcript::where('klass_student_id',$klassStudent->id)->get()->toArray(),null,'transcript_template_id');
        dd('no transcripts record will prompt error!');
        // dd($transcripts);
        $klassStudent->student;
        $pathTofile=$klassStudent->klass->grade->year->code.'/'.$klassStudent->klass->tag.'/'.$klassStudent->student_number.'_'.(String) Str::uuid().'.pdf';
        // dd($pathTofile);
        $pdf=PDF::loadView('pdf.transcript',[
            'templates'=>$templates,
            'klassStudent'=>$klassStudent,
            'transcripts'=>$transcripts
        ]);
        Storage::disk('public')->put(
            $pathTofile,
            $pdf->output()
        );
        

        // $pdf->render();
        // $fileName='transcripts_'.$klassStudent->klass->grade->year_id.'_'.$klassStudent->klass->ta.'.pdf';
        // return $pdf->stream($fileName,array('Attachment'=>false));
    }

    public function klass(Klass $klass, Request $request){
        $year=Year::find(Year::currentYear()->id);
        $year->klasses;
        $year->grades;
        $transcriptsScores=$klass->transcriptsScores();
        if($request->get('type') && $request->get('type')=='summary'){
            return Inertia::render('Manage/KlassTranscriptsSummary',[
                'year'=>$year,
                'klass'=>$klass,
                'year_terms'=>Config::item('year_terms'),
                'transcriptsScores'=>$transcriptsScores,
            ]);
        }else{
            return Inertia::render('Manage/KlassTranscriptsBigTable',[
                'year'=>$year,
                'klass'=>$klass,
                'year_terms'=>Config::item('year_terms'),
                'students_courses_scores'=>$transcriptsScores['students'],
                'transcriptsScores'=>$transcriptsScores
            ]);
        }
    }

    public function migrate(Klass $klass)
    {
        $klassCourses=array_column($klass->courses->toArray(),null,'code');
        $templateCategories=$klass->grade->transcriptTemplates();
        $klassScores=$klass->transcriptsScores()['scores'];
        foreach($klass->students as $student){
            $ksid=$student->pivot->klass_student_id;
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
            foreach($templateCategories['SUBJECT'] as $courseCode=>$termCourses){
                foreach($termCourses as $termId=>$courseFieldName){
                    foreach($courseFieldName as $fieldName){
                        if(isset($klassCourses[$fieldName['reference_code']])){
                            $course=$klassCourses[$fieldName['reference_code']];
                            foreach($course['score_columns'] as $column){
                                $data[]=[
                                    'klass_student_id'=>$ksid,
                                    'transcript_template_id'=>$fieldName['id'],
                                    'value'=>$klassScores[$ksid][$course['id']][$column['id']]['point']??''
                                ];
                            }
                        }
                    }
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
