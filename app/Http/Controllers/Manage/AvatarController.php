<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Inertia\Inertia;
use App\Models\KlassStudent;
use App\Models\Grade;

class AvatarController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Inertia::render('Manage/Avatars',[

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
    public function upload(Request $request){
        $uploadFile=$request->file('avatar');
        $klassStudent=KlassStudent::find($request->klassStudentId);

        $fileDisk='profile';
        $filePath=$klassStudent->klass->grade->year->code.'/'.$klassStudent->klass->tag;
        $fileName=$klassStudent->student_number.'_'.(String) Str::uuid().'.'.$uploadFile->getClientOriginalExtension();
        $fileType='avatar';
        $klassStudent->archives()->updateOrCreate(
            [
                'file_type'=>$fileType
            ],[
                'file_type'=>$fileType,
                'original_name'=>'original_name',
                'file_name'=>$fileName,
                'file_disk'=>$fileDisk,
                'file_path'=>'/'.$filePath.'/'.$fileName
            ]
        );


        Storage::disk($fileDisk)->put(
            $filePath,
            $uploadFile
        );
        return redirect()->back();

    }
}
