<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;
use App\Models\Study;
use App\Models\Config;
use Illuminate\Support\Facades\Validator;

class YearController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $years = Year::withCount('grades')->get();
        $param=Config::item('year_creation');
        return Inertia::render('Admin/Years',[
            'years'=>$years,
            'param'=>$param,
            'yearTerms'=>Config::item('year_terms')
        ]);
        //return response()->json($data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return Inertia::render(
            'Payments_spa/Create'
        );
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        if(Year::where('code',$request->code)->get()->count()>0){
            return redirect()->back()->withErrors(['message'=>'Duplicate Year Code.']);
        }
        Validator::make($request->all(), [
            'code' => ['required'],
            'title' => ['required'],
            'period'=> ['required'],
            'kklass'=> ['required'],
            'kgrade'=> ['required'],
            'pklass'=> ['required'],
            'pgrade'=> ['required'],
            'sklass'=> ['required'],
            'sgrade'=> ['required'],
        ])->validate();

        $year=new Year;
        $year->code = $request->code;
        $year->title = $request->title;
        $year->start = date('Y-m-d', strtotime($request->period[0]));
        $year->end = date('Y-m-d', strtotime($request->period[1]));
        $year->description= $request->description ?? "";
        $year->active=1;
        $year->current_term=$request->current_term;
        $year->save();
        $yearId=$year->id;
        $kklass=$request->kklass;
        $kgrade=$request->kgrade;
        $pklass=$request->pklass;
        $pgrade=$request->pgrade;
        $sklass=$request->sklass;
        $sgrade=$request->sgrade;

        //start grade year from 1
        //Grade year 1-3, kindergarten
        //Grade year 4-9, kindergarten
        //Grade year 10-13, kindergarten
        $gradeYear=1; 
        $letters=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','W','X','Y','Z'];
        for($i=1;$i<=$kgrade;$i++){ //$i is going to transfer to letter
            $grade=new Grade;
            $grade->year_id=$yearId;
            $grade->grade_year=$gradeYear++;
            $grade->initial='K';
            $grade->level=$i;
            $grade->tag=$grade->initial.($i);
            $grade->transcript_template_id=Config::item('transcript_template');
            $grade->behaviour_scheme=json_encode(Config::item('behaviour_scheme'));
            $grade->active=1;
            $grade->save();
            $gradeId=$grade->id;
            for($j=1;$j<=$kklass;$j++){
                $klass=new Klass;
                $klass->grade_id=$gradeId;
                $klass->letter=$letters[$j-1];
                $klass->tag=$grade->tag.$letters[$j-1];
                $klass->study_id=Study::where('active',true)->where('grade_level',$grade->level)->latest()->first()->id??1;
                $klass->save();
            }
        }

        for($i=1;$i<=$pgrade;$i++){
            $grade=new Grade;
            $grade->year_id=$yearId;
            $grade->grade_year=$gradeYear++;
            $grade->initial='P';
            $grade->level=$i;
            $grade->tag=$grade->initial.($i);
            $grade->active=1;
            $grade->transcript_template_id=Config::item('transcript_template');
            $grade->behaviour_scheme=json_encode(Config::item('behaviour_scheme'));
            $grade->save();
            $gradeId=$grade->id;
            for($j=1;$j<=$pklass;$j++){
                $klass=new Klass;
                $klass->grade_id=$gradeId;
                $klass->letter=$letters[$j-1];
                $klass->tag=$grade->tag.$letters[$j-1];
                $klass->study_id=Study::where('active',true)->where('grade_level',$grade->level)->latest()->first()->id??1;
                $klass->save();
            }
        }
        for($i=1;$i<=$sgrade;$i++){
            $grade=new Grade;   
            $grade->year_id=$yearId;
            $grade->grade_year=$gradeYear++;
            $grade->initial='S';
            $grade->level=$i;
            $grade->tag=$grade->initial.($i);
            $grade->active=1;
            $grade->transcript_template_id=Config::item('transcript_template');
            $grade->behaviour_scheme=json_encode(Config::item('behaviour_scheme'));
            $grade->save();
            $gradeId=$grade->id;
            for($j=1;$j<=$sklass;$j++){
                $klass=new Klass;
                $klass->grade_id=$gradeId;
                $klass->letter=$letters[$j-1];
                $klass->tag=$grade->tag.$letters[$j-1];
                $klass->study_id=Study::where('active',true)->where('grade_level',$grade->level)->latest()->first()->id??1;
                $klass->save();
            }
        }
  
        return redirect()->back()
                    ->with('message', 'Article Created Successfully.');
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
        Validator::make($request->all(),[
            'title' => ['required'],
            'period'=> ['required'],
            'current_term'=> ['required'],
        ])->validate();
        if($request->has('id')){
            $year=Year::find($request->id);
            // $year->herit = $request->herit') ?? 0;
            $year->code = $request->code;
            $year->title = $request->title;
            $year->start = date('Y-m-d', strtotime($request->period[0]));
            $year->end = date('Y-m-d', strtotime($request->period[1]));
            $year->description= $request->description ?? "";
            $year->current_term=$request->current_term;
            $year->active=1;
            $year->save();
    
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
        $payment=Year::find($id);
        if($payment){
            $payment->delete();
            return redirect()->back()
                ->with('message', 'Year Delete Successfully');

        }
    }
    public function year($yearId){
        $data=Klass::where('year_id',$yearId)->get();
        return Inertia::render('Admin/Year_klasses',[
            'klasses'=>$data,
        ]);
    }

    public function grades(Year $year){
        // $grades=Grade::whereBelongsTo($year)->orderBy('grade_year')->get();
        // return Inertia::render('Admin/YearGrades',[
        //     'years'=>Year::where('active',true)->get(),
        //     'year'=>$year,
        //     'grades'=>$grades,
        //     'gradeLevels'=>Config::item('grade_levels'),
        // ]);
    }


}
