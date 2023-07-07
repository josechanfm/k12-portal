<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Discipline;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Course;
use App\Models\Klass;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Study;
use App\Models\Subject;
use App\Models\Student;
use Illuminate\Support\Facades\Validator;

class KlassController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if($request->gid){
            $grade=Grade::with('year')->find($request->gid);
        }else{
            $grade=Grade::with('year')->whereBelongsTo(Year::currentYear())->first();
        }
        return redirect()->route('admin.grade.klasses',$grade);
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
        Validator::make($request->all(), [
            'grade_id' => ['required'],
            'letter' => ['required'],
        ])->validate();
        $klass=new Klass;
        $klass->grade_id=$request->grade_id;
        $klass->letter=$request->letter;
        $klass->stream=$request->stream;
        $klass->study_id=$request->study_id;
        $klass->room=$request->room;
        $klass->tag=Grade::find($request->grade_id)->tag.$request->letter;
        $klass->study_id=$request->study_id;
        $klass->save();
        return redirect()->back();
}

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data=Klass::find($id);
        return response()->json($data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $studySubjects=Study::find(1)->subjects;
        echo json_encode($studySubjects);
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
        Validator::make($request->all(), [
            'grade_id' => ['required'],
            'letter' => ['required'],
        ])->validate();
        
        if($request->has('id')){
            $klass=Klass::find($id);
            $klass->grade_id=$request->grade_id;
            $klass->letter=$request->letter;
            $klass->stream=$request->stream;
            $klass->room=$request->room;
            $klass->tag=Grade::find($request->grade_id)->tag.$request->letter;
            $klass->save();
            return redirect()->back();
        }else{
            return redirect()->back();
        }
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $klass=Klass::find($id);
        if($klass){
            $klass->delete();
            return redirect()->back()
                ->with('message', 'Blog Delete Successfully');
        }
    }

    public function courses(Klass $klass){
        //$klass=Klass::find($klassId);
        $courses=Course::whereBelongsTo($klass)->get();
        return Inertia::render('Admin/KlassCourses',[
            'klass'=>$klass,
            'courses'=>$courses,
            //'subjects'=>$subjects
        ]);
    }
    public function students(Klass $klass){
        $klassStudents=$klass->students;
        $courses=$klass->courses;
        $coursesStudents=$klass->coursesStudents;
        $dataTable=[];
        $dataColumns=[];

        //Create student course dataTable array table with initial value of false/0 and dataColumns header
        foreach($courses as $course){
            $dataColumns[]=[
                'title'=>$course->title_zh,
                'dataIndex'=>$course->id
            ];
            foreach($klassStudents as $student){
                $dataTable[$student->id]['student_name']=$student->name_zh;
                $dataTable[$student->id]['courses'][$course->id]=0;
            }
        }
        //Assign value (True/1) to dataTable array 
        foreach($coursesStudents as $course){
            foreach($course->students as $student){
                $dataTable[$student->id]['courses'][$course->id]=1;
            }
        }

        return Inertia::render('Admin/KlassStudents',[
            'dataTable'=>$dataTable,
            'dataColumns'=>$dataColumns,
            'klass'=>Klass::where('id',$klass->id)->with('courses')->first(),
            'students'=>$klass->students()->with('courses')->get(),
            'courses'=>$klass->courses
        ]);
    }

}
