<?php

namespace App\Http\Controllers\Manage;

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
    public function list(Request $request)
    {

        $gradeId=$request->input('gradeId');
        if($gradeId){
            $grades=Grade::where('id',$gradeId)->with('klasses')->get();
            $year=Year::find($grades[0]->year_id);
            $nextYear=Year::nextYear($grades[0]->year_id);
            $nextGrades=Grade::where('year_id',$nextYear->id)->with('klasses')->get();
        }else{
            $year=Year::where('active',1)->orderBy('start','DESC')->first();
            //$year=Year::find($year->id);
            $nextYear=Year::nextYear($year->id);
            $grades=Grade::where('year_id',$year->id)->with('klasses')->get();
            $nextGrades=Grade::where('year_id',$nextYear->id)->with('klasses')->get();
        }
        // echo 'promote';
        // // echo $grades;
        // echo $year;
        // echo $nextYear;
        //***** Check if any of the varible not completed  jump to the error page******/
        return Inertia::render('Manage/Promotes',[
            'year'=>$year,
            'grades'=>$grades,
            'nextYear'=>$nextYear,
            'nextGrades'=>$nextGrades
        ]);
    }

    public function index(Klass $klass){
        $grade=$klass->grade;
        //dd($grade);
        $year=Year::find($grade->year_id);
        $nextYear=Year::nextYear($year->id);;
        $nextGrade=Grade::where('year_id',$nextYear->id)->where('grade_year',($grade->grade_year+1))->first();
        //dd($nextGrade);
        
        //dd($klass);
        $nextKlasses=Klass::where('grade_id',$nextGrade->id)->get();
        //dd($nextKlasses);
        $students=$klass->students;
        //$courses=Klass::find($klassId)->courses;
        return Inertia::render('Manage/KlassPromotion',[
            'year'=>$year,
            'nextYear'=>$nextYear,
            'grade'=>$grade,
            'nextGrade'=>$nextGrade,
            'klass'=>$klass,
            'nextKlasses'=>$nextKlasses,
            'students'=>$students,

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
        dd($id);
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
    public function update(Klass $klass, Request $request)
    {
        foreach($request->klassStudents as $record){
            // dd($record);
            // dd(KlassStudent::find($record['klass_student_id']));
            KlassStudent::find($record['klass_student_id'])->update(['promote_to'=>$record['promote_to']]);
        };
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
    public function getPromotedStudents($klassId){
        $students=Klass::find($klassId)->promoteTo;
        foreach($students as $i=>$std){
            $students[$i]->pivot->letter=Klass::find($std->pivot->klass_id)->letter;
        }
        
        //echo $students;
        return response()->json($students);
    }
    public function getStudents($klassId){
        $students=Klass::find($klassId)->students;
        $currentGrade=Grade::find(Klass::find($klassId)->grade_id);
        $currentYear=Year::find($currentGrade->year_id);
        $nextYear=Year::nextYear($currentYear->id);
        $nextGrade=Grade::where('year_id',$nextYear->id)->where('level',$currentGrade->level+1)->first();
        $nextGradeKlasses=Klass::where('grade_id',$nextGrade->id)->get();
        $data=[
            'students'=>$students,
            'currentYear'=>$currentYear,
            'currentGrade'=>$currentGrade,
            'nextYear'=>$nextYear,
            'nextGrade'=>$nextGrade,
            'nextGradeKlasses'=>$nextGradeKlasses,
        ];
        return response()->json($data);

        //$students=Klass::find($klassId)->students;
        //echo $students;
    }
    
    public function grade($gradeId){
        $klasses=Grade::find($gradeId)->klasses;
        echo $klasses;
    }
    // public function klass($klassId){
    //     $grade=Klass::find($klassId)->grade;
    //     //dd($grade);
    //     $year=Year::find($grade->year_id);
    //     $nextYear=Year::nextYear($year->id);;
    //     $nextGrade=Grade::where('year_id',$nextYear->id)->where('grade_year',($grade->grade_year+1))->first();
    //     //dd($nextGrade);
    //     $klass=Klass::find($klassId);
    //     //dd($klass);
    //     $nextKlasses=Klass::where('grade_id',$nextGrade->id)->get();
    //     //dd($nextKlasses);
    //     $students=Klass::find($klassId)->students;
    //     //$courses=Klass::find($klassId)->courses;
    //     return Inertia::render('Manage/KlassPromotion',[
    //         'year'=>$year,
    //         'nextYear'=>$nextYear,
    //         'grade'=>$grade,
    //         'nextGrade'=>$nextGrade,
    //         'klass'=>$klass,
    //         'nextKlasses'=>$nextKlasses,
    //         'students'=>$students,

    //     ]);
    // }

    public function data($yearId){
        $year=Year::find($yearId);
        $nextYear=Year::nextYear($year->id);
        $yearGrades=Year::find($yearId)->grades;
        $yearKlasses=Year::find($yearId)->klasses;
        $promoteTo=Klass::find(74)->promoteTo;

        $nextYearGrades=Year::find($nextYear->id)->grades;
        
        echo "Promote To<br>";
        echo $promoteTo;
        echo '<hr>';
        echo "Year<br>";
        echo $year;
        echo '<hr>';
        echo "Next Year<br>";
        echo $nextYear;
        echo '<hr>';
        echo "Year Grades<br>";
        echo $yearGrades;
        echo '<hr>';
        echo "Year Klasses<br>";
        echo $yearKlasses;
        echo '<hr>';
        echo "Next Year Grades<br>";
        echo $nextYearGrades;
        echo '<hr>';

    }
}
