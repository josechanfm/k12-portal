<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Additive;
use App\Models\AdditiveTemplate;

class AdditiveController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $additive=Additive::find(1)->template();
        dd(class_basename($additive));

        dd(Additive::find(1)->template());
        dd(AdditiveTemplate::all());
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
        $data=$request->all();
        foreach($data as $d){
            $additive=new Additive();
            $additive->term_id=$d['term_id'];
            $additive->klass_student_id=$d['klass_student_id'];
            $additive->reference_code=$d['reference_code'];
            $additive->value=$d['value']??NULL;
            $additive->remark=isset($d['remark'])?$d['remark']:null;
            $additive->submit_at=date('Y-m-d');
            $additive->user_id=auth()->user()->id;
            $additive->save();
        }
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

    public function scope(Klass $klass, $category){
        $categories=array_column(AdditiveTemplate::all()->toArray(),'category');
        if(!in_array(strtoupper($category),$categories)){
            return redirect()->route('manage');
        }
        return Inertia::render('Manage/KlassAdditives',[
            'additives'=>$klass->additives($category,'2'),
            'additiveTemplates'=>AdditiveTemplate::all(),
            'currentTerm'=>Year::currentTerm()
        ]);
    }

    public function page(Klass $klass){
        $klass->grade;
        $klass->courses;
        //$courses = Klass::find($klass->id)->courses;
        $klass->students;

        // dd($courses);
        return Inertia::render('Manage/KlassAdditivesPage', [
            'klass' => $klass,
            'additives'=>$klass->additives(),
            'additiveGroups'=>Config::item('additive_groups'),
            'currentTerm'=>Year::currentTerm()
        ]);
    }

    public function direct(Klass $klass){
        $klass->grade;
        $klass->courses;
        //$courses = Klass::find($klass->id)->courses;
        $klass->students;

        // dd($courses);
        return Inertia::render('Manage/KlassAdditivesDirect', [
            'klass' => $klass,
            'additives'=>$klass->additives(),
            'additiveGroups'=>Config::item('additive_groups')
        ]);
    }

    public function directInput(Klass $klass, Request $request){
        if(isset($request->value)){
            Additive::updateOrCreate(
                ['klass_student_id'=>$request->klass_student_id, 'reference_code'=>$request->reference_code],
                ['value'=>$request->value,'user_id'=>auth()->user()->id]
            );
        }else{
            Additive::where('klass_student_id',$request->klass_student_id)->where('reference_code',$request->reference_code)->delete();
        }
        return redirect()->back();
    }

}
