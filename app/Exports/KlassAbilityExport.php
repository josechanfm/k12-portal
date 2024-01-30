<?php

namespace App\Exports;

use App\Models\Ability;
use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use App\Models\Topic;
use Illuminate\Support\Collection;


class KlassAbilityExport implements FromCollection, withHeadings
{
    use Exportable;
    protected $klass;
    protected $termId;
    protected $themeId;

    function __construct($klass,$termId,$themeId)
    {
        $this->klass = $klass;
        $this->termId=$termId;
        $this->themeId=$themeId;
    }
    public function headings(): array
    {
        $topics=array_column(Topic::where('theme_id',$this->themeId)->get()->toArray(),'abbr');
        array_unshift($topics,'學生姓名');
        array_unshift($topics,'學號');
        array_unshift($topics,'學期');
        array_unshift($topics,'控制欄');
        return $topics;
    }
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        return Ability::all();
    }
}
