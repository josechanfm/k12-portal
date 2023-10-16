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
    public function summary(Klass $klass, $format='pdf'){
        $abilities=Theme::summary($klass);
        
    }
    public function klassStudent(KlassStudent $klassStudent,Theme $theme, $format='pdf'){
        $theme->topics;
        $abilities=$theme->studentAbilities($klassStudent);
        $pdf=PDF::loadView('pdf.reportAbilities',[
            'klass'=>$klassStudent->klass,
            'abilities'=>$abilities,
        ]);
        $pdf->render();
        
        return $pdf->stream('test.pdf',array('Attachment'=>false));

    }

    public function klass(Klass $klass,Theme $theme, $format='pdf'){
        
        $theme->topics;
        $abilities=$theme->klassAbilities($klass);
        

        $pdf=PDF::loadView('pdf.reportAbilities',[
            'klass'=>$klass,
            'abilities'=>$abilities,
        ]);
        $pdf->render();
        
        return $pdf->stream('test.pdf',array('Attachment'=>false));

    }

}
