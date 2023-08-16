<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Student;
use App\Models\Klass;
use App\Models\Grade;
use App\Models\Year;

class StudentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $students=Student::paginate(10);
        return Inertia::render('Manage/Student',[
            'students'=>$students
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
        $student=Student::with('address')->with('identity_document')->with('bank')->with('detail')->with('parent')->with('guardian')->find($id);
        // echo json_encode($student);
        return Inertia::render('Manage/StudentProfile',[
            'student'=>$student
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

    public function getByKlassId(Klass $klass){
        $students=$klass->students;
        foreach($students as $i=>$student){
            $students[$i]->klass=$student->klasses()->latest()->first();
        }
        return response()->json($students);
    }
    public function getByNames(Request $request){
        //$students=Student::whereIn('name_zh',$request->all())->get();
        //return response()->json($request->all());
        $tmpStudents=Year::currentYear()->students->whereIn('name_zh',$request->all());
        //dd($students);
        foreach($tmpStudents as $std){
            $students[]=$std;
        }
        foreach($students as $i=>$student){
            $students[$i]->klass=$student->klasses()->latest()->first();
        }
        return response()->json($students);
    }

}
