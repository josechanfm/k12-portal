<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use App\Models\Ability;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Activity;
use App\Models\ActivityStudent;
use App\Models\Staff;
use App\Models\Year;
use App\Models\Extracurricular;
use Illuminate\Support\Facades\Validator;
use PDF;

class ActivityController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Inertia::render('Manage/Activities',[
            'terms'=>Config::item('year_terms'),
            'staffs'=>Staff::all(),
            'extracurriculars'=>Extracurricular::where('active',true)->get(),
            'activities'=>Activity::studentsOf(),
            'klasses'=>Year::currentYear()->klasses,
            'grades'=>Year::currentYear()->grades
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
            'title_zh' => ['required'],
        ])->validate();

        Activity::create($request->all());
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
    public function update(Request $request, Activity $activity)
    {
        Validator::make($request->all(), [
            'title_zh' => ['required'],
        ])->validate();
        
        $activity->update($request->all());
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

    public function students(Activity $activity){
        $activity->studentsWithKlass();
        return Inertia::render('Manage/ActivityStudents',[
            'klasses'=>Year::currentYear()->klasses,
            'grades'=>Year::currentYear()->grades,
            'activity'=>$activity,
        ]);
    }

    public function studentsScores(Activity $activity){
        $activity->studentsWithKlass();
        return Inertia::render('Manage/ActivityStudentsScores',[
            'klasses'=>Year::currentYear()->klasses,
            'grades'=>Year::currentYear()->grades,
            'activity'=>$activity,
        ]);
    }
    public function scoreReport(Activity $activity){
        //https://cooltext.com/Fonts-Unicode-Chinese
        //$pdf= PDF::loadHTML('<h1>Hello World!</h1>');
        //return view('pdf.activityScores',['students'=>$activity->studentsWithKlass()]);
        $pdf=PDF::loadView('pdf.activityScores',['students'=>$activity->studentsWithKlass()]);
        return $pdf->stream();
    }

    public function studentsScoresUpdate(Request $request){
        ActivityStudent::upsert($request->all(),['activity_id','student_id','klass_id'],['score']);
        return redirect()->back();
    }

    public function studentsSync(Request $request, Activity $activity)
    {
        $activity->students()->sync($request->all());
        return redirect()->back();
    }

}
