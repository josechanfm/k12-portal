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
        $reader = \PhpOffice\PhpSpreadsheet\IOFactory::createReader("Xlsx");
        $spreadsheet = $reader->load(storage_path('template\ExcelSheetDemo.xlsx'));
        $sheet1=$spreadsheet->getSheet(1);
        $sheet2=$spreadsheet->getSheet(2);
        $sheet1->getCell("A2")->setValue('a2 on sheet 1');
        $sheet2->getCell("A2")->setValue('a2 on sheet 2');
        echo  $sheet1->getCell("A1")->getValue();
        echo  $sheet2->getCell("A1")->getValue();
        //$spreadsheet->setActiveSheetIndex(2);
        $writer = \PhpOffice\PhpSpreadsheet\IOFactory::createWriter($spreadsheet, 'Mpdf');

        $writer->save(storage_path('template\abc123.pdf'));

    }
}
