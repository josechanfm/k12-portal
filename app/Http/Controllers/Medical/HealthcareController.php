<?php

namespace App\Http\Controllers\Medical;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Klass;
use App\Models\Healthcare;
use App\Models\Physical;

class HealthcareController extends Controller
{
    public function dashboard(){
        $healthcare=Healthcare::find(1);
        $healthcare->chronicles;
        dd($healthcare);
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Klass $klass)
    {
        $klass->healthcares;
        return Inertia::render('Medical/Healthcare',[
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
    public function store(Request $request)
    {
        $input=$request->all();
        $input['data_fields']=json_decode($request->data_fields);
        $healthcare=Healthcare::create($input);
        foreach($healthcare->klass->students as $student){
            foreach($healthcare->data_fields as $field){
                $data[]=[
                    'healthcare_id'=>$healthcare->id,
                    'klass_student_id'=>$student->pivot->klass_student_id,
                    'field_name'=>$field['value'],
                    'value'=>NULL
                ];
            };
        };
        Physical::upsert(
            $data,
            ['healthcate_id','klass_student_id','field_name'],
            ['value']
        );    
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Healthcare $healthcare)
    {
        $healthcare->physicals;
        $healthcare->klass;
        return Inertia::render('Medical/Healthcare',[
            'healthcare'=>$healthcare
        ]);
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
    public function update(Healthcare $healthcare, Request $request)
    {
        $input=$request->all();
        $input['data_fields']=json_decode($request->data_fields);
 
        $healthcare->update($input);
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
