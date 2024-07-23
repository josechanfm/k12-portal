<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Year;
use App\Models\Grade;
use App\Models\ThemeTemplate;
use App\Models\Topic;
use App\Models\TopicTemplate;

class ThemeTemplateController extends Controller
{
    public function list(){
        $grade=Grade::with('year')->whereBelongsTo(Year::currentYear())->where('grade_year',1)->first();
        return redirect()->route('master.grade.themeTemplates.index',$grade);
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index($gradeId)
    {
        $grade=Grade::find($gradeId);
        $year=Year::with('kGrades')->find($grade->year_id);

        $themeTemplates=ThemeTemplate::where('grade_year',$grade->grade_year)->with('TopicTemplates')->get();
        //dd($themeTemplates);
        //dd(Config::item('topic_abilities'));
        return Inertia::render('Master/ThemeTemplates',[
            'year'=>$year,
            'grade'=>$grade,
            'yearTerms'=>Config::item('year_terms'),
            'themeTemplates'=>$themeTemplates,
            'topicAbilities'=>Config::item('topic_abilities'),
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
    public function store(ThemeTemplate $themeTemplate, Request $request)
    {
        
        ThemeTemplate::create($request->all());
        // dd($request->all());
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
    public function update(ThemeTemplate $themeTemplate, Request $request)
    {
        $themeTemplate->update($request->all());
        return redirect()->back();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Grade $grade, ThemeTemplate $themeTemplate)
    {

        if($themeTemplate->topicTemplates->count()>0){
            return redirect()->back()->withErrors(['message'=>'The selected theme has child topics, could not delete.']);
        }else{
            $themeTemplate->delete();
            return redirect()->back();
        }

        
    }
}
