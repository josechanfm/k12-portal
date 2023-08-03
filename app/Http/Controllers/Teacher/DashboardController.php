<?php

namespace App\Http\Controllers\Teacher;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Staff;
use App\Models\Teacher;
use App\Models\Course;

class DashboardController extends Controller
{
    public function index(){
        $staff=Staff::where('user_id',auth()->user()->id)->with('courses')->first();
        //$teacher=Teacher::with('courses')->whereBelongsTo($staff)->first();
        return Inertia::render('Teacher/Dashboard',[
            'teacher'=>$staff
        ]);
    }
}
