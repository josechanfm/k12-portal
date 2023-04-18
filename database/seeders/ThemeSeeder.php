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
        //grade year: -1
        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-1,
            'title_zh'=>'健康與體育',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'身體協調',
            'title_zh'=>'鍛鍊身體協調能力：能直線行走',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'手眼協調',
            'title_zh'=>'鍛鍊手眼協調能力：拿起瓶蓋放進紙巾盒內',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-1,
            'title_zh'=>'語言：聽',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'專心耹聽',
            'title_zh'=>'能專心耹聽故事《第一天上學》',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-1,
            'title_zh'=>'語言：說',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'運用句式',
            'title_zh'=>'能運用句式：「我是_____。」來介紹自已',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-1,
            'title_zh'=>'語言：讀',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'中文字詞',
            'title_zh'=>'能認讀中文字詞（上學、老師、唱歌、洗...）',
        ]);

        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'英文字母',
            'title_zh'=>'能認讀英文字母（Ab、Bb、Cc）',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-1,
            'title_zh'=>'個人、社會與人文',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦認環境設施',
            'title_zh'=>'能辦認學校內的環境設施',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-1,
            'title_zh'=>'數學與科學',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'物品配對',
            'title_zh'=>'能以一一對應的方式把物品進行配對',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-1,
            'title_zh'=>'藝術',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦聽音樂節奏',
            'title_zh'=>'能辦聽音樂節奏的行進與停止',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'享受填色',
            'title_zh'=>'能享受填色的樂趣',
        ]);

        //grade year: -2
        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-2,
            'title_zh'=>'健康與體育',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'身體協調',
            'title_zh'=>'鍛鍊身體協調能力：能直線行走',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'手眼協調',
            'title_zh'=>'鍛鍊手眼協調能力：拿起瓶蓋放進紙巾盒內',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-2,
            'title_zh'=>'語言：聽',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'專心耹聽',
            'title_zh'=>'能專手耹聽故事《第一天上學》',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-2,
            'title_zh'=>'語言：說',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'運用句式',
            'title_zh'=>'能運用句式：「我是_____。」來介紹自已',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-2,
            'title_zh'=>'語言：讀',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'中文字詞',
            'title_zh'=>'能認讀中文字詞（上學、老師、唱歌、洗...）',
        ]);

        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'英文字母',
            'title_zh'=>'能認讀英文字母（Ab、Bb、Cc）',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-2,
            'title_zh'=>'個人、社會與人文',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦認環境設施',
            'title_zh'=>'能辦認學校內的環境設施',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-2,
            'title_zh'=>'數學與科學',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'物品配對',
            'title_zh'=>'能以一一對應的方式把物品進行配對',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-2,
            'title_zh'=>'藝術',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦聽音樂節奏',
            'title_zh'=>'能辦聽音樂節奏的行進與停止',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'享受填色',
            'title_zh'=>'能享受填色的樂趣',
        ]);
        
        //grade Year: -2
        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-3,
            'title_zh'=>'健康與體育',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'身體協調',
            'title_zh'=>'鍛鍊身體協調能力：能直線行走',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'手眼協調',
            'title_zh'=>'鍛鍊手眼協調能力：拿起瓶蓋放進紙巾盒內',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-3,
            'title_zh'=>'語言：聽',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'專心耹聽',
            'title_zh'=>'能專手耹聽故事《第一天上學》',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-3,
            'title_zh'=>'語言：說',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'運用句式',
            'title_zh'=>'能運用句式：「我是_____。」來介紹自已',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-3,
            'title_zh'=>'語言：讀',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'中文字詞',
            'title_zh'=>'能認讀中文字詞（上學、老師、唱歌、洗...）',
        ]);

        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'英文字母',
            'title_zh'=>'能認讀英文字母（Ab、Bb、Cc）',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-3,
            'title_zh'=>'個人、社會與人文',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦認環境設施',
            'title_zh'=>'能辦認學校內的環境設施',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-3,
            'title_zh'=>'數學與科學',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'物品配對',
            'title_zh'=>'能以一一對應的方式把物品進行配對',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>-3,
            'title_zh'=>'藝術',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦聽音樂節奏',
            'title_zh'=>'能辦聽音樂節奏的行進與停止',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'享受填色',
            'title_zh'=>'能享受填色的樂趣',
        ]);

        //grade year: 1
        $id=DB::table('themes')->insertGetId([
            'grade_year'=>1,
            'title_zh'=>'健康與體育',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'身體協調',
            'title_zh'=>'鍛鍊身體協調能力：能直線行走',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'手眼協調',
            'title_zh'=>'鍛鍊手眼協調能力：拿起瓶蓋放進紙巾盒內',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>1,
            'title_zh'=>'語言：聽',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'專心耹聽',
            'title_zh'=>'能專手耹聽故事《第一天上學》',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>1,
            'title_zh'=>'語言：說',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'運用句式',
            'title_zh'=>'能運用句式：「我是_____。」來介紹自已',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>1,
            'title_zh'=>'語言：讀',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'中文字詞',
            'title_zh'=>'能認讀中文字詞（上學、老師、唱歌、洗...）',
        ]);

        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'英文字母',
            'title_zh'=>'能認讀英文字母（Ab、Bb、Cc）',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>1,
            'title_zh'=>'個人、社會與人文',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦認環境設施',
            'title_zh'=>'能辦認學校內的環境設施',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>1,
            'title_zh'=>'數學與科學',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'物品配對',
            'title_zh'=>'能以一一對應的方式把物品進行配對',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>1,
            'title_zh'=>'藝術',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦聽音樂節奏',
            'title_zh'=>'能辦聽音樂節奏的行進與停止',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'享受填色',
            'title_zh'=>'能享受填色的樂趣',
        ]);
        
        //grade year: 2
        $id=DB::table('themes')->insertGetId([
            'grade_year'=>2,
            'title_zh'=>'健康與體育',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'身體協調',
            'title_zh'=>'鍛鍊身體協調能力：能直線行走',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'手眼協調',
            'title_zh'=>'鍛鍊手眼協調能力：拿起瓶蓋放進紙巾盒內',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>2,
            'title_zh'=>'語言：聽',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'專心耹聽',
            'title_zh'=>'能專手耹聽故事《第一天上學》',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>2,
            'title_zh'=>'語言：說',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'運用句式',
            'title_zh'=>'能運用句式：「我是_____。」來介紹自已',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>2,
            'title_zh'=>'語言：讀',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'中文字詞',
            'title_zh'=>'能認讀中文字詞（上學、老師、唱歌、洗...）',
        ]);

        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'英文字母',
            'title_zh'=>'能認讀英文字母（Ab、Bb、Cc）',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>2,
            'title_zh'=>'個人、社會與人文',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦認環境設施',
            'title_zh'=>'能辦認學校內的環境設施',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>2,
            'title_zh'=>'數學與科學',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'物品配對',
            'title_zh'=>'能以一一對應的方式把物品進行配對',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>2,
            'title_zh'=>'藝術',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦聽音樂節奏',
            'title_zh'=>'能辦聽音樂節奏的行進與停止',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'享受填色',
            'title_zh'=>'能享受填色的樂趣',
        ]);

        //grade year: 3
        $id=DB::table('themes')->insertGetId([
            'grade_year'=>3,
            'title_zh'=>'健康與體育',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'身體協調',
            'title_zh'=>'鍛鍊身體協調能力：能直線行走',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'手眼協調',
            'title_zh'=>'鍛鍊手眼協調能力：拿起瓶蓋放進紙巾盒內',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>3,
            'title_zh'=>'語言：聽',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'專心耹聽',
            'title_zh'=>'能專手耹聽故事《第一天上學》',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>3,
            'title_zh'=>'語言：說',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'運用句式',
            'title_zh'=>'能運用句式：「我是_____。」來介紹自已',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>3,
            'title_zh'=>'語言：讀',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'中文字詞',
            'title_zh'=>'能認讀中文字詞（上學、老師、唱歌、洗...）',
        ]);

        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'英文字母',
            'title_zh'=>'能認讀英文字母（Ab、Bb、Cc）',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>3,
            'title_zh'=>'個人、社會與人文',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦認環境設施',
            'title_zh'=>'能辦認學校內的環境設施',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>3,
            'title_zh'=>'數學與科學',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'物品配對',
            'title_zh'=>'能以一一對應的方式把物品進行配對',
        ]);

        $id=DB::table('themes')->insertGetId([
            'grade_year'=>3,
            'title_zh'=>'藝術',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'辦聽音樂節奏',
            'title_zh'=>'能辦聽音樂節奏的行進與停止',
        ]);
        DB::table('topics')->insert([
            'theme_id'=>$id,
            'abbr_zh'=>'享受填色',
            'title_zh'=>'能享受填色的樂趣',
        ]);        
    }
}
