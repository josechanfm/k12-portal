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
        // $courses=Course::all();
        // foreach($courses as $course){
        //     $x='A';
        //     $columns=ScoreColumn::where('course_id',$course->id)->orderBy('term_id')->orderByRaw('-sequence DESC')->get();
        //     echo $course->code;
        //     echo '<br>';
        //     foreach($columns as $column){
        //         echo json_encode($column);
        //         echo '<hr>';
        //         $column->column_letter=$x++;
        //         $column->save();
        //     }
        // }
        // return true;

        $studentsScores=$course->studentsScores();
        
        $scoreColumns=$course->scoreColumns;
        // dd($scoreColumns);
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
        $updatedCount=Score::updateScore($data);
        //return response($updatedCount);
        //return response($data);
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
