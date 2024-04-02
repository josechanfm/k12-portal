<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Student;

class RegistrationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return Inertia::render('Admin/Registration',[
            'years'=>Year::all(),
            'registration'=>(object)[]
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //dd($request->all());

        $std=Student::where('id_type',$request->student['id_type'])->where('id_num',$request->student['id_num'])->first();
        if($std){
            return redirect()->back()->withErrors([
                'code'=>'duplicated',
                'message'=>'Student ID duplicated!'
            ]);
        }
        $student=Student::create($request->student);
        $student->detail()->create($request->detail);
        $student->address()->create($request->address);
        $student->health()->create($request->health);
        foreach($request->parents as $parent){
            $student->parents()->create($parent);
        }
        $student->relatives()->create($request->guardian);
        $student->address()->create($request->guardian);;

        foreach($request->relatives as $relative){
            $student->relatives()->create($relative);
        }
        $student->detail;
        $student->address;
        $student->health;
        $student->relatives;
        dd($student);
        dd($request->all());
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
        //
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
