<?php

namespace App\Http\Controllers\Manage\Pre;

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
        return Inertia::render('Manage/Pre/Ability',[
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
        $term = array_reduce($yearTerms, static function ($carry, $item) use($termId) {
            return $carry ?? ($item->value == $termId ? $item : $carry);
        }, null);
        $fileName=$klass->tag.'_'.$term->label.'_';
        $fileName.=Theme::find($request->theme_id)->title.'.xlsx';
        //return Excel::download(new KlassAbilityExport($klass,$request->term_id,$request->theme_id), $fileName);

        $topics=Topic::where('theme_id',$request->theme_id)->get()->pluck('id');
        dd($topics);
        // $ability=Ability::find(1);
        // dd($ability->klass);
        $abilities=$klass->abilities;
        dd($abilities->whereIn($topics)->get());


    }

    public function import(Klass $klass, Request $request){
        $importFile=$request->file('importFile');
        if(empty($importFile)){
            return redirect()->back();
        }
        $habits=Excel::toArray(new KlassAbilityImport($klass), $importFile);
        foreach($habits[0] as $key=>$habit){
            //skip first row of header
            if($key==0) continue;
            //check Control code, remove row if not match
            $controlCode=explode('-',$habit[0]);
            $hash=hash('crc32',$klass->id.hexdec($controlCode[1]));
            if($hash != $controlCode[0]){
                array_splice($habits[0],$key,1);
            };
            //tream from right 1 charactor
            for($i=4;$i<=count($habit)-1;$i++){
                if(!empty($habits[0][$key])){
                    $habits[0][$key][$i]=substr($habits[0][$key][$i],-1);
                }
            }
        }
        return Inertia::render('Manage/Pre/KlassHabitsImport',[
            'klass'=>$klass,
            'importData'=>$habits[0],
        ]);
    }

    public function importConfirmed(Klass $klass, Request $request){
        $importData=$request->importData;
        array_splice($importData,0,1);
        $habitColumns=Config::item('habit_columns');
        foreach($importData as $import){
            $controlCode=explode('-',$import[0]);
            $habit=Habit::find(hexdec($controlCode[1]));
            foreach($habitColumns as $id=>$column){
                $habit->{$column->name}=$import[$id+4];
            };
            $habit->save();
        };
        return redirect()->route('manage.pre.klass.habits',$klass);
    }

}
