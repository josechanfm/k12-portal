<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ScoreColumn;

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
        $ScoreColumn=new ScoreColumn;
        $ScoreColumn->term_id=$request->term_id;
        $ScoreColumn->course_id=$request->course_id;
        $ScoreColumn->sequence=$request->sequence;
        $ScoreColumn->name=$request->name;
        $ScoreColumn->type=$request->type;
        $ScoreColumn->scheme=$request->scheme;
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
        $ScoreColumn->sequence=$request->sequence;
        $ScoreColumn->name=$request->name;
        $ScoreColumn->type=$request->type;
        $ScoreColumn->scheme=$request->scheme;
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
}
