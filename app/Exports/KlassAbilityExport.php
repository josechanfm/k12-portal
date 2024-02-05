<?php

namespace App\Exports;

use App\Models\Ability;
use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use App\Models\Topic;
use App\Models\Config;
use Illuminate\Support\Collection;


class KlassAbilityExport implements FromCollection, withHeadings
{
    use Exportable;
    protected $klass;
    protected $term;
    protected $theme;

    function __construct($klass,$term,$theme)
    {
        $this->klass = $klass;
        $this->term=$term;
        $this->theme=$theme;
    }
    public function headings(): array
    {
        $topics=array_column(Topic::where('theme_id',$this->theme->id)->get()->toArray(),'abbr');
        array_unshift($topics,'學生姓名');
        array_unshift($topics,'學號');
        array_unshift($topics,'學期');
        array_unshift($topics,'主題');
        array_unshift($topics,'控制欄');
        return $topics;
    }
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        $yearTerms=Config::item('year_terms');
        $termId=$this->term->value;
        $term = array_reduce($yearTerms, static function ($carry, $item) use($termId) {
            return $carry ?? ($item->value == $termId ? $item : $carry);
        }, null);

        $students=$this->klass->students;
        $topics=Topic::where('theme_id',$this->theme->id)->orderBy('sequence')->get();
        $abilities=$this->klass->abilities->where('term_id',$this->term->value)->whereIn('topic_id',$topics->pluck('id'));
        $scores=[];
        foreach($abilities as $ability){
            $scores[$ability->klass_student_id][$ability->topic_id]=$ability;
        }
        $data= new Collection();
        foreach($students as $student){
            $tmp=[];
            $tmp['control_code']=hash('crc32',$this->theme->id.$student->pivot->klass_student_id).
                    '-'.substr('00000000'.dechex($this->theme->id),-6).
                    '-'.substr('00000000'.dechex($student->pivot->klass_student_id),-8);
            $tmp['theme_id']=$this->theme->id;
            $tmp['term_id']=$termId;
            $tmp['student_number']=$student->pivot->student_number;
            $tmp['student_name']=$student->name_zh;
            foreach($topics as $topic){
                $tmp[$topic->id]=$scores[$student->pivot->klass_student_id][$topic->id]->credit;
            }
            $data->push($tmp);
        }
        return $data;
    }
}
