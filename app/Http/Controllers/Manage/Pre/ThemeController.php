<?php

namespace App\Http\Controllers\Manage\Pre;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Theme;
use App\Models\Klass;
use App\Models\KlassStudent;
use Inertia\Inertia;
use PDF;

class ThemeController extends Controller
{
    public function KlassSummary(Klass $klass, $format='pdf'){
        $abilities=Theme::abilitiesGroupByTopicCategory($klass);
        $pdf=PDF::loadView('pdf.abilitiesSummaries',[
            'klass'=>$klass,
            'abilities'=>$abilities,
        ]);
        $pdf->render();
        
        return $pdf->stream('test.pdf',array('Attachment'=>false));
        
    }
    public function klassStudent(KlassStudent $klassStudent,Theme $theme, $format='pdf'){
        $theme->topics;
        $abilities=$theme->studentAbilities($klassStudent);
        $pdf=PDF::loadView('pdf.themeKlassStudents',[
            'klass'=>$klassStudent->klass,
            'theme'=>$theme,
            'abilities'=>$abilities,
        ]);
        $pdf->render();
        return $pdf->stream('test.pdf',array('Attachment'=>false));
    }

    public function klass(Klass $klass,Theme $theme, $format='pdf'){        
        // dd($klass);
        $theme->topics;
        $abilities=$theme->klassAbilities($klass);
        $pdf=PDF::loadView('pdf.themeKlassStudents',[
            'klass'=>$klass,
            'theme'=>$theme,
            'abilities'=>$abilities,
        ]);
        $pdf->render();
        
        return $pdf->stream('test.pdf',array('Attachment'=>false));

    }

}
