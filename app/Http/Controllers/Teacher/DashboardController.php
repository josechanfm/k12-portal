<?php

namespace App\Http\Controllers\Teacher;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Staff;
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
        //dd($staff->courses);
        
        //$klasses=Klass::whereRaw('json_contains(klass_head_ids,'.$staff->id.')')->get();
        //dd($staff->klasses());

        $staff->klasses=$staff->klasses();
        
        return Inertia::render('Teacher/Dashboard',[
            'staff'=>$staff
        ]);

    }


}
