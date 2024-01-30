<?php

namespace App\Http\Controllers\Manage\Pre;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Habit;
use App\Exports\KlassHabitExport;
use App\Imports\KlassHabitImport;
use Maatwebsite\Excel\Facades\Excel;

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
        return Inertia::render('Manage/Pre/KlassHabits',[
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

    public function export(Klass $klass, Request $request){
        $yearTerms=Config::item('year_terms');
        $termId=$request->term_id;
        $term = array_reduce($yearTerms, static function ($carry, $item) use($termId) {
            return $carry ?? ($item->value == $termId ? $item : $carry);
        }, null);
        $fileName=$klass->tag.'_'.$term->label.'_生活習慣和態度.xlsx';
        return Excel::download(new KlassHabitExport($klass,$request->term_id??1),$fileName);
    }

    public function import(Klass $klass, Request $request){
        $importFile=$request->file('importFile');
        if(empty($importFile)){
            return redirect()->back();
        }
        $habits=Excel::toArray(new KlassHabitImport($klass), $importFile);
        foreach($habits[0] as $key=>$habit){
            //skip first row of header
            if($key==0) continue;
            //check Control code, remove row if not match
            $controlCode=explode('-',$habit[0]);
            $hash=hash('crc32',$klass->id.hexdec($controlCode[1]));
            if($hash != $controlCode[0]){
                array_splice($habits[0],$key,1);
            };
            //tream from right 1 charactor
            for($i=4;$i<=count($habit)-1;$i++){
                if(!empty($habits[0][$key])){
                    $habits[0][$key][$i]=substr($habits[0][$key][$i],-1);
                }
            }
        }
        return Inertia::render('Manage/Pre/KlassHabitsImport',[
            'klass'=>$klass,
            'importData'=>$habits[0],
        ]);
    }

    public function importConfirmed(Klass $klass, Request $request){
        $importData=$request->importData;
        array_splice($importData,0,1);
        $habitColumns=Config::item('habit_columns');
        foreach($importData as $import){
            $controlCode=explode('-',$import[0]);
            $habit=Habit::find(hexdec($controlCode[1]));
            foreach($habitColumns as $id=>$column){
                $habit->{$column->name}=$import[$id+4];
            };
            $habit->save();
        };
        return redirect()->route('manage.pre.klass.habits',$klass);
    }
}
