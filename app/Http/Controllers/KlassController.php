<?php

namespace App\Http\Controllers;

use App\Models\Discipline;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Klass;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Disciplines;
use Illuminate\Support\Facades\Validator;

class KlassController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if($request->year){
            return redirect('year/klasses/'.$request->year);
        };
        if($request->klass){
            return redirect('year/klass/disciplines/'.$request->klass);
        };
        $data = Klass::paginate(100);
        //$data=Klass::where('year_id',1)->paginate(5);
        //return response()->json($data);
        return Inertia::render('Admin/Klasses',[
            'klasses'=>$data,
            'school_years'=>Year::select('id as value','abbr as label')->get(),
            'initials'=>[['value'=>'A','label'=>'A'],['value'=>'B','label'=>'B']],
            'grades'=>[['value'=>'P1','label'=>'P1'],['value'=>'P2','label'=>'P2']]
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
        Validator::make($request->all(), [
            'year_id' => ['required'],
            'grade' => ['required'],
            'initial' => ['required'],
        ])->validate();

        Klass::create($request->all());
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
        $data=Klass::find($id)->get();
        return response()->json($data);
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
        Validator::make($request->all(), [
            'year_id' => ['required'],
            'grade' => ['required'],
            'initial' => ['required'],
        ])->validate();
        
        if($request->has('id')){
            $klass=Klass::find($id);
            $klass->year_id=$request->year_id;
            $klass->grade=$request->grade;
            $klass->initial=$request->initial;
            $klass->acronym=$request->acronym?$request->acronym:$request->grade.$request->initial;
            $klass->save();
            //return response()->json($klass);
            return redirect()->back();
            //return redirect()->back();
            //return redirect()->route('settings');
        }else{
            return redirect()->back();
        }
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $klass=Klass::find($id);
        if($klass){
            $klass->delete();
            return redirect()->back()
                ->with('message', 'Blog Delete Successfully');

        }
        
    }

    public function disciplines($klassId){
        $klass=Klass::find($klassId);
        $disciplines=$klass->subjects;
        // foreach($klass as $subject){
        //     echo $subject->subjects()->get();
        //     echo '<hr>';
        // }
        //return response()->json($klass);
        return Inertia::render('Admin/Klass_disciplines',[
            'klass'=>$klass,
            'disciplines'=>$disciplines,
        ]);

    }

}
