<?php

namespace App\Http\Controllers\Teacher;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Teacher;
use App\Models\Klass;
use Illuminate\Support\Facades\Auth;


class DashboardController extends Controller
{
    public function index(){
        //$staff=Staff::where('user_id',auth()->user()->id)->first();
        $staff=auth()->user()->staff;
        if(empty($staff)){
            return Inertia::render('Error',[
                'message'=>"You don't have staff permission."
            ]);
            };
        $staff->courses;
       
        //$klasses=Klass::whereRaw('json_contains(klass_head_ids,'.$staff->id.')')->get();
        //dd($staff->klasses());
        $staff->headKlasses=$staff->headKlasses();
        $staff->headSubjects=$staff->headSubjects();
        // dd($staff->klasses());
        //dd($staff);
        return Inertia::render('Teacher/Dashboard',[
            'staff'=>$staff,
            'klassHeadBehaviour'=>Config::item('klass_head_behaviour'),
            'subjectHeadBehaviour'=>Config::item('subject_head_behaviour')
        ]);

    }


}
