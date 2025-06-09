<?php

namespace App\Http\Controllers\Teacher;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Inertia\Inertia;
use App\Models\Student;
use App\Models\KlassStudent;
use App\Models\Klass;

class AvatarController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Inertia::render('Director/Avatars',[

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
        $uploadFile=$request->file('avatar');
        $klassStudent=KlassStudent::find($request->klassStudentId);
        if(isset($uploadFile)){
            //$media=$klassStudent->addMediaFromRequest($uploadFile)->toMediaCollection('avatar');
            $media=$klassStudent->addMedia($uploadFile)->toMediaCollection('avatar');
        }
        
        // $student=Student::find($klassStudent->student_id);
        // $student->addMedia($uploadFile)->toMediaCollection('avatar');
        return response()->json([
            'student_name'=>$klassStudent->student->name_zh,
            'student_number'=>$klassStudent->student_number,
            'full_tag'=>$media->name,
            'url'=>$media->getFullUrl()
        ]);
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
    public function upload(Request $request){
    }
    public function student(Student $student){
        return response()->json($student->avatars());
 
    }
    public function klass(Klass $klass){
        return Inertia::render('Teacher/KlassAvatars', [
            'klass' => $klass,
            'students' => $klass->studentsWithAvatar(),
        ]);
    
    }

}
