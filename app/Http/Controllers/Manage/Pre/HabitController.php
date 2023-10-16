<?php

namespace App\Http\Controllers\Manage\Pre;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Klass;
use App\Models\KlassStudent;
use App\Models\Habit;

class HabitController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function klass(Klass $klass){
        $klass=Klass::with('students')->find($klass->id);
        $terms=Config::item('year_terms');
        $habitColumns=Config::item('habit_columns');
        //dd(Habit::byKlassId($klass->id));
        
        //$habits=Habit::byKlassId($klass->id);
        $klass->habits;
        $klass->students;
        //dd($klass->habitsScores());
        return Inertia::render('Manage/Pre/Habit',[
            'klass'=>$klass,
            'yearTerms'=>$terms,
            'habitColumns'=>$habitColumns,
            'habits'=>$klass->habitsScores()
        ]);
    }

    // public function index(Request $request)
    // {
    //     $kid=$request->kid;
    //     $klass=Klass::with('students')->find($kid);
    //     $terms=Config::item('year_terms');
    //     $habitColumns=Config::item('habit_columns');
    //     $habits=Habit::byKlassId($kid);

    //     return Inertia::render('Manage/Habit',[
    //         'klass'=>$klass,
    //         'terms'=>$terms,
    //         'habitColumns'=>$habitColumns,
    //         'habits'=>$habits
    //     ]);
    // }

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
    public function update(Request $request, $id)
    {

        $data=$request->all();
        //return response()->json($data);
        Habit::upsert(
            $data,
            ['klass_student_id','term_id'],
            array_column(Config::item('habit_columns'),'name')
        );
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
