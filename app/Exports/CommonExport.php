<?php

namespace App\Exports;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;
use Maatwebsite\Excel\Events\AfterSheet;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithEvents;
class CommonExport implements  FromCollection,WithEvents
{   private $data=[];
    public function set_export_data($array2D){
        $this->data=$array2D;
    }  
    public function collection()
    {   
        return collect([["新生入學匯入表"],...$this->data]);
    }

 
    public function registerEvents(): array
{
    return [
        AfterSheet::class => function(AfterSheet $event) {
            $highestColumn = $event->sheet->getDelegate()->getHighestColumn();
            $event->sheet->getDelegate()->mergeCells('A1:' . $highestColumn . '1');
            $event->sheet->getDelegate()->getStyle('A1:' . $highestColumn . '120')
            ->getBorders()->getAllBorders()->setBorderStyle(\PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN);
        },
    ];
}
}