<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Teacher;
use App\Models\Transcript;

class KLassController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function index()
    {
        $klass = Klass::with('courses')->find(1);
        $teacher = Teacher::with('courses')->find(1);
        return response($teacher);
        //return response($klass);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Klass $klass)
    {
        $grade = $klass->grade;
        $courses = Klass::find($klass->id)->courses;
        // dd($courses);
        return Inertia::render('Manage/Klass', [
            'grade' => $grade,
            'klass' => $klass,
            'courses' => $courses,
            //'students'=>$students,
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function klass_scores($klassId)
    {
        $scores = Klass::klass_scores($klassId);
        echo $scores;
    }

    public function students(Klass $klass)
    {
        return Inertia::render('Manage/KlassStudents', [
            'klass' => $klass,
            'students' => $klass->students,
        ]);
    }

    public function finalScores(Klass $klass)
    {
        return Inertia::render('Manage/KlassTranscript', [
            'klass' => $klass,
            'transcriptTemplates' => $klass->grade->transcriptTemplates(),
            'finalScores' => $klass->finalScores()
        ]);
    }
    public function migrateTranscripts(Klass $klass){
        $finalScores=$klass->finalScores();
        $data=[];
        foreach($finalScores['students'] as $student){
            foreach($finalScores['score_columns'] as $column){
                $data[]=[
                    'klass_student_id'=>$student['klass_student_id'],
                    'reference_code'=>$column->course_code,
                    'value'=>$student['scores'][$column->id]
                ];
            }
        }
        Transcript::upsert($data, ['klass_student_id','reference_code'],['value']);
        $klass->transcript_migrated=true;
        $klass->save();
        return redirect()->back();
    }    
}
