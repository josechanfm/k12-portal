<?php

namespace App\Http\Controllers\Medical;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Medicnote;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;

class MedicnoteController extends Controller
{

    public function dashboard(){
        $klass=Klass::whereBelongsTo(Grade::whereBelongsTo(Year::currentYear())->where('grade_year',4)->first())->first();
        return redirect()->route('medical.klass.medicnotes.index',$klass);
        //return Inertia::render('Medical/MedicnoteDashboard',[
    
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Klass $klass)
    {
        $klass->medicnotes;
        return Inertia::render('Medical/Medicnotes',[
            'klass'=>$klass
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
    public function store(Klass $klass, Request $request)
    {
        Medicnote::create($request->all());
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

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit(Medicnote $healthcare)
    {
        echo json_encode($healthcare);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Klass $klass, $id, Request $request)
    {
        if($id==0){
            Medicnote::create($request->all());
        }else{
            Medicnote::find($id)->update($request->all());
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
