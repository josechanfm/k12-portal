<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Activity;
use App\Models\Staff;
use App\Models\Year;
use App\Models\Student;
use App\Models\Extracurricular;
use Illuminate\Support\Facades\Validator;

class ActivityStudentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Activity $activity)
    {
        //$activityStudents=$activity->studentsWithKlass();
        //dd($activityStudents);
        return Inertia::render('Manage/ActivityStudents',[
            // 'terms'=>Config::item('year_terms'),
            // 'staffs'=>Staff::all(),
            // 'extracurriculars'=>Extracurricular::where('active',true)->get(),
            // 'activities'=>Activity::studentsOf(),
            'klasses'=>Year::currentYear()->klasses,
            'grades'=>Year::currentYear()->grades,
            'activity'=>$activity,
            'activityStudents'=>$activity->studentsWithKlass(),
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
    public function update(Request $request, Activity $activity, Student $student)
    {
        $activity->students()->sync($request->all());
        return redirect()->back();

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
