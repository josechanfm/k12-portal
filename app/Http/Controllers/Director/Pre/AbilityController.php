<?php

namespace App\Http\Controllers\Director\Pre;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Ability;
use App\Models\Theme;
use App\Models\Topic;
use \Mpdf\Mpdf as mPDF; 
use Illuminate\Support\Facades\Storage;
use PDF;
use App\Exports\KlassAbilityExport;
use App\Imports\KlassAbilityImport;
use Maatwebsite\Excel\Facades\Excel;

class AbilityController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function klass(Klass $klass){
        //dd($klass->abilitiesScores()['scores'][1][1]);
        return Inertia::render('Director/Pre/Ability',[
            'yearTerms'=>Config::item('year_terms'),
            'klass'=>$klass,
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
        // Save PDF on your public storage 
        Storage::disk('public')->put($documentFileName, $document->Output($documentFileName, "S"));
        
        // Get file back from storage with the give header informations
        return Storage::disk('public')->download($documentFileName, 'Request', $header); 
    }
    public function export(Klass $klass, Request $request){
        $yearTerms=Config::item('year_terms');
        $termId=$request->term_id;
        $themeId=$request->theme_id;
        $term = array_reduce($yearTerms, static function ($carry, $item) use($termId) {
            return $carry ?? ($item->value == $termId ? $item : $carry);
        }, null);
        $theme=Theme::find($themeId);
        
        $fileName=$klass->tag.'_'.$term->label.'_';
        $fileName.=Theme::find($request->theme_id)->title.'.xlsx';
        return Excel::download(new KlassAbilityExport($klass,$term,$theme), $fileName);
    }

    public function import(Klass $klass, Request $request){
        $theme=Theme::find($request->themeId);
        $importFile=$request->file('importFile');
        if(empty($importFile)){
            return redirect()->back();
        }
        $abilities=Excel::toArray(new KlassAbilityImport($klass), $importFile);
        foreach($abilities[0] as $key=>$ability){
            //skip first row of header
            if($key==0) continue;
            //check Control code, remove row if not match
            $controlCode=explode('-',$ability[0]);
            if(count($controlCode)!==3){
                return redirect()->back();
            }
            $hash=hash('crc32',hexdec($controlCode[1]).hexdec($controlCode[2]));
            if($hash != $controlCode[0]){
                unset($abilities[0][$key]);
                //array_splice($abilities[0],$key,1);
                //continue;
            };
            if($ability[1]!=$theme->id){
                unset($abilities[0][$key]);
            }
        }

        return Inertia::render('Director/Pre/KlassAbilitiesImport',[
            'klass'=>$klass,
            'theme'=>$theme,
            'importData'=>$abilities[0],
        ]);
    }

    public function importConfirmed(Klass $klass, Request $request){
        $themeId=$request->themeId;
        $importData=$request->importData;
        array_splice($importData,0,1);
        $topics=Topic::where('theme_id',$themeId)->orderBy('sequence')->get();
        foreach($importData as $import){
            $controlCode=explode('-',$import[0]);
            $termId=$import[1];
            $themeId=$import[1];
            //first 5 columns are controlCode, theme_id, term_id,student_name and student_name
            //the rest of $import are same as topics sequence
            array_splice($import,0,5);
            foreach($topics as $id=>$topic){
                Ability::where('klass_student_id',hexdec($controlCode[2]))
                ->where('term_id',$termId)
                ->where('topic_id',$topic->id)
                ->update(['credit'=>$import[$id]]);
            };
        };
        return redirect()->route('director.pre.klass.abilities',$klass);
    }

}
