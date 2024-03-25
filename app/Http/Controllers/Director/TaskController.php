<?php

namespace App\Http\Controllers\Director;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Task;
use App\Models\Additive;
use App\Models\Student;

class TaskController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        // $additive=Additive::find(2);
        // dd($additive->klassStudent);

        $tasks=Task::where('state',0)->whereBelongsTo(auth()->user())->with('workflow')->get();
        // echo json_encode(auth()->user());
            // dd($tasks);

        // $additive=Additive::find(1);
        // dd($additive->workflow);
        return Inertia::render('Director/Tasks',[
            'tasks' => $tasks
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
    public function update(Request $request, Task $task)
    {
        // return response($task);

        // $tmp=$request->all();
        // return response($tmp);
        // dd($task->workflow->processes);

        $task->status=strtoupper($request->response);
        if(isset($request->comments)){
            $task->comments=$request->comments;
        }
        $task->save();

        $modelId=$request->workflow['workflowable_id'];
        $model=$request->workflow['workflowable_type'];
        $response=$request->response;
        $model::find($modelId)->$response($request->all());
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
