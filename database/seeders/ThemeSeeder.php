<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ThemeSeeder extends Seeder
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
                'theme_id'=>$id,
                'sequence'=>1,
                'section'=>'健康與體育',
                'abbr'=>'身體協調',
                'title'=>'鍛鍊身體協調能力：能直線行走',
            ],[
                'theme_id'=>$id,
                'sequence'=>2,
                'section'=>'健康與體育',
                'abbr'=>'手眼協調',
                'title'=>'鍛鍊手眼協調能力：拿起瓶蓋放進紙巾盒內',
            ],[
                'theme_id'=>$id,
                'sequence'=>3,
                'section'=>'語言：聽',
                'abbr'=>'專心耹聽',
                'title'=>'能專心耹聽故事《第一天上學》',
            ],[
                'theme_id'=>$id,
                'sequence'=>4,
                'section'=>'語言：說',
                'abbr'=>'運用句式',
                'title'=>'能運用句式：「我是_____。」來介紹自已',
            ],[
                'theme_id'=>$id,
                'sequence'=>5,
                'section'=>'語言：讀',
                'abbr'=>'中文字詞',
                'title'=>'能認讀中文字詞（上學、老師、唱歌、洗...）',
            ],[
                'theme_id'=>$id,
                'sequence'=>6,
                'section'=>'語言：讀',
                'abbr'=>'英文字母',
                'title'=>'能認讀英文字母（Ab、Bb、Cc）',
            ],[
                'theme_id'=>$id,
                'sequence'=>7,
                'section'=>'個人、社會與人文',
                'abbr'=>'辦認環境設施',
                'title'=>'能辦認學校內的環境設施',
            ],[
                'theme_id'=>$id,
                'sequence'=>8,
                'section'=>'數學與科學',
                'abbr'=>'物品配對',
                'title'=>'能以一一對應的方式把物品進行配對',
            ],[
                'theme_id'=>$id,
                'sequence'=>9,
                'section'=>'藝術',
                'abbr'=>'辦聽音樂節奏',
                'title'=>'能辦聽音樂節奏的行進與停止',
            ],[
                'theme_id'=>$id,
                'sequence'=>10,
                'section'=>'藝術',
                'abbr'=>'享受填色',
                'title'=>'能享受填色的樂趣',
            ]
        ];

        //grade year: 1, term 1, theme 1
        $id=DB::table('themes')->insertGetId([
            'year_id'=>1,
            'grade_year'=>1,
            'term_id'=>1,
            'sequence'=>1,
            'title'=>'第一天上學',
        ]);
        foreach($data as $i=>$d){
            DB::table('topics')->insert([
                'theme_id'=>$id,
                'sequence'=>$i,
                'section'=>$d['section'],
                'abbr'=>$d['abbr'],
                'title'=>$d['title'],
            ]);
        }
        //grade year: 1, term 1, theme 2
        $id=DB::table('themes')->insertGetId([
            'year_id'=>1,
            'grade_year'=>1,
            'term_id'=>1,
            'sequence'=>2,
            'title'=>'第二天上學',
        ]);
        foreach($data as $i=>$d){
            DB::table('topics')->insert([
                'theme_id'=>$id,
                'sequence'=>$i,
                'section'=>$d['section'],
                'abbr'=>$d['abbr'],
                'title'=>$d['title'],
            ]);
        }

        //grade year: 1, term 2, theme 3
        $id=DB::table('themes')->insertGetId([
            'year_id'=>1,
            'grade_year'=>1,
            'term_id'=>2,
            'sequence'=>3,
            'title'=>'第三天上學',
        ]);
        foreach($data as $i=>$d){
            DB::table('topics')->insert([
                'theme_id'=>$id,
                'sequence'=>$i,
                'section'=>$d['section'],
                'abbr'=>$d['abbr'],
                'title'=>$d['title'],
            ]);
        }

    }
}
