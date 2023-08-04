<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Staff;
use App\Models\Study;
use App\Models\Subject;
use App\Models\StudySubject;
use App\Models\SubjectTemplate;
use App\Models\Config;
use Illuminate\Support\Facades\Validator;

class StudySubjectController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        return Inertia::render('Master/StudySubject',[
            'subjects'=>Subject::all(),
            'subjectTypes'=>Config::item('subject_types'),
            'studyStreams'=>Config::item('study_streams'),
        ]);
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
        Validator::make($request->all(), [
            'code' => ['required'],
        ])->validate();

        $subject=new Subject;
        $subject->code=$request->code;
        $subject->title_zh=$request->title_zh;
        $subject->title_en=$request->title_en;
        $subject->type=$request->type;
        $subject->stream=$request->stream;
        $subject->elective=$request->elective;
        $subject->description=$request->description;
        $subject->version=$request->version;
        $subject->active=$request->active;
        $subject->save();
        return redirect()->back();
        
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $study=Study::with('subjects')->find($id);
        $subjects=Subject::where('version',1)->get();
        // echo json_encode($study);
        // echo json_encode($subjects);
        // return;
        return Inertia::render('Master/Subject',[
            'study'=>$study,
            'subjects'=>$subjects,
            'teachers'=>Staff::teachers()
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
        $study=Study::with('subjects')->find($id);
        $subjects=Subject::where('active',1)->with('study')->get();
        //dd($subjects[0]->study);
        return Inertia::render('Master/StudySubjectEdit',[
            'study'=>$study,
            'subjects'=>$subjects,
            'teachers'=>Staff::teachers()
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $studyId)
    {
        //dd($studyId);
        //dd($request->all());
        Study::find($studyId)->subjects()->sync($request->all());
        //dd($request->all());
        // $data = array_map(function($d) use ($id){
        //     return array(
        //         'study_id'=>$id,
        //         'subject_id'=>$d['id'],
        //         'stream'=>$d['stream'],
        //         'elective'=>$d['elective']
        //     );
        // }, $request->all());
        // StudySubject::upsert(
        //     $data,
        //     ['study_id','subject_id'],
        //     ['stream','elective']
        // );

        // StudySubject::whereNotIn('subject_id',array_column($data,'subject_id'))->where('study_id',$id)->delete();
        // return response()->json($data);
        //return response()->json($request->all());
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
}
