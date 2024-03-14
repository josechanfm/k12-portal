<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Klass;

class DashboardController extends Controller
{
    public function index(){
        $year=Year::find(Year::currentYear()->id);
        $grade=$year->grades->where('grade_year',4)->first();
        return Inertia::render('Manage/Dashboard',[
            'defaultKlass'=>$grade->klasses->first()
        ]);
    }
}
