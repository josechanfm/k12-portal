<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;

class TranscriptController extends Controller
{
    public function lockTranscripts(Request $request){
        if(!isset($request->scope) || !isset($request->id)){
            echo 'nono';
        }
        // $klass=Klass::find($request->id);
        // $klass->transcript_locked=!$klass->transcript_locked;
        // $klass->save();
        // return redirect()->back();

        //dd($klass);
        //dd($request->all());
        switch($request->scope){
            case 'klass':
                $klass=Klass::find($request->id);
                if(!$klass->grade->transcript_locked){
                    $klass->transcript_locked=!$klass->transcript_locked;
                    $klass->save();
                }else{
                    return redirect()->back()->withErrors(['message'=>'transcript is locked']);
                }
                break;
            case 'grade':
                //dd($request->all());
                Klass::where('grade_id',$request->id)->update(['transcript_locked'=>true]);
                break;
            case 'year':
                $year=Year::currentYear();
                if($year->id != $request->id) break;
                Grade::whereBelongsTo($year)->update(['transcript_locked'=>true]);
                Klass::whereIn('grade_id',$year->grades->pluck('id'))->update(['transcript_locked'=>true]);
                break;
            }
        return redirect()->back();
    }
}
