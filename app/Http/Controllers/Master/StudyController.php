<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Study;
use App\Models\Config;
use Illuminate\Support\Facades\Validator;

class StudyController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $studies=Study::all();
        return Inertia::render('Master/Study',[
            'studies'=>$studies,
            'studyStreams'=>Config::item('study_streams'),
            'gradeCategories'=>Config::item('grade_categories'),
            'versions'=>Study::versions()
            // 'versions'=>'[{value:1},{value:2}]'
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
            'version' => ['required'],
            'title_zh' => ['required'],
        ])->validate();

        $study=new Study;
        $study->version=$request->version;
        $study->title_zh=$request->title_zh;
        $study->title_en=$request->title_en;
        $study->stream=$request->stream;
        $study->description=$request->description;
        $study->grade=$request->grade;
        $study->active=$request->active;
        $study->save();
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
            'version' => ['required'],
            'title_zh' => ['required'],
        ])->validate();

        $study=Study::find($id);
        $study->version=$request->version;
        $study->title_zh=$request->title_zh;
        $study->title_en=$request->title_en;
        $study->stream=$request->stream;
        $study->description=$request->description;
        $study->grade=$request->grade;
        $study->active=$request->active;
        $study->save();
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
