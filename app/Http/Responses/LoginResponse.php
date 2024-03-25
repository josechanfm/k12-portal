<?php

namespace App\Http\Responses;

use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\URL;
use Laravel\Fortify\Contracts\LoginResponse as LoginResponseContract;
use App\Models\Member;
use Inertia\Inertia;

class LoginResponse implements LoginResponseContract
{
    /**
     * Create an HTTP response that represents the object.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function toResponse($request)
    {
        if(Auth()->user()->guardian){
            return redirect()->route('guardian.dashboard');
        }
        if(Auth()->user()->hasRole('admin')){
            return redirect()->route('admin.dashboard');
        }
        if(Auth()->user()->hasRole('director')){
            return redirect()->route('director.dashboard');
        }
        
        $member=Auth()->user()->member;
        if($member){
            if($member->organizations->count()>0){
                session(['organization'=>$member->organizations[0]]);
                return redirect()->route('member.dashboard');
            }
            return Inertia::render('Error',[
                'message'=>"You don't belongs to any organization"
            ]);
        }
        if(Auth()->user()->organizations->count()>0){
            session(['organization'=>Auth()->user()->organizations[0]]);
            return redirect()->route('manage');
        }

        return $request->wantsJson()
            ? response()->json(['two_factor' => false])
            : redirect()->intended(config('fortify.home'));
    }
}