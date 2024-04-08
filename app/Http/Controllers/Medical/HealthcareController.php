<?php

namespace App\Http\Controllers\Medical;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;
use App\Models\Healthcare;
use App\Models\Bodycheck;

class HealthcareController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        //$klass->healthcares;
        //dd(Healthcare::with('klasses')->get());
        if($request->scope=='all'){
            $healthcares=Healthcare::with('klasses')->orderBy('created_at','DESC')->paginate();
        }else{
            $healthcares=Healthcare::with('klasses')
                ->where('is_active',true)
                ->where('finish_at','<',date('Y-d-m'))
                ->orWhereNull('finish_at')
                ->orderBy('created_at','DESC')
                ->paginate();
        }

        return Inertia::render('Medical/Healthcares',[
            'grades'=>Grade::where('year_id',Year::currentYear()->id)->with('klasses')->get(),
            'healthcares'=>$healthcares,
            'bodycheck_columns'=>Config::item('bodycheck_columns')
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
        $healthcare=Healthcare::create($input);
        $healthcare->klasses()->sync($input['klass_ids']);

        foreach($healthcare->klasses as $klass){
            foreach($klass->students as $student){
                foreach($input['bodycheck_columns'] as $column){
                    $bodycheck=Bodycheck::firstOrCreate(
                        [
                            'healthcare_id'=>$healthcare->id,
                            'klass_student_id'=>$student->pivot->klass_student_id,
                            'column_value'=>$column,
                            'value'=>null
                        ]
                    );

                }
            }
        }
        return redirect()->back();
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Healthcare $healthcare)
    {
        // dd($healthcare->physicals[0]);
        //$healthcare->klass;
        //$healthcare->klasses=$healthcare->klasses();
        return Inertia::render('Medical/Healthcare',[
            'healthcare'=>$healthcare,
            'klasses'=>$healthcare->klasses,
            'bodycheck_columns'=>Config::item('bodycheck_columns')
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

        // dd($request->all());
        $input=$request->all();
        $healthcare->update($input);
        $healthcare->klasses()->sync($input['klass_ids']);
        foreach($healthcare->klasses as $klass){
            foreach($klass->students as $student){
                foreach($input['bodycheck_columns'] as $column){
                    $bodycheck=Bodycheck::firstOrCreate(
                        [
                            'healthcare_id'=>$healthcare->id,
                            'klass_student_id'=>$student->pivot->klass_student_id,
                            'column_value'=>$column,
                            'value'=>null
                        ]
                    );

                }
            }
        }
    
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


    public function getBodychecks(Healthcare $healthcare, Klass $klass){
        
        //return response()->json($healthcare->bodychecks);
        $students=$klass->students;
        foreach($students as $i=>$student){
            // $bodychecks=array_column($healthcare->bodychecks->where('klass_student_id',$student->pivot->klass_student_id)->toArray(),null,'column_value');
            // return response()->json($bodychecks);
            $students[$i]->bodychecks=array_column($healthcare->bodychecks->where('klass_student_id',$student->pivot->klass_student_id)->toArray(),null,'column_value');
        }
        return response()->json($students);

    }
}
