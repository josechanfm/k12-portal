<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use App\Models\TopicTemplate;
use Illuminate\Http\Request;
use App\Models\Config;
use App\Models\Grade;

class TopicTemplateController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
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
    public function store(Grade $grade, Request $request)
    {
        
        $data=$request->all();
        $data['sequence']=TopicTemplate::where('theme_template_id',$request->theme_template_id)->get()->count()+1;
        
        //$data['section']=>Config:
        $sections=array_column(Config::item('topic_abilities'),'label','value');
        $data['section']=$sections[$request->section_code];
        TopicTemplate::create($data);
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
    public function update(Grade $grade, TopicTemplate $topicTemplate, Request $request)
    {
        $topicTemplate->update($request->all());
        return redirect()->back();
        
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Grade $grade, TopicTemplate $topicTemplate)
    {
        $topicTemplate->delete();
        return redirect()->back();
    }
}
