<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TopicTemplateSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data=[
            [
                'sequence'=>1,'section_code'=>'health','section'=>'健康與體育','abbr'=>'身體協調','title'=>'鍛鍊身體協調能力：能直線行走',],[
                'sequence'=>2,'section_code'=>'health','section'=>'健康與體育','abbr'=>'手眼協調','title'=>'鍛鍊手眼協調能力：拿起瓶蓋放進紙巾盒內',],[
                'sequence'=>3,'section_code'=>'language','section'=>'語言：聽','abbr'=>'專心耹聽','title'=>'能專心耹聽故事《第一天上學》',],[
                'sequence'=>4,'section_code'=>'language','section'=>'語言：說','abbr'=>'運用句式','title'=>'能運用句式：「我是_____。」來介紹自已',],[
                'sequence'=>5,'section_code'=>'language','section'=>'語言：讀','abbr'=>'中文字詞','title'=>'能認讀中文字詞（上學、老師、唱歌、洗...）',],[
                'sequence'=>6,'section_code'=>'language','section'=>'語言：讀','abbr'=>'英文字母','title'=>'能認讀英文字母（Ab、Bb、Cc）',],[
                'sequence'=>7,'section_code'=>'social','section'=>'個人、社會與人文','abbr'=>'辦認環境設施','title'=>'能辦認學校內的環境設施',],[
                'sequence'=>8,'section_code'=>'science','section'=>'數學與科學','abbr'=>'物品配對','title'=>'能以一一對應的方式把物品進行配對',],[
                'sequence'=>9,'section_code'=>'art','section'=>'藝術','abbr'=>'辦聽音樂節奏','title'=>'能辦聽音樂節奏的行進與停止',],[
                'sequence'=>10,'section_code'=>'art','section'=>'藝術','abbr'=>'享受填色','title'=>'能享受填色的樂趣',
            ]
        ];
        $thems=DB::table('theme_templates')->get();
        foreach($thems as $theme){
            foreach($data as $i=>$d){
                $d['theme_template_id']=$theme->id;
                DB::table('topic_templates')->insert($d);
            }  
    
    
        }
    }
}
