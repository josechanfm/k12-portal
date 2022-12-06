<?php

namespace App\Http\Controllers\Essential;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;
use App\Models\Subject;
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
        $data = Year::withCount('grades')->paginate(5);
        $param=json_decode(Config::where('key','year_creation')->first()->value);
        return Inertia::render('Essential/Years',[
            'years'=>$data,
            'param'=>$param
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
        Validator::make($request->all(), [
            'abbr' => ['required'],
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
        $year->abbr = $request->input('abbr');
        $year->title = $request->input('title');
        $year->start = date('Y-m-d', strtotime($request->input('period')[0]));
        $year->end = date('Y-m-d', strtotime($request->input('period')[1]));
        $year->description= $request->input('description') ?? "";
        $year->active=1;
        $year->save();
        $yearId=$year->id;
        $kklass=$request->input('kklass');
        $kgrade=$request->input('kgrade');
        $pklass=$request->input('pklass');
        $pgrade=$request->input('pgrade');
        $sklass=$request->input('sklass');
        $sgrade=$request->input('sgrade');
        $level=1;
        $letters=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','W','X','Y','Z'];
        for($i=1;$i<=$kgrade;$i++){
            $grade=new Grade;
            $grade->year_id=$yearId;
            $grade->level=$level++;
            $grade->initial='P';
            $grade->tag=$grade->initial.($i);
            $grade->active=1;
            $grade->save();
            $gradeId=$grade->id;
            for($j=1;$j<=$kklass;$j++){
                $klass=new Klass;
                $klass->grade_id=$gradeId;
                $klass->letter=$letters[$j-1];
                $klass->tag==$letters[$j];
                $klass->save();
            }
        }

        for($i=1;$i<=$pgrade;$i++){
            $grade=new Grade;
            $grade->year_id=$yearId;
            $grade->level=$level++;
            $grade->initial='P';
            $grade->tag=$grade->initial.($i);
            $grade->active=1;
            $grade->save();
            $gradeId=$grade->id;
            for($j=1;$j<=$pklass;$j++){
                $klass=new Klass;
                $klass->grade_id=$gradeId;
                $klass->letter=$letters[$j-1];
                $klass->tag==$letters[$j];
                $klass->save();
            }
        }
        for($i=1;$i<=$sgrade;$i++){
            $grade=new Grade;   
            $grade->year_id=$yearId;
            $grade->level=$level++;
            $grade->initial='S';
            $grade->tag=$grade->initial.($i);
            $grade->active=1;
            $grade->save();
            $gradeId=$grade->id;
            for($j=1;$j<=$sklass;$j++){
                $klass=new Klass;
                $klass->grade_id=$gradeId;
                $klass->letter=$letters[$j-1];
                $klass->tag==$letters[$j];
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
            'abbr' => ['required'],
            'title' => ['required'],
            'period'=> ['required'],
        ])->validate();
        if($request->has('id')){
            $year=Year::find($request->input('id'));
            $year->herit = $request->input('herit') ?? 0;
            $year->abbr = $request->input('abbr');
            $year->title = $request->input('title');
            $year->start = date('Y-m-d', strtotime($request->input('period')[0]));
            $year->end = date('Y-m-d', strtotime($request->input('period')[1]));
            $year->description= $request->input('description') ?? "";
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
                ->with('message', 'Blog Delete Successfully');

        }
    }
    public function year($yearId){
        $data=Klass::where('year_id',$yearId)->get();
        return Inertia::render('Admin/Year_klasses',[
            'klasses'=>$data,
        ]);
    }
    public function subjects($yearId){
        $year=Year::find($yearId);
        $subjects=Subject::where('active',1)->get();
        $klasses=Klass::select('id as value','acronym as label')->where('year_id',$yearId)->get();
        $config=json_decode(Config::where('key','grades')->first()->value,true);
        return Inertia::render('Admin/Year_subjects',[
            'year'=>$year,
            'subjects'=>$subjects,
            'klasses'=>$klasses,
            'config'=>$config
        ]);
    }
}
