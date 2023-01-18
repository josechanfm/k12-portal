<?php

namespace App\Http\Controllers\Essential;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Config;

class GradeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $yearId=$request->input('yearId');
        if($yearId){
            $year=Year::find($yearId);
        }else{
            $year=Year::where('active',1)->orderBy('start','DESC')->first();
        }

        $grades = Grade::with('subjects')->whereBelongsTo($year)->get();
        return Inertia::render('Essential/Grades',[
            'year'=>$year,
            'grades'=>$grades,
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
        if($request->has('id')){
            $grade=Grade::find($id);
            $grade->year_id=1;
            $grade->rank=$request->rank;
            $grade->initial=$request->initial;
            $grade->initial=$request->level;
            $grade->tag=$request->initial.$request->level;
            $grade->title_zh=$request->title_zh;
            $grade->title_en=$request->title_en;
            $grade->description=$request->description;
            $grade->version=$request->version;
            $grade->active=$request->active;
            $grade->update($request->all());
        }
        return redirect()->back();
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
