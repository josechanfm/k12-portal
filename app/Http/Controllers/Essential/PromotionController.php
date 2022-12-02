<?php

namespace App\Http\Controllers\Essential;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Subject;
use App\Models\Klass;
use App\Models\Config;
use App\Models\Klassmate;
use App\Models\Score;
use App\Models\Course;

class PromotionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {

        if(!$request->yearId){
            return redirect('/admin');
        }
        $yearId=$request->yearId;
        $year=Year::find($yearId);
        //$subjects=Subject::where('active',1)->get();
        // $klassOptions=Klass::select('id as value','acronym as label')->where('year_id',$yearId)->get();
        // $klasses=Klass::where('year_id',$yearId)->get();
        // $config=json_decode(Config::where('key','grades')->first()->value,true);
        // $grades=json_decode(Config::where('key','grades')->first()->value,true);
        // $klassesSubjects=Klass::where('year_id',$yearId)->with('subjects')->get();
        return Inertia::render('Annual/Dashboard',[
            'year'=>$year,
            //'subjects'=>$subjects,
            // 'klasses'=>$klasses,
            // 'klassOptions'=>$klassOptions,
            // 'config'=>$config,
            // 'grades'=>$grades,
            // 'klassesSubjects'=>$klassesSubjects
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

    
    public function grade($gradeId){
        $klasses=Grade::find($gradeId)->klasses;
        echo $klasses;
    }
    public function klass($klassId){
        
        $grade=Klass::find($klassId)->grade;
        $year=Year::find($grade->year_id);
        $nextYear=Year::where('herit',$year->id)->first();
        $nextGrade=Grade::where('year_id',$nextYear->id)->where('level',($grade->level+1))->first();
        $klass=Klass::find($klassId);
        $nextKlasses=Klass::where('grade_id',$nextGrade->id)->get();
        $students=Klass::find($klassId)->students;
        //$courses=Klass::find($klassId)->courses;
        return Inertia::render('Annual/Promotion',[
            'year'=>$year,
            'nextYear'=>$nextYear,
            'grade'=>$grade,
            'nextGrade'=>$nextGrade,
            'klass'=>$klass,
            'nextKlasses'=>$nextKlasses,
            'students'=>$students,

        ]);
    }

    public function data($yearId){
        $year=Year::find($yearId);
        $yearGrades=Year::find($yearId)->grades;
        $yearKlasses=Year::find($yearId)->klasses;
        //$klassesStudents=Klass::where('year_id',$yearId)->with('students')->with('courses')->get();
        // $klassesStudents=Klass::where('year_id',$yearId)->with('students')->with('courses')->get();
        // $klassStudents=Klass::find(1)->students;
        // $klassCourses=Klass::find(1)->courses;
        // $yearCourses=Year::find(1)->courses;
        // $yearStudents=Year::find(1)->students;
        // $klassmateScores=Klassmate::find(1)->scores;
        // $scoreCourse=Score::find(1)->course;
        // $courseScores=Course::where('klass_id',1)->with('scores')->get();
        // $klassCourseScores=Course::find(1)->students;
        
        echo $year;
        echo $yearGrades;
        echo $yearKlasses;
        
        // echo 'All Students and courses of each klass in a year<br>';
        // echo $klassesStudents;
        // echo '<hr>';
        // echo 'Students in klass 1<br>';
        // echo $klassStudents;
        // echo '<hr>';
        // echo 'Courses in klass 1<br>';
        // echo $klassCourses;
        // echo '<hr>';
        // echo 'All Courses in year 1<br>';
        // echo $yearCourses;
        // echo '<hr>';
        // echo 'All Students in year 1<br>';
        // echo $yearStudents;
        // echo '<hr>';
        // echo 'All scores of a klassmate<br>';
        // echo $klassmateScores;
        // echo '<hr>';
        // echo 'a score of course<br>';
        // echo $scoreCourse;
        // echo '<hr>';
        // echo 'All scores of a couse in a klass<br>';
        // echo $courseScores;
        // echo '<hr>';

        // $klass=Klass::find($klassId);
        // $klassStudents=Klass::with('students')->find($klassId);
        // // return response()->json([
        // //     'klass'=>$klass,
        // //     'klassStudents'=>$klassStudents

        // // ]);
        // return Inertia::render('YearPlan/PromoteKlass',[
        //     'klass'=>$klass,
        //     'klassStudents'=>$klassStudents
        // ]);
    }


}
