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
        $transcripts=array_column(Transcript::where('klass_student_id',$klassStudent->id)->orderBy('transcript_template_id')->get()->toArray(),null,'transcript_template_id');
        $klassStudent->student;
        $fileDisk='profile';
        $filePath=$klassStudent->klass->grade->year->code.'/'.$klassStudent->klass->tag;
        $fileName=$klassStudent->student_number.'_'.(String) Str::uuid().'.pdf';
        $fileType='transcript_year';

        
        $klassStudent->archives()->updateOrCreate(
            [
                'file_type'=>$fileType
            ],
            [
                'file_type'=>$fileType,
                'original_name'=>'original_name',
                'file_name'=>$fileName,
                'file_path'=>'/'.$fileDisk.'/'.$filePath.'/'.$fileName
            ]
        );
        $pdf=PDF::loadView('pdf.transcript',[
            'templates'=>$templates,
            'klassStudent'=>$klassStudent,
            'transcripts'=>$transcripts
        ]);
        
        Storage::disk($fileDisk)->put(
            $filePath.'/'.$fileName,
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
        //dd($templateCategories);
        $klassScores=$klass->transcriptsScores()['scores'];
        // dd($klassScores[316]);
        foreach($klass->students as $student){
            $ksid=$student->pivot->klass_student_id;
            $data=[];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['name_zh']['id'],
                'term_id'=>9,
                'category'=>'PERSONAL',
                'column'=>null,
                'reference_code'=>'name_zh',
                'field_name'=>null,
                'value'=>$student->name_zh
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['name_fn']['id'],
                'term_id'=>9,
                'category'=>'PERSONAL',
                'column'=>null,
                'reference_code'=>'name_fn',
                'field_name'=>null,
                'value'=>$student->name_fn
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['academic_year']['id'],
                'term_id'=>9,
                'category'=>'PERSONAL',
                'column'=>null,
                'reference_code'=>'academic_year',
                'field_name'=>null,
                'value'=>Year::find($student->pivot->pivotParent->grade->year_id)->title
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['grade_class']['id'],
                'term_id'=>9,
                'category'=>'PERSONAL',
                'column'=>null,
                'reference_code'=>'grade_class',
                'field_name'=>null,
                'value'=>$student->pivot->pivotParent->grade->tag
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['student_number']['id'],
                'term_id'=>9,
                'category'=>'PERSONAL',
                'column'=>null,
                'reference_code'=>'student_number',
                'field_name'=>null,
                'value'=>$student->pivot->student_number
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['id_number']['id'],
                'term_id'=>9,
                'category'=>'PERSONAL',
                'column'=>null,
                'reference_code'=>'id_number',
                'field_name'=>null,
                'value'=>isset($student->identity_documents()['BIRM'])?$student->identity_documents()['BIRM']['number']:'null'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PERSONAL']['issue_date']['id'],
                'term_id'=>9,
                'category'=>'PERSONAL',
                'column'=>null,
                'reference_code'=>'issue_date',
                'field_name'=>null,
                'value'=>isset($student->identity_documents()['BIRM'])?$student->identity_documents()['BIRM']['issue_date']:'null'
            ];

            //SUMMARY
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['total_score']['id'],
                'term_id'=>9,
                'category'=>'SUMMARY',
                'column'=>null,
                'reference_code'=>'total_score',
                'field_name'=>null,
                'value'=>'0'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['average_score']['id'],
                'term_id'=>9,
                'category'=>'SUMMARY',
                'column'=>null,
                'reference_code'=>'average_score',
                'field_name'=>null,
                'value'=>'0'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['class_size']['id'],
                'term_id'=>9,
                'category'=>'SUMMARY',
                'column'=>null,
                'reference_code'=>'class_size',
                'field_name'=>null,
                'value'=>'0'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['ranking']['id'],
                'term_id'=>9,
                'category'=>'SUMMARY',
                'column'=>null,
                'reference_code'=>'ranking',
                'field_name'=>null,
                'value'=>'0'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['late']['id'],
                'term_id'=>9,
                'category'=>'SUMMARY',
                'column'=>null,
                'reference_code'=>'late',
                'field_name'=>null,
                'value'=>'0'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['SUMMARY']['absent']['id'],
                'term_id'=>9,
                'category'=>'SUMMARY',
                'column'=>null,
                'reference_code'=>'absent',
                'field_name'=>null,
                'value'=>'0'
            ];
            //Exception for template based
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['APPRAISAL']['appraisal']['id'],
                'term_id'=>9,
                'category'=>'SUMMARY',
                'column'=>null,
                'reference_code'=>'appraisal',
                'field_name'=>null,
                'value'=>'---'
            ];
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PASSING']['passing']['id'],
                'term_id'=>9,
                'category'=>'SUMMARY',
                'column'=>null,
                'reference_code'=>'passing',
                'field_name'=>null,
                'value'=>'50'
            ];

            //GENERAL
            foreach($templateCategories['GENERAL'] as $termId=>$general){
                foreach($general as $referenceCode=>$item){
                    $data[]=[
                        'klass_student_id'=>$ksid,
                        'transcript_template_id'=>$item->id,
                        'term_id'=>$termId,
                        'category'=>'GENERAL',
                        'column'=>null,
                        'reference_code'=>$referenceCode,
                        'field_name'=>null,
                        'value'=>$item->value
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
                                    'term_id'=>$termId,
                                    'category'=>'SUBJECT',
                                    'column'=>null,
                                    'reference_code'=>$fieldName['reference_code'],
                                    'field_name'=>$fieldName['field_name'],
                                    'value'=>$klassScores[$ksid][$course['id']][$column['id']]['point']??''
                                ];
                            }
                        }
                    }
                };
            }
            $data[]=[
                'klass_student_id'=>$ksid,
                'transcript_template_id'=>$templateCategories['PASSING']['passing']['id'],
                'term_id'=>9,
                'category'=>'APPRAISAL',
                'column'=>null,
                'reference_code'=>'appraisal',
                'field_name'=>null,
                'value'=>'appraisal comments...'
            ];
            // dd($data);
            Transcript::upsert(
                $data, 
                ['klass_student_id','transcript_template_id'],
                ['value']
            );
        }
        //dd($data);
    }    

}
