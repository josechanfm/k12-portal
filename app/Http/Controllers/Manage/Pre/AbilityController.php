<?php

namespace App\Http\Controllers\Manage\Pre;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Ability;
use App\Models\Theme;
use \Mpdf\Mpdf as mPDF; 
use Illuminate\Support\Facades\Storage;
use PDF;

class AbilityController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function klass(Klass $klass){
        //dd($klass->abilitiesScores());
        //dd($klass->grade->themes);
        //dd($klass->themes);
        //dd($klass->grade->topics);
        //$klass->grade->themes;
        //$klass->grade->topics;
        //dd($klass);
        
        $terms=Config::item('year_terms');
        // dd($terms);
        //dd($klass->students_abilities);
        return Inertia::render('Manage/Pre/Ability',[
            'yearTerms'=>Config::item('year_terms'),
            'klass'=>$klass,
            //'themes'=>$klass->grade->themes,
            //'topics'=>$klass->grade->topics,
            // 'abilities'=>$klass->abilities,
            'students_abilities'=>$klass->students_abilities,
            'abilities'=>$klass->abilitiesScores()
        ]);

    }

    public function index()
    {
        //
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
    public function update(Klass $klass, Request $request)
    {
        
        //return $request->all();
        Ability::upsert(
            $request->all(),
            ['klass_student_id','topic_id','term_id'],
            ['credit']
        );
        return count($request->all());


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
    public function pdf(Klass $klass){
        $theme=Theme::find(1);
        dd($theme->reportKlass());
        // return view('pdf.reportAbilities',['klass'=>$klass]);
        //dd($klass->abilitiesScores());
        $pdf=PDF::loadView('pdf.reportAbilities',[
            'klass'=>$klass,
            'report'=>$theme->report(),
        ]);
        $pdf->render();
        
        return $pdf->stream('test.pdf',array('Attachment'=>false));

    }
    public function mpdf(Klass $klass){
        // Setup a filename 
        $documentFileName = "fun.pdf";

        // Create the mPDF document
        $document = new mPDF( [
            'mode' => 'utf-8',
            'format' => 'A4',
            'margin_header' => '3',
            'margin_top' => '20',
            'margin_bottom' => '20',
            'margin_footer' => '2',
        ]);     

        // Set some header informations for output
        $header = [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'inline; filenaabilitiesScoresme="'.$documentFileName.'"'
        ];
        $content='<h1 style="color:blue">TheCodingJack</h1>';
        $content.='<p>Write something, just for fun!</p>';
        // Write some simple Content
        $document->WriteHTML($content);
        //return response($content);
        // $document->WriteHTML('<h1 style="color:blue">TheCodingJack</h1>');
        // $document->WriteHTML('<p>Write something, just for fun!</p>');
        // Save PDF on your public storage 
        Storage::disk('public')->put($documentFileName, $document->Output($documentFileName, "S"));
        
        // Get file back from storage with the give header informations
        return Storage::disk('public')->download($documentFileName, 'Request', $header); 
    }
}
