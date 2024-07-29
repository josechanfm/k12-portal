<?php

namespace App\Http\Controllers\Teacher;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Klass;
use App\Models\Course;
use App\Models\Student;

class StudentController extends Controller
{
    public function selected($model, $id){
        if($model=='course'){
            $students=Course::find($id)->students;
        }
        if($model=='klass'){
            $students=Klass::find($id)->students;
        }
        //dd($model, $students);

        return Inertia::render('Teacher/SelectedStudents',[
            'students'=>$students
        ]);
    }

    public function profile(Student $student){
        //$student->with('address')->with('identity_document')->with('bank')->with('detail')->with('parent')->with('guardian');
        $student->detail;
        $student->address;
        $student->health;
        $student->identity_document;
        $student->bank;
        $student->relatives;
        $student->guardians;
        //$student->archives=$student->archives();
        
        $student->medias=$student->klassStudent?$student->klassStudent->media->all():null;
        $student->avatars=$student->avatars();
        $student->siblings=$student->siblings();

        return Inertia::render('Director/StudentProfile',[
            'student'=>$student
        ]);

    }
}
