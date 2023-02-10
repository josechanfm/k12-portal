<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Behaviour;
use App\Models\KlassStudent;
use Inertia\Inertia;

class BehaviourController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $ksid=$request->ksid;
        $klassStudent=KlassStudent::with('student')->with('behaviours')->with('klass')->find($ksid);
        $behaviours=Config::item('behaviour_genres');
        $terms=Config::item('year_terms');
        // $klass=Klass::with('students')->find($kid);
        // $terms=Config::item('year_terms');
        // $habitColumns=Config::item('behaviour_genres');
        // $habits=Behaviour::byKlassId($kid);
        return Inertia::render('Manage/Behaviour',[
            'klassStudent'=>$klassStudent,
            'behaviours'=>$behaviours,
            'terms'=>$terms,
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
