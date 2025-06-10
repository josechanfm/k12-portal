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

class SubjectController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        //dd(Subject::all());
        //dd(Config::item('subject_types'));
        //dd(Config::item('study_streams'));
        return Inertia::render('Master/Subjects',[
            'subjects'=>Subject::all(),
            'subjectTypes'=>Config::item('subject_types'),
            'studyStreams'=>Config::item('study_streams'),
            'teachers'=>Staff::teachers()
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
        $subject->description=$request->description;
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
        // $study=Study::with('subjects')->find($id);
        // $subjects=Subject::where('version',1)->get();
        // // echo json_encode($study);
        // // echo json_encode($subjects);
        // // return;
        // return Inertia::render('Master/Subject',[
        //     'study'=>$study,
        //     'subjects'=>$subjects
        // ]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        // $study=Study::with('subjects')->find($id);
        // $subjects=Subject::where('version',1)->where('active',1)->get();
        // return Inertia::render('Master/SubjectEdit',[
        //     'study'=>$study,
        //     'subjects'=>$subjects
        // ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Subject $subject, Request $request)
    {
        Validator::make($request->all(), [
            'code' => ['required'],
        ])->validate();
        
        if($request->has('id')){
            $subject->code=$request->code;
            $subject->title_zh=$request->title_zh;
            $subject->title_en=$request->title_en;
            $subject->description=$request->description;
            $subject->active=$request->active;
            $subject->save();
        }
        return redirect()->back();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Subject $subject)
    {
        if($subject->studys->count()>0){
            return redirect()->back()->withErrors(['message'=>'Could not delete, record depends on study table']);
        }else{
            $subject->delete();
            return redirect()->back();    
        }
        
    }
}
