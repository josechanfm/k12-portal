<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Klass;
use App\Models\Course;
use App\Models\Score;
use App\Models\Config;
use Inertia\Inertia;

class CourseController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
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
        echo 'show';
        return ;
        $courseId=1;
        $course=Course::find($courseId);
        $students=Course::gather_scores($courseId);
        echo $course;
        echo '<hr>';
        echo '*****<br>';
        foreach($students as $student){
            echo  $student;
            echo '<hr>';
        }
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

    // public function getByKlassId($klassId){
    //     //$courses=Klass::find($klassId)->courses;
    //     $courses=Course::where('klass_id',$klassId)->where('type','SUB')->with('teachers')->get();
    //     echo $courses;
    // }

    // public function byKlass(Klass $klass){
    //     dd($klass);
    // }

    public function scores(Course $course){
        
        //dd($course->studentsScores());

        $studentsScores=$course->studentsScores();
        $allCourses=\App\Models\Klass::where('id',$course->klass_id)->first()->courses;
        //dd($allCourses);
        // $tmp=0;
        $toCourses=$allCourses->whereNotNull('score_scheme');

        foreach($toCourses as $toCourse){
            echo json_encode($toCourse);
            //dd($toCourse->score_scheme);
            $schemes=json_decode($toCourse->score_scheme);
            //dd($schemes);
            $toCourseStudentsScores=$toCourse->studentsScores();
            //dd($toCourseStudentsScores);
            $fromCourses=[];
            foreach($schemes as $scheme){
                $fromCourses[$scheme->course_id]=Course::find($scheme->course_id)->studentsScores();
                //array_push($fromCourses,Course::find($scheme->course_id)->studentsScores());
            }
            //dd($fromCourses[4][0]['scores']);
            foreach($fromCourses as $fcStudent){

                    echo json_encode($fcStudent);
                    echo '<hr>';
                // echo json_encode($fcStudents);
                echo '<hr>';
            }

        //     foreach($schemes as $scheme){
        //         dd($scheme->percentage);
        //         $tmp=Course::find($scheme->course_id);
        //         dd($scheme->percentage);
        //     }
        }
        dd($toCourses);
        // //dd($course->studentsScores());

        // $scoreColumns=$course->scoreColumns;
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


