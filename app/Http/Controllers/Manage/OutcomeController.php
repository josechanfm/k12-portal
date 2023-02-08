<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Course;
use App\Models\Score;
use App\Models\ScoreColumn;
use App\Models\Klass;
use App\Models\Student;
use App\Models\CourseScore;

class OutcomeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $kid=74;
        $courses=Course::students_outcomes($kid);
        $students=Klass::find($kid)->students()->get();
        echo json_encode($students);
        echo '<hr>';
        
        foreach($courses as $course){
            echo json_encode($course);
            echo $course->id.$course->title_zh;
            echo '<hr>';
        }
        return;

        $cid=$request->cid;
        $courseScores=CourseScore::where('course_id',$cid)->orderByRaw('-sequence DESC')->get();
        $studentsScores=Course::students_scores($cid);
        $course=Course::with('klass')->with('teachers')->find($cid);
        $courses=Course::where('klass_id',$course->klass_id)->whereNot('type','SUB')->get();

        return Inertia::render('Manage/Outcome',[
            'course'=>$course,
            'course_scores'=>$courseScores,
            'students_scores'=>$studentsScores,
            'courses'=>$courses

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
}
