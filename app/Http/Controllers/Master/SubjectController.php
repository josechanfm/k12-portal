<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
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
        $study=Study::with('subjects')->find($request->studyId);
        $subjects=SubjectTemplate::all();
        return Inertia::render('Master/Subject',[
            'study'=>$study,
            'subjects'=>$subjects
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
        //
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
            'subjects'=>$subjects
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
        $subjects=Subject::where('version',1)->where('active',1)->get();
        return Inertia::render('Master/SubjectEdit',[
            'study'=>$study,
            'subjects'=>$subjects
        ]);
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
        $subjects=$request->all();
        $data=[];
        foreach($subjects as $subject){
            $data[$subject['id']]=['stream'=>'SCI','elective'=>'0'];
        }
        $study=Study::find($id);
        $study->subjects()->sync($data);
        return redirect('/master/study/subjects/'.$id);
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
