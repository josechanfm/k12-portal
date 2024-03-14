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
        // dd($gradeLetters);
        // dd($request->all());
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

        $data=$request->all();
        $data['start']=date('Y-m-d', strtotime($request->period[0]));
        $data['end']=date('Y-m-d', strtotime($request->period[1]));
        $year=Year::create($data);
        $year->autoGenerate($data);  
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
    public function destroy(Year $year)
    {
        if($year->grades->count()>0){
            return redirect()->back()->withErrors(['message'=>'Could not delete, foreign key used in grade table.']);
        }else{
            $year->delete();
            return redirect()->back();    
        }
    }
    public function year($yearId){
        $data=Klass::where('year_id',$yearId)->get();
        return Inertia::render('Admin/Year_klasses',[
            'klasses'=>$data,
        ]);
    }



}
