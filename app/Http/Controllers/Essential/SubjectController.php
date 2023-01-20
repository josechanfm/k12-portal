<?php

namespace App\Http\Controllers\Essential;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Grade;
use App\Models\Subject;
use App\Models\SubjectTemplate;
use Illuminate\Support\Facades\Validator;

class SubjectController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $grade=Grade::find($request->gid);
        $subjects=Subject::whereBelongsTo($grade)->get();
        $subjectTemplates=SubjectTemplate::where('active',1)->orderBy('type')->orderBy('stream')->get();
        return Inertia::render('Essential/Subject',[
            'grade'=>$grade,
            'subjects'=>$subjects,
            'subjectTemplates'=>$subjectTemplates
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
        $selectedSubjects=$request->selectedSubjects;
        $subjectTemplates=SubjectTemplate::whereIn('code',$selectedSubjects)->get();
        $fields=[];
        $records=[];
        foreach($subjectTemplates as $st){
            $fields['grade_id']=$request->grade_id;
            $fields['code']=$st->code;
            $fields['title_zh']=$st->title_zh;
            $fields['title_en']=$st->title_en;
            $fields['type']=$st->type;
            $fields['stream']=$st->stream;
            $fields['elective']=$st->elective;
            $fields['active']=true;
            $fields['subject_template_id']=$st->id;
            $records[]=$fields;
        }
        Subject::upsert(
            $records,
            ['grade_id','code'],
            ['title_zh','title_en','type','stream','elective','active']
        );
        Subject::whereNotIn('code',$selectedSubjects)->where('grade_id',1)->delete();
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
        $s=['ENG','CHN','MAT'];
        $subjectTemplates=SubjectTemplate::whereIn('code',$s)->get();
        $fields=[];
        $records=[];
        foreach($subjectTemplates as $st){
            $fields['grade_id']=1;
            $fields['code']=$st->code;
            $fields['title_zh']=$st->title_zh;
            $fields['title_en']=$st->title_en;
            $fields['type']=$st->type;
            $fields['stream']=$st->stream;
            $fields['elective']=$st->elective;
            $fields['active']=true;
            $records[]=$fields;
        }
        echo json_encode($records);
        Subject::upsert(
            $records,
            ['grade_id','code'],
            ['title_zh','title_en','type','stream','elective','active']
        );
        Subject::whereNotIn('code',$s)->where('grade_id',1)->delete();

        echo json_encode($subjectTemplates);
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
        Validator::make($request->all(), [
            'grade_id' => ['required'],
            'code' => ['required'],
        ])->validate();
        if($request->has('id')){
            $subject=Subject::find($id);
            $subject->title_zh=$request->title_zh;
            $subject->title_en=$request->title_en;
            $subject->type=$request->type;
            $subject->stream=$request->stream;
            $subject->elective=$request->elective;
            $subject->description=$request->description;
            $subject->active=$request->active;
            $subject->save();
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
        Subject::destroy($id);
        return redirect()->back();
    }
}
