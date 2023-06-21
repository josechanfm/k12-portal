<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ScoreColumn;
use Illuminate\Database\Eloquent\Factories\Sequence;
use Illuminate\Support\Str;

class ScoreColumnController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return response('you are in score column controller index');
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
        //dd($request);
        $ScoreColumn=new ScoreColumn;
        $ScoreColumn->term_id=$request->term_id;
        $ScoreColumn->course_id=$request->course_id;
        $ScoreColumn->field_label=$request->field_label;
        $ScoreColumn->field_name=Str::uuid();
        $ScoreColumn->sequence=$request->sequence;
        $ScoreColumn->type=$request->type;
        $ScoreColumn->scheme=$request->scheme;
        $ScoreColumn->description=$request->description;
        $ScoreColumn->for_transcript=false;
        $ScoreColumn->save();
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
        $ScoreColumn=ScoreColumn::find($id);
        $ScoreColumn->term_id=$request->term_id;
        $ScoreColumn->course_id=$request->course_id;
        $ScoreColumn->field_label=$request->field_label;
        $ScoreColumn->field_name=Str::uuid()->toString();
        $ScoreColumn->sequence=$request->sequence;
        $ScoreColumn->type=$request->type;
        $ScoreColumn->scheme=$request->scheme;
        $ScoreColumn->description=$request->description;
        $ScoreColumn->for_transcript=false;
        $ScoreColumn->save();
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

    public function reorder(Request $request){
        $records=$request->all();
        $x='A';
        foreach($records as $record){
            ScoreColumn::where('id',$record['id'])
                ->update([
                    'sequence'=>$record['sequence'],
                    'column_letter'=>$x++
                ]);
        }
        return redirect()->back();
    }
    public function update_is_total(Request $request){
        $records=$request->all();
        foreach($records as $record){
            ScoreColumn::where('id',$record['id'])
                ->update(['is_total'=>$record['is_total']]);
        }
        return redirect()->back();
    }
}
