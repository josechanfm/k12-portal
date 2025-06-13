<?php

namespace App\Http\Controllers\Student;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Form;

class DashboardController extends Controller
{
    public function index(){
        return Inertia::render('Student/Dashboard',[
            'student'=>auth()->user()->student->load('courses')->load('messages'),
            'forms'=>Form::where('published', true)->whereJsonContains('for_whom','student')->orderBy('created_at','DESC')->get()
        ]);
    }
}
