<?php

namespace App\Http\Controllers\Teacher;

use App\Http\Controllers\Controller;
use App\Models\Behaviour;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Course;
use App\Models\Klass;
use App\Models\Year;
use App\Models\Config;

class BehaviourController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function klass(Klass $klass){
        if($klass->isKlassHead() ){
            return Inertia::render('Teacher/Behaviours',[
                'yearTerms'=>Config::item('year_terms'),
                'currentTerm'=>Year::currentTerm(),
                'staff'=>auth()->user()->staff,
                //'course'=>$course,
                'klass'=>$klass,
                'behaviours'=>$klass->behaviours('KLASS_HEAD')
            ]);
        }
    }
    public function index(Course $course)
    {
        //dd($staff->coursesBehaviours[0]->studentsBehaviours);
        //dd(in_array(2,$course->subject_head_ids));
        // if($course->isTeacher() || $course->isSubjectHead()){
        //dd($course->behaviours());
        
        if($course->isTeacher() ){
            return Inertia::render('Teacher/Behaviours',[
                'yearTerms'=>Config::item('year_terms'),
                'currentTerm'=>Year::currentTerm(),
                'staff'=>auth()->user()->staff,
                'course'=>$course,
                'behaviours'=>$course->behaviours()
            ]);
        }
        // if($course->isKlassHead() ){
        //     return Inertia::render('Teacher/Behaviours',[
        //         'staff'=>auth()->user()->staff,
        //         'behaviours'=>$course->behaviours()
        //     ]);
        // }

        return Inertia::render('Error',[
            'message'=>"You are not subject teacher."
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store($id, Request $request)
    {
        
        if(is_null($request->score)){
            return redirect()->back();
        };
        $data['klass_student_id']=$request->klass_student_id;
        $data['term_id']=$request->term_id;
        $data['staff_id']=$request->staff_id??auth()->user()->staff->id;
        $data['reference_id']=$request->reference_id;
        $data['actor']=$request->actor;
        Behaviour::updateOrCreate(
            $data, 
            ['actor'=>$request->actor,'score'=>$request->score]
        );
        return response()->json('done');
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
}
