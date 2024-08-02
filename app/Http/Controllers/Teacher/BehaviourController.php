<?php

namespace App\Http\Controllers\Teacher;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Course;
use App\Models\Behaviour;
use App\Models\Year;
use Inertia\Inertia;
use PDO;

class BehaviourController extends Controller
{

    public function selected($model, $id){
        if(empty(auth()->user()->staff)){
            return Inertia::render('Error',[
                'message'=>"You are not subject teacher."
            ]);
        }
        $actor=auth()->user()->hasRole('director')?'DIRECTOR':'SUBJECT';
        if($model=='klass'){
            $klass=Klass::find($id);
            $course=null;
            $behaviours=$klass->behaviours($actor);
        }else if($model=='course'){
            $course=Course::find($id);
            $course->staffs;
            $course->klass;
            $klass=Klass::find($course->klass_id);
            $behaviours=$klass->behaviours($actor);
        }else{
            return Inertia::render('Error',[
                'message'=>"Route incorrect!"
            ]);
        }
        //dd($klass,$klass->behaviours()['scores']);
        //dd($klass->behaviours()['scores'][362   ], $klass, $course);
        return Inertia::render('Teacher/SelectedBehaviours',[
            'staff'=>auth()->user()->staff,
            'yearTerms'=>Config::item('year_terms'),
            'course'=>$course,
            'klass'=>$klass,
            'behaviours'=>$behaviours
        ]);

    }
/*
    public function list(){
        $year=Year::find(Year::currentYear()->id);
        $grade=$year->grades->where('grade_year',4)->first();
//        dd($grade->klasses->first()->id);     
        return redirect()->route('director.klass.behaviour.summary',$grade->klasses->first());   
    }
    */
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Klass $klass)
    {
        dd($klass);
        if(empty(auth()->user()->staff)){
            return Inertia::render('Error',[
                'message'=>"You are not subject teacher."
            ]);
    
        }
        //dd($klass->behaviours('DIRECTOR')['scores'][316][1]);
        return Inertia::render('Teacher/KlassBehaviours',[
            'yearTerms'=>Config::item('year_terms'),
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
        if($request->id){
            Behaviour::find($request->id)->update($request->all());
        }else{
            Behaviour::create($request->all());
        }
        return response()->json(['message'=>'Success']);
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
        $klass->grade;
        return Inertia::render('Director/BehaviourAdjust',[
            'currentTerm'=>Year::currentTerm(),
            'staff'=>auth()->user()->staff,
            'klass'=>$klass,
            'behaviours'=>$klass->behaviourSummary()
        ]);
    }

}
