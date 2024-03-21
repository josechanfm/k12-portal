<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Worksheet\PageSetup;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use Illuminate\Support\Facades\Storage;


class ExcelController extends Controller
{
    //

    
    public function readFile(){
        //Vendor/phpoffice/phpspreadsheet/src/PhpSpreadsheet/Writer/Pdf/Mpdf line 43
        //$config = ['tempDir' => $this->tempDir . '/mpdf', 'mode'=>'+aCJK','autoScriptToLang'=>true,'autoLangToFont'=>true];

        $reader = \PhpOffice\PhpSpreadsheet\IOFactory::createReader("Xlsx");
        $spreadsheet = $reader->load(storage_path('template//ExcelSheetDemo.xlsx'));
        $spreadsheet->getDefaultStyle()->getFont()->setName('DejaVuSans'); // 字体
        // $spreadsheet->getDefaultStyle()->getFont()->setSize(8); // 字体大小

        // $styleArray=array(
        //     'font'=>array(
        //         'bold'  => true,
        //         'color' => array('rgb' => 'FF0000'),
        //         'size'  => 15,
        //         'name'=>'DejaVuSans'
        //     )
        // );
        // $spreadsheet->getDefaultStyle()->applyFromArray($styleArray);

        $sheet0=$spreadsheet->getSheet(0);
        $sheet1=$spreadsheet->getSheet(1);
        $sheet2=$spreadsheet->getSheet(2);
        $sheet0->getCell('B3')->setValue('欧阳克');
        $sheet1->getCell("D4")->setValue('a2 on sheet 1');
        $sheet2->getCell("A2")->setValue('a2 on sheet 2');
        echo  $sheet0->getCell("D4")->getValue();
        echo  $sheet1->getCell("A1")->getValue();
        echo  $sheet2->getCell("A1")->getValue();
        echo '<br>';


        //$spreadsheet->setActiveSheetIndex(2);
        $locale='zh_Tw';
        $validLocale = \PhpOffice\PhpSpreadsheet\Settings::setLocale($locale);
        if (!$validLocale) {
            echo 'Unable to set locale to ' . $locale . " - reverting to en_us" . PHP_EOL;
        }
        echo '<br>';
        echo \PhpOffice\PhpSpreadsheet\Settings::getLocale();
        echo '<br>';
        $config = ['mode'=>'+aCJK','autoScriptToLang'=>true,'autoLangToFont'=>true];
        $writer = \PhpOffice\PhpSpreadsheet\IOFactory::createWriter($spreadsheet, 'Mpdf');

        $writer->save(storage_path('template//abc123.xlsx'));
        $writer->save(storage_path('template//abc123.pdf'));

    }
}
