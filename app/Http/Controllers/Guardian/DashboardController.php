<?php

namespace App\Http\Controllers\Guardian;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Form;

class DashboardController extends Controller
{
    public function index(){
        // dd(auth()->user()->guardian->load('messages'));
        return Inertia::render('Guardian/Dashboard',[
            'guardian'=>auth()->user()->guardian->load('students')->load('messages'),
            'forms'=>Form::where('published', true)->whereJsonContains('for_whom','guardian')->orderBy('created_at','DESC')->get()
        ]);
    }
}
