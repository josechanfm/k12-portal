<?php

namespace App\Http\Controllers\Medical;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;
class DashboardController extends Controller
{
    //

    public function index(){
        return Inertia::render('Medical/Dashboard',[
            //'klass'=>Klass::whereBelongsTo(Grade::whereBelongsTo(Year::currentYear())->where('grade_year',4)->first())->first()
        ]);
        // $physical=Physical::find(1);
        // $physical->chronicles;
        // dd($physical);
    
    }
    // public function klass(Klass $klass){
    //     $klass->healthcares;
    //     return Inertia::render('Medical/Klass',[
    //         'klass'=>$klass
    //     ]);

    // }

}
