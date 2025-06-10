<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Study;
use App\Models\Subject;
use App\Models\Year;
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
        $yearCode=$_GET['yearCode']??false;
        if($yearCode){
            $year=Year::where('code',$yearCode)->first(); 
        }   
        else{
            $year=Year::currentYear(); 
            $yearCode=$year->code  ;
        }
        $studies=$year?$year->studies()->with('subjects')->get() : [];
        return Inertia::render('Master/Studies',[
            'studyStreams'=>Config::item('study_streams'),
            'studies'=> $studies,
            'gradeYears'=>Config::item('grade_years'),
            'subjects'=>Subject::all(),
            'versions'=>Study::versions(),
            'years'=>Year::all(),
            'tempYearCode'=>$yearCode,
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

        Study::create($request->all());
        // $study=new Study;
        // $study->version=$request->version;
        // $study->title_zh=$request->title_zh;
        // $study->title_en=$request->title_en;
        // $study->stream=$request->stream;
        // $study->description=$request->description;
        // $study->grade_year=$request->grade_year;
        // $study->active=$request->active;
        // $study->save();
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
    public function update(Study $study, Request $request)
    {
        Validator::make($request->all(), [
            'version' => ['required'],
            'title_zh' => ['required'],
        ])->validate();
        $study->update($request->all());
        $study->save();
        // $study->version=$request->version;
        // $study->title_zh=$request->title_zh;
        // $study->title_en=$request->title_en;
        // $study->stream=$request->stream;
        // $study->description=$request->description;
        // $study->grade_year=$request->grade_year;
        // $study->active=$request->active;
        // $study->save();
        return redirect()->back();

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Study $study)
    {

        if($study->subjects->count()>0){
            return redirect()->back()->withErrors(['message'=>'Could not delete, record depends on subject table']);
        }else{
            $study->delete();
            return redirect()->back();    
        }

        // $study=Study::find($id);
        // if($study){
        //     $study->delete();
        //     return redirect()->back()
        //         ->with('message', 'Study Delete Successfully');

        // }
    }

    public function subjects(Request $request)
    {
        return Inertia::render('Master/StudySubject',[
            'subjects'=>Subject::all(),
            //'subjectTypes'=>Config::item('subject_types'),
            'studyStreams'=>Config::item('study_streams'),
        ]);
    }
    
    public function updateCourse(Request $request){
        dd($request);
    }
}
