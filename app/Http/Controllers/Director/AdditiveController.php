<?php

namespace App\Http\Controllers\Director;

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
        //dd($klass, $category,$categories);
        if(!in_array(strtoupper($category),$categories)){
            return redirect()->route('director.dashboard');
        }
        return Inertia::render('Director/KlassAdditives',[
            'yearTerms'=>Config::item('year_terms'),
            'klass'=>$klass,
            'currentTerm'=>Year::currentTerm(),
            'additiveTemplates'=>AdditiveTemplate::all(),
            'additives'=>$klass->additives($category,'2')
        ]);
    }

    public function page(Klass $klass){
        $klass->grade;
        $klass->courses;
        //$courses = Klass::find($klass->id)->courses;
        $klass->students;

        // dd($courses);
        return Inertia::render('Director/KlassAdditivesPage', [
            'yearTerms'=>Config::item('year_terms'),
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
        return Inertia::render('Director/KlassAdditivesDirect', [
            'yearTerms'=>Config::item('year_terms'),
            'klass' => $klass,
            'additives'=>$klass->additives(),
            'additiveGroups'=>Config::item('additive_groups')
        ]);
    }

    public function directInput(Klass $klass, Request $request){
        //return response()->json($request->all());
        if(isset($request->value)){
            //return response()->json($request->all());
            forEach($request->value as $termId=>$value){
                if($value){
                    Additive::updateOrCreate(
                        ['klass_student_id'=>$request->klass_student_id, 'term_id'=>$termId, 'reference_code'=>$request->reference_code],
                        ['value'=>$value,'user_id'=>auth()->user()->id,'submit_at'=>date('Y-m-d')]
                    );
                }
            }
        }else{
            Additive::where('klass_student_id',$request->klass_student_id)->where('reference_code',$request->reference_code)->delete();
        }
        return redirect()->back();
    }

}
