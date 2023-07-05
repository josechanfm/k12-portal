<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\CourseStudent;
use App\Models\Makeup;

class MakeupController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(){
        echo '全年所有級/班補考人名單總表<br>';
        echo '入分及結果, 不合格名單<br>';
        echo 'makeup index<br>';
        echo '大粒總表定升,留,補考,';
    }
    public function createOrCancel(Request $request)
    {
        $courseStudent=CourseStudent::where('course_id',$request->course_id)->where('student_id',$request->student_id)->first();
        if($request->mode=='cancel'){
            Makeup::where('course_student_id',$courseStudent->id)->delete();
        }elseif($request->mode=='approve'){
            Makeup::firstOrCreate(
                ['course_student_id' => $courseStudent->id,],
                ['course_student_id' => $courseStudent->id]
            );
        }
        return redirect()->back();
    }

    public function update(Request $request){
        
        Makeup::upsert(
            $request->data,
            ['course_student_id'],
            ['point']
        );
        // return response($request->klass_id);
        // echo json_encode($request->all());
        return redirect()->route('manage.klasses.show',$request->klass_id); 
    }

}
