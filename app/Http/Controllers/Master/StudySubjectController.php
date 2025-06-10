<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Staff;
use App\Models\Study;
use App\Models\Subject;
use App\Models\StudySubject;
use App\Models\SubjectTemplate;
use App\Models\Config;
use Illuminate\Support\Facades\Validator;
//[update, store ] use on studies.vue function 
class StudySubjectController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request) //not use
    {
     
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
        $data= $request->validate([
            'id'=>[''],
            'newSubjects'=>[''],
            'yearId'=>['']
        ]);
        $study=Study::where('id', $data['id'])->first();
        $study->subjects()->syncWithoutDetaching($data['newSubjects']);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
       
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id) //not use
    {   
     
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request,StudySubject $studySubject)
    {   
        $column=$request->column;
        $updateStudySubject=$request->studySubject;
        $studySubject->$column= $updateStudySubject[$column];
        $studySubject->save();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request, StudySubject $studySubject)
    {     
        $studySubject->delete();  
      
    }

    public function sortOrderSubject(Request $request, $id)
    {       
       $data=[];
        $pivots=array_column( $request->subjects,'pivot');
        foreach($pivots as $idx=>$pivot){
             $data[$pivot['subject_id']]= [ 'sort_num'=>$idx+1];
        }
        $study=Study::where('id',$id)->first();
        $study->subjects()->sync( $data);
    }

}
