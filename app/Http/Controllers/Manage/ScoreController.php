<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Course;
use App\Models\Score;
use App\Models\ScoreColumn;


class ScoreController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function byCourse(Course $course){
        $studentsScores=$course->students_scores();
        $scoreColumns=$course->scoreColumns;
        $course=Course::with('klass')->with('teachers')->find($course->id);
        return Inertia::render('Manage/Score',[
            'year_terms'=>Config::item('year_terms'),
            'course'=>$course,
            'score_columns'=>$scoreColumns,
            'students_scores'=>$studentsScores
        ]);

    }
    public function index(Request $request)
    {
        return redirect()->route('manage.course.score',$request->cid);
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
    public function update(Request $request)
    {
        $data=$request->all();
        return Score::updateScore($data);
    }

    // public function calScore(Request $request){
    //     $klass=Course::find($request->cid)->klass;
    //     //dd($klass->students->where('id',2)->first()->pivot->klass_student_id);
    //     $scoreColumns=Course::find($request->cid)->scoreColumns;
    //     //init score column in letter array
    //     $i=65;
    //     foreach($scoreColumns as $column){
    //         $fields[chr($i++)]=0;
    //     }
        
    //     //dd($fields);
    //     $students=Course::find($request->cid)->students;
    //     foreach($students as $student){
    //     };
    //     //dd($students);
    //     $data=[];
    //     foreach($students as $student){
    //         foreach($scoreColumns as $column){
    //             if(!empty($column->scheme)){
    //                 $point=$column->scheme;
    //                 $data=[
    //                     'klass_student_id'=>$klass->students->where('id',$student->id)->first()->pivot->klass_student_id,
    //                     'score_column_id'=>$column->id,
    //                     'point'=>json_encode($fields)
    //                 ];
    //             }
    //         }
    //     }
    //     dd($data);
    // }

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
