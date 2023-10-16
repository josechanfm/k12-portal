<?php

namespace App\Http\Controllers\Manage\Pre;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Theme;
use App\Models\Klass;
use App\Models\KlassStudent;
use PDF;

class ThemeController extends Controller
{
    public function klassStudent(KlassStudent $klassStudent,Theme $theme, $format='pdf'){
        $theme->topics;
        $abilities=$theme->studentAbilities($klassStudent);
        //$abilities=$klassStudent->abilities($theme->id);

        //dd($theme);
        //dd($abilities);
        // dd($klassStudent->student);
        // dd($theme);
        // echo $format;
        // echo ($theme);

        $pdf=PDF::loadView('pdf.reportAbilities',[
            'student'=>$klassStudent->student,
            'klass'=>$klassStudent->klass,
            'theme'=>$theme,
            'abilities'=>$abilities,
        ]);
        $pdf->render();
        
        return $pdf->stream('test.pdf',array('Attachment'=>false));

    }

    public function klass(Klass $klass,Theme $theme, $format='pdf'){
        
        $theme->topics;
        $abilities=$theme->klassAbilities($klass);
        

        //dd($theme);
        //dd($abilities);
        // dd($klassStudent->student);
        // dd($theme);
        // echo $format;
        // echo ($theme);

        $pdf=PDF::loadView('pdf.reportAbilities',[
            'student'=>$klassStudent->student,
            'klass'=>$klassStudent->klass,
            'theme'=>$theme,
            'abilities'=>$abilities,
        ]);
        $pdf->render();
        
        return $pdf->stream('test.pdf',array('Attachment'=>false));

    }

}
