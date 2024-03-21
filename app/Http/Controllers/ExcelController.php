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
        //$config = ['mode'=>'+aCJK','autoScriptToLang'=>true,'autoLangToFont'=>true];
        $file=storage_path('template//CK_B4_StudentRegistrationForm.xlsx');
        //$file=storage_path('template//ExcelSheetDemo.xlsx');
        $reader = \PhpOffice\PhpSpreadsheet\IOFactory::createReader("Xlsx");
        $spreadsheet = $reader->load($file);

        $sheet1=$spreadsheet->getSheet(1);
        $sheet1->getCell("B1")->setValue('2024');
        $sheet1->getCell("B2")->setValue('初一');
        $sheet1->getCell("B3")->setValue('A');
        $sheet1->getCell("B4")->setValue('13');
        $sheet1->getCell("B5")->setValue('陳輝民');
        $sheet1->getCell("B6")->setValue('Jose Chan');
        $sheet1->getCell("B7")->setValue('M');
        $sheet1->getCell("B8")->setValue('1970');
        $sheet1->getCell("C8")->setValue('07');
        $sheet1->getCell("D8")->setValue('18');
        $sheet1->getCell("B9")->setValue('中國');

        $sheet1->getCell("B22")->setValue('陳大文');
        $sheet1->getCell("C22")->setValue('父親');
        $sheet1->getCell("D22")->setValue('54');
        $sheet1->getCell("E22")->setValue('programmer');
        $sheet1->getCell("F22")->setValue('my address ....');
        $sheet1->getCell("G22")->setValue('63860836');

        $sheet1->getCell("B23")->setValue('');
        $sheet1->getCell("C23")->setValue('');
        $sheet1->getCell("D23")->setValue('');
        $sheet1->getCell("E23")->setValue('');
        $sheet1->getCell("F23")->setValue('');
        $sheet1->getCell("G23")->setValue('');

        $sheet1->getCell("B28")->setValue('YES');
        $sheet1->getCell("B32")->setValue('2024-03-20');

        //$spreadsheet->setActiveSheetIndex(2);
        
        $writer = \PhpOffice\PhpSpreadsheet\IOFactory::createWriter($spreadsheet, 'Mpdf');
        $writer->save(storage_path('template//abc123.xlsx'));
        $writer->save(storage_path('template//abc123.pdf'));

    }
}
