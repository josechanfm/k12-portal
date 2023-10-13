<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Ability;
use App\Models\Theme;

class AbilityController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function klass(Klass $klass){
        //dd($klass->abilitiesScores());
        //dd($klass->grade->themes);
        //dd($klass->themes);
        //dd($klass->grade->topics);
        $terms=Config::item('year_terms');

        return Inertia::render('Manage/Ability',[
            'yearTerms'=>Config::item('year_terms'),
            'klass'=>$klass,
            'themes'=>$klass->themes,
            'topics'=>$klass->grade->topics,
            // 'abilities'=>$klass->abilities,
            'students_abilities'=>$klass->students_abilities,
            'abilities'=>$klass->abilitiesScores()
        ]);

    }

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
    public function update(Klass $klass, Request $request)
    {
        
        //return $request->all();
        Ability::upsert(
            $request->all(),
            ['klass_student_id','topic_id','term_id'],
            ['credit']
        );
        return count($request->all());


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
