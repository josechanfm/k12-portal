<?php

namespace App\Http\Controllers\Guardian;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(){
        $guardian=Auth()->user()->guardian;
        $guardian->students;
        dd($guardian);
    }
}
