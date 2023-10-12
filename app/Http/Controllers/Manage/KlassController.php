<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Year;
use App\Models\Klass;
use App\Models\Teacher;
use App\Models\Transcript;
use App\Models\AdditiveTemplate;

class KlassController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function index()
    {
        $klass = Klass::with('courses')->find(1);
        //$teacher = Teacher::with('courses')->find(1);
        return response()->json($klass);
        //return response($klass);
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
    public function show(Klass $klass)
    {
        $klass->grade;
        $klass->courses;
        //$courses = Klass::find($klass->id)->courses;
        $klass->students;

        // dd($courses);
        return Inertia::render('Manage/Klasses', [
            //'grade' => $grade,
            'currentTerm'=>Year::currentTerm(),
            'klass' => $klass,
            //'courses' => $courses,
            //'students'=>$students,
            'additiveTemplates'=>AdditiveTemplate::all(),
            'additiveStyle'=>Config::item('additive_style'),
            'additiveGroups'=>Config::item('additive_groups')
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
    public function update(Request $request, $id)
    {
        //
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

    public function klass_scores($klassId)
    {
        $scores = Klass::klass_scores($klassId);
        echo $scores;
    }

    public function students(Klass $klass)
    {
        return Inertia::render('Manage/KlassStudents', [
            'klass' => $klass,
            'students' => $klass->students,
        ]);
    }

    public function finalScores(Klass $klass)
    {
        // dd($klass->finalScores());
        $year=Year::find(Year::currentYear()->id);
        $year->klasses;
        $year->grades;
        //dd($klass->finalScores());
        return Inertia::render('Manage/KlassFinalScores', [
            'year'=>$year,
            'klass' => $klass,
            'transcriptTemplates' => $klass->grade->transcriptTemplates(),
            'finalScores' => $klass->finalScores()
        ]);
    }

    //public function behaviours(Klass $klass){
        // $year=Year::find(Year::currentYear()->id);
        // $year->klasses;
        // $year->grades;
        // return Inertia::render('Manage/KlassBehaviours',[
        //     'year'=>$year,
        //     'yearTerms'=>Config::item('year_terms'),
        //     'currentTerm'=>Year::currentTerm(),
        //     'staff'=>auth()->user()->staff,
        //     'klass'=>$klass,
        //     'behaviours'=>$klass->behaviours('DIRECTOR')
        // ]);

    //}
}
