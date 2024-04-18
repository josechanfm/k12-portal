<?php

namespace App\Http\Controllers\Director;

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
        if($grade){
            $klass=$grade->klasses->first();
        }else{
            $klass=null;
        };
        return Inertia::render('Director/Dashboard',[
            'defaultKlass'=>$klass
        ]);
    }
}
