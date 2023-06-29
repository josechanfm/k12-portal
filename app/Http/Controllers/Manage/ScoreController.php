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

        $studentsScores=$course->students_scores();
        
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

    public function test(Course $course){
        
        //dd($course->studentsScores());

        $studentsScores=$course->students_scores();
        $allCourses=\App\Models\Klass::where('id',$course->klass_id)->first()->courses;
        //dd($allCourses);
        // $tmp=0;
        $toCourses=$allCourses->whereNotNull('score_scheme');

        foreach($toCourses as $toCourse){
        //     // dd($mc->score_scheme);
            $schemes=json_decode($toCourse->score_scheme);
            $toCourseStudentsScores=$toCourse->studentsScores();
            //dd($toCourseStudentsScores);
            $fromCourses=[];
            foreach($schemes as $scheme){
                $fromCourses[$scheme->course_id]=Course::find($scheme->course_id)->studentsScores();
                //array_push($fromCourses,Course::find($scheme->course_id)->studentsScores());
            }
            dd($fromCourses[4][0]);
        //     foreach($schemes as $scheme){
        //         dd($scheme->percentage);
        //         $tmp=Course::find($scheme->course_id);
        //         dd($scheme->percentage);
        //     }
        }
        // dd($tmp);
        // //dd($course->studentsScores());

        //scoreColumns=$course->scoreColumns;
        // dd($scoreColumns);
        $course=Course::with('klass')->with('teachers')->find($course->id);
        return Inertia::render('Manage/Score2',[
            'year_terms'=>Config::item('year_terms'),
            'course'=>$course,
            'score_columns'=>$course->scoreColumns,
            'students_scores'=>$course->studentsScores()
        ]);


    }

}
