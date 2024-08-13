<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\Models\Year;
use App\Models\Klass;
use App\Models\KlassStudent;

class AvatarController extends Controller
{
    public function verifyFilename(Request $request){
        $filename = pathinfo($request->filename)['filename'];
        /*Array(
                [dirname] => /some/path
                [basename] => P1A01.jpg
                [extension] => jpg
                [filename] => P1A01
        )*/
        $gradeTag=substr($filename,0,strlen($filename)-3);
        $klassLetter=substr($filename,strlen($filename)-3,strlen($filename)-4);
        $studentNumber=intval(substr($filename,-2));
        //return $gradeTag.'/'.$klassLetter.'/'.$studentNumber;
        $student=Year::currentYear()
            ->grades->where('tag',$gradeTag)->first()
            ->klasses->where('letter',$klassLetter)->first()
            ->students->where('pivot.student_number',$studentNumber)->first();
        if($student){
            return json_encode($student);
        }
        return false;
    }
    public function klcassStuent(Request $request){
        $filename = pathinfo($request->filename)['filename'];
        $klassStudentId =$request->klassStudentId;
        $student=KlassStudent::with(['student','klass'])->first();
        dd($student);
        /*Array(
                [dirname] => /some/path
                [basename] => P1A01.jpg
                [extension] => jpg
                [filename] => P1A01
        )*/
        $gradeTag=substr($filename,0,strlen($filename)-3);
        $klassLetter=substr($filename,strlen($filename)-3,strlen($filename)-4);
        $studentNumber=intval(substr($filename,-2));
        //return $gradeTag.'/'.$klassLetter.'/'.$studentNumber;
        $student=Year::currentYear()
            ->grades->where('tag',$gradeTag)->first()
            ->klasses->where('letter',$klassLetter)->first()
            ->students->where('pivot.student_number',$studentNumber)->first();
        if($student){
            return json_encode($student);
        }
        return false;
    }
}
