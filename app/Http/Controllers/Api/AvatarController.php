<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\Models\Year;
use App\Models\Klass;

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
        $student=Year::currentYear()->grades->where('tag',$gradeTag)->first()->klasses->where('letter',$klassLetter)->first()->students->where('pivot.student_number',$studentNumber)->first();
        return json_encode($student);
    }
    public function upload(Request $request){
        //Storage::put($request->file[0]['originFileObj'],'abc123.png');
        return response()->json([
            'message' => 'Photo uploaded successfully, bjose',
            'photo_path' => 'okok path',
            'file'=>$request->file('file')
        ]);

        // return response()->json([
        //     'message' => 'No photo uploaded',
        // ], 400);

        
    }
}
