<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;
use App\Models\Staff;
use App\Models\Teacher;
use App\Models\CourseScore;

class KLassController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

 
    public function index()
    {
        $klass=Klass::with('courses')->find(1);
        $teacher=Teacher::with('courses')->find(1);
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
    public function show($id)
    {
        $klass=Klass::find($id);
        $grade=Grade::find($klass->grade_id);
        $courses=Klass::find($id)->courses;
        $students=Klass::klass_scores($id);
        $score_columns=Config::item('score_columns');
        return Inertia::render('Manage/Klass',[
            'grade'=>$grade,
            'klass'=>$klass,
            'courses'=>$courses,
            'students'=>$students,
            'score_columns'=>$score_columns
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

    public function klass_scores($klassId){
        $scores=Klass::klass_scores($klassId);
        echo $scores;
    }
    
}

