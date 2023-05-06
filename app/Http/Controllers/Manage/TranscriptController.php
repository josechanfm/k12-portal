<?php

namespace App\Http\Controllers\Manage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\KlassStudent;
use App\Models\Transcript;
use App\Models\TranscriptTemplate;
use App\Models\Klass;
use App\Models\Course;

class TranscriptController extends Controller
{
    public function index(){
        $transcriptTemplate=TranscriptTemplate::all();
        $transcript=Transcript::where('klass_student_id',1)->get();
        // return response($transcriptTemplate);
        return Inertia::render('Manage/Transcript',[
            'transcriptTemplate'=>$transcriptTemplate,
            'transcript'=>$transcript
        ]);
    }

    public function KlassStudent($id){
        $klassStudent=KlassStudent::find($id);
        return response($klassStudent);

    }
    public function klass(Klass $klass){
        $courses=Course::whereBelongsTo($klass)->with('scores')->orderBy('id')->get();
        dd($courses);
        //dd($klass->scores);
    }
}
