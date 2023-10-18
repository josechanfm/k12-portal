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
    public function index(Grade $grade)
    {
        $grades=Year::currentYear()->grades->where('grade_year','<=',3);
        $topics=TopicTemplate::where('theme_template_id',1)->get()->toArray();
        dd($topics);
        foreach($grades as $grade){
            if($grade->themeTemplates->count()<=0){
                echo $grade->id .'no themes<br>';
            }else{
                foreach($grade->themeTemplates as $theme){
                    if($theme->topicTemplates->count()<=0){
                        foreach($topics as $i=>$topic){
                            $topics[$i]['theme_tempalte_id']=$theme->id;
                        }
                        TopicTemplate::create($topics);
                    }
                }
            }
        }
        dd($grades);
        $year=$grade->year;
        return Inertia::render('Master/GradeThemeTemplates',[
            'yearTerms'=>Config::item('year_terms'),
            'topicAbilities'=>Config::item('topic_abilities'),
            'year'=>$year,
            'grades'=>$year->grades->where('grade_year','<=',3),
            'grade'=>$grade,
            'themeTemplates'=>$grade->themeTemplates,
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
    public function store(Grade $grade, Request $request)
    {
        ThemeTemplate::create($request->all());
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
    public function update(Grade $grade, ThemeTemplate $themeTemplate, Request $request)
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
