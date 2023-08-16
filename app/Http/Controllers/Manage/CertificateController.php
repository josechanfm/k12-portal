<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use App\Models\Certificate;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Year;

class CertificateController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Inertia::render('Manage/Certificates',[
            'years'=>Year::all(),
            'terms'=>Config::item('year_terms'),
            'grades'=>Year::currentYear()->grades,
            'klasses'=>Year::currentYear()->klasses,
            'certificateTemplates'=>Config::item('certificates')
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
        $certificates=Certificate::all();
        return response()->json($certificates);
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
        Certificate::upsert(
            $request->all(),
            ['certificate_type','year_id','term_id','student_id'],
            ['issue_date','issue_number','name_display','extra']
        );
        //return response()->json($request->all());
        //return response()->json($id);
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
    public function getByConditions(Request $request){
        $conditions=$request->all();
        if($conditions['year_id']==0){
            $conditions['year_id']=Year::currentYear()->id;
        };
        $certificates=Certificate::where($conditions)->with('student')->get();

        foreach($certificates as $i=>$certificate){
            $certificates[$i]->student->klass=$certificate->student->klasses()->latest()->first();
        }

        return response()->json($certificates);
    }
}
