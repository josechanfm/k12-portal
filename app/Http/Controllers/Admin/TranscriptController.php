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
        switch($request->scope){
            case 'klass':
                Klass::where('id',$request->id)->update(['transcript_migrated'=>9]);
                break;
            case 'grade':
                Klass::where('grade_id',$request->id)->update(['transcript_migrated'=>9]);
                break;
            case 'year':
                $year=Year::currentYear();
                if($year->id != $request->id) break;
                Klass::whereIn('grade_id',$year->grades->pluck('id'))->update(['transcript_migrated'=>9]);
                break;
            }
        return redirect()->back();
    }
}
