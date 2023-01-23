<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Subject;
use App\Models\Klass;
use App\Models\Config;

class YearPlanController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if(!$request->yearId){
            return redirect('/admin');
        }
        $yearId=$request->yearId;
        $year=Year::find($yearId);
        $subjects=Subject::where('active',1)->get();
        $klassOptions=Klass::select('id as value','acronym as label')->where('year_id',$yearId)->get();
        $klasses=Klass::where('year_id',$yearId)->get();
        $config=json_decode(Config::where('key','grades')->first()->value,true);
        $grades=json_decode(Config::where('key','grades')->first()->value,true);
        $klassesSubjects=Klass::where('year_id',$yearId)->with('subjects')->get();
        return Inertia::render('Admin/Dashboard',[
            'year'=>$year,
            'subjects'=>$subjects,
            'klasses'=>$klasses,
            'klassOptions'=>$klassOptions,
            'config'=>$config,
            'grades'=>$grades,
            'klassesSubjects'=>$klassesSubjects
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return Inertia::render('Admin/Dashboard');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
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
