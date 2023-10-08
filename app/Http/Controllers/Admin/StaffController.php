<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Staff;

class StaffController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $staffs=Staff::with('user')->paginate(request('per_page'));
        return Inertia::render('Admin/Staffs',[
            'staffs'=>$staffs,
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
        $request->validate([
            'name_zh' => 'required',
            'gender' => 'required',
            'mobile' => 'required'
        ]);
        $staff=new Staff();
        $staff->name_zh=$request->name_zh;
        $staff->name_fn=$request->name_fn;
        $staff->gender=$request->gender;
        $staff->mobile=$request->mobile;
        $staff->sector=$request->sector;
        //$staff->is_teacher=$request->is_teacher??false;
        $staff->save();
        return response($request->all());
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
    public function update(Request $request, Staff $staff)
    {
        $request->validate([
            'name_zh' => 'required',
            'gender' => 'required',
            'mobile' => 'required'
        ]);
        $staff->name_zh=$request->name_zh;
        $staff->name_fn=$request->name_fn;
        $staff->gender=$request->gender;
        $staff->mobile=$request->mobile;
        $staff->sector=$request->sector;
        //$staff->is_teacher=$request->is_teacher;
        $staff->save();
        return response($request->all());
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
