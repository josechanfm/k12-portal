<?php

namespace App\Http\Controllers\Medical;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Klass;
class DashboardController extends Controller
{
    //

    public function index(){
        return Inertia::render('Medical/Dashboard',[
        ]);
        // $physical=Physical::find(1);
        // $physical->chronicles;
        // dd($physical);
    
    }
    public function klass(Klass $klass){
        $klass->physicals;
        return Inertia::render('Medical/Klass',[
            'klass'=>$klass
        ]);

    }

}
