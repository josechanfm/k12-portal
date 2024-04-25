<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Candidate;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;

class CandidateController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //dd(Year::currentYear()->grades);
        return Inertia::render('Admin/Candidates',[
            'gradesKlasses'=>Year::currentYear()->gradesKlasses,
            'candidates'=>Candidate::paginate()
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return Inertia::render('Admin/Candidate',[
            'gradesKlasses'=>Year::currentYear()->gradesKlasses,
            'candidate'=>Candidate::make()
        ]);        
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //enroll_confirm column is not included in fillable
        Candidate::create($request->all());
        return redirect()->back();
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit(Candidate $candidate)
    {
        
        return Inertia::render('Admin/Candidate',[
            'gradesKlasses'=>Year::currentYear()->gradesKlasses,
            'candidate'=>$candidate
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Candidate $candidate, Request $request)
    {
        //enroll_confirm column is not included in fillable
        $candidate->update($request->all());
        return to_route('admin.candidates.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
    public function enroll(Candidate $candidate, Request $request){
        //enroll_confirm column is not included in fillable
        if($request->enroll_confirm && $request->enroll_confirm==true){
            $candidate->update($request->all());
            $candidate->enrolled=true;
            $candidate->save();
            return to_route('admin.candidates.index');
        }else{
            return redirect()->back()->withErrors(['message'=>'Illegal enrollment process']);
        }
        
    }
}
