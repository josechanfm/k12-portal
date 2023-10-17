<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Theme;
use App\Models\Topic;

class ThemeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Klass $klass)
    {
        return Inertia::render('Admin/KlassThemes',[
            'yearTerms'=>Config::item('year_terms'),
            'topicAbilities'=>Config::item('topic_abilities'),
            'klass'=>$klass,
            'themes'=>$klass->themes,
            'topicTemplates'=>Topic::all(),
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
        $data=$request->all();
        $data['sequence']=Theme::where('klass_id',$klass->id)->get()->count()+1;
        Theme::create($data);
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
    public function update(Klass $klass, Theme $theme, Request $request)
    {
        $theme->update($request->all());
        return redirect()->back();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Klass $klass, Theme $theme)
    {
        if($theme->topics->count()>0){
            return redirect()->back()->withErrors(['message'=>'The selected theme has child topics, could not delete.']);
        }else{
            $theme->delete();
            return redirect()->back();
        }
    }
}
