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
use App\Models\KlassStudent;
use App\Models\Score;
use App\Models\Course;
use Illuminate\Support\Facades\DB;

class PromotionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {

        $gradeId=$request->input('gradeId');
        if(!$gradeId){
            $yearId=Config::where('key','current_year')->first()->value;
            $year=Year::find($yearId);
            $grades=Grade::where('year_id',$yearId)->with('klasses')->get();
        }else{
            $grades=Grade::where('id',$gradeId)->with('klasses')->get();
            $year=Year::find($grades[0]->year_id);
        }
        // echo $grades;
        // echo $year;
        return Inertia::render('Essential/Dashboard',[
            'year'=>$year,
            'grades'=>$grades,
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
    public function updateStudents(Request $request){
        $students=$request->input('students');
        foreach($students as $std){
            switch(true){
                case $std['id']>0:
                    KlassStudent::find($std['id'])->update(['promote_to'=>$std['promote_to']]);    
                    break;
                case $std['id']=-9:
                    KlassStudent::find($std['id'])->update(['promote_to'=>0]);
                    break;
                case $std['id']=-1:
                    KlassStudent::find($std['id'])->update(['promote_to'=>-1]);
                    break;
            }
          
        }
        return response()->json($students);
    }
    public function getStudents($klassId){
        $students=Klass::find($klassId)->students;
        $currentGrade=Grade::find(Klass::find($klassId)->grade_id);
        $currentYear=Year::find($currentGrade->year_id);
        $nextYear=Year::where('start','>',$currentYear->start)->orderBy('start','ASC')->first();
        $nextGrade=Grade::where('year_id',$nextYear->id)->where('level',$currentGrade->level+1)->first();
        $nextGradeKlasses=Klass::where('grade_id',$nextGrade->id)->get();
        $ks=KlassStudent::find(1);
        $data=[
            'students'=>$students,
            'currentYear'=>$currentYear,
            'currentGrade'=>$currentGrade,
            'nextYear'=>$nextYear,
            'nextGrade'=>$nextGrade,
            'nextGradeKlasses'=>$nextGradeKlasses,
            'ks'=>$ks
        ];
        return response()->json($data);

        //$students=Klass::find($klassId)->students;
        //echo $students;
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
