<?php

namespace App\Http\Controllers\Director\Pre;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Behaviour;
use App\Models\Year;
use Inertia\Inertia;
use PDO;

class BehaviourController extends Controller
{


    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Klass $klass)
    {
        dd(auth()->user());
        if(empty(auth()->user()->staff)){
            return Inertia::render('Error',[
                'message'=>"You are not subject teacher."
            ]);
    
        }
        $year=Year::find(Year::currentYear()->id);
        $year->klasses;
        $year->grades;
        //dd($klass->behaviours('DIRECTOR')['scores'][316][1]);
        return Inertia::render('Director/Pre/Behaviours',[
            'year'=>$year,
            'yearTerms'=>Config::item('year_terms'),
            'currentTerm'=>Year::currentTerm(),
            'staff'=>auth()->user()->staff,
            'klass'=>$klass,
            'behaviours'=>$klass->behaviours('DIRECTOR')
        ]);

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        dd('ok created');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        $behaviour=new Behaviour();
        $behaviour->klass_student_id=$request->klass_student_id;
        $behaviour->term_id=$request->term_id;
        $behaviour->genre=$request->genre;
        $behaviour->date=date('Y-m-d',strtotime($request->date));
        $behaviour->qty=$request->qty;
        $behaviour->description=$request->description;
        $behaviour->remark=$request->remark;
        $behaviour->save();
        return response($behaviour);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Klass $klass, $id)
    {
        //dd($id);
        //dd($klass->behaviourSummary()[0]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
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

    public function adjust(Klass $klass){
        $year=Year::find(Year::currentYear()->id);
        $year->klasses;
        $year->grades;
        $klass->grade;
        //dd($klass->behaviourSummary());
        return Inertia::render('Director/Pre/BehaviourAdjust',[
            'year'=>$year,
            'yearTerms'=>Config::item('year_terms'),
            'currentTerm'=>Year::currentTerm(),
            'staff'=>auth()->user()->staff,
            'klass'=>$klass,
            'behaviours'=>$klass->behaviourSummary()
        ]);
    }

}
