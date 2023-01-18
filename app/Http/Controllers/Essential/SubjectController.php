<?php

namespace App\Http\Controllers\Essential;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Grade;
use App\Models\Subject;
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
        $grade=Grade::find($request->gid);
        $subjects=Subject::whereBelongsTo($grade)->get();
        return Inertia::render('Essential/Subject',[
            'grade'=>$grade,
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
        Validator::make($request->all(), [
            'grade_id' => ['required'],
            'code' => ['required'],
        ])->validate();

        $subject=new Subject;
        $subject->grade_id=$request->grade_id;
        $subject->code=$request->code;
        $subject->title_zh=$request->title_zh;
        $subject->title_en=$request->title_en;
        $subject->type=$request->type;
        $subject->stream=$request->stream;
        $subject->elective=$request->elective;
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
        //
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
        Validator::make($request->all(), [
            'grade_id' => ['required'],
            'code' => ['required'],
        ])->validate();
        if($request->has('id')){
            $subject=Subject::find($id);
            $subject->grade_id=$request->grade_id;
            $subject->code=$request->code;
            $subject->title_zh=$request->title_zh;
            $subject->title_en=$request->title_en;
            $subject->type=$request->type;
            $subject->stream=$request->stream;
            $subject->elective=$request->elective;
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
    public function destroy($id)
    {
        //
    }
}
