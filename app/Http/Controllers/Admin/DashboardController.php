<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Config;

class DashboardController extends Controller
{
    public function index(){
        $currentYear=Year::currentYear();
        return  Inertia::render('Admin/Dashboard',[
            'currentYear'=>$currentYear,
            'grades'=>Grade::with('klasses')->whereBelongsTo($currentYear)->get(),
        ]);    
    }
}
