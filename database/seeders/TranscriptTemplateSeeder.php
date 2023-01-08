<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TranscriptTemplateSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $personal=[
            'name_ch'=>'姓名中文',
            'name_fn'=>'姓名外文',
            'academic_year'=>'年度',
            'grade_class'=>'級別',
            'student_number'=>'學生證編號',
            'id_number'=>'身份證編號',
            'issue_date'=>'簽發日期',
        ];
        $subject=[
            'religion'=>'宗教',
            'chinese_literature'=>'語文',
            'common_sense'=>'常識',
            'story'=>'故事',
            'chinese_writing'=>'中寫',
            'numeracy'=>'識數',
            'english_reading'=>'讀本',
            'english_writing'=>'英寫',
            'computer'=>'電腦',
            'mandarin'=>'普通話',
            'art_craft'=>'美勞',
            'playgroup'=>'唱遊',
            'physical_fitness'=>'體能'
        ];
        $attitude=[
            'health_1'=>'衣服鞋襪整齊清潔',
            'health_2'=>'常剪指甲',
            'health_3'=>'懂得使用手帕或紙巾',
            'health_4'=>'不把手指雜物放進口裡',
            'health_5'=>'能把癈物投入廢紙箱內',
            'behaviour_1'=>'守秩序不喧嚷',
            'behaviour_2'=>'留心聽講',
            'behaviour_3'=>'坐立行走姿勢正確',
            'behaviour_4'=>'離開坐位把物件桌椅整理好',
            'behaviour_5'=>'愛護公物用後放回原處',
            'behaviour_6'=>'遵守校規',
            'social_1'=>'守時',
            'social_2'=>'尊敬師長,友愛和睦',
            'social_3'=>'樂於助人',
            'social_4'=>'會和別人分享及輪侯',
            'social_5'=>'誠實坦白肯認錯'
        ];
        $summary=[
            'total_score'=>'總分',
            'average_score'=>'平均分',
            'class_size'=>'全班人數',
            'ranking'=>'考列名次',
            'late'=>'遲到次數',
            'absent'=>'缺席節數',
        ];
        $general=[
            'comment'=>'評語',
            'reward_punishment'=>'奬懲記錄',
            'leisure_name'=>'餘暇活動名稱',
            'leisure_performance'=>'餘暇活動表現',
            'remark'=>'備註',
        ];
        //'title_zh'=>'學年評定',
        foreach($personal as $key=>$value){
            DB::table('transcript_templates')->insert([
                'category'=>'PERSONAL',
                'field_name'=>$key,
                'title_zh'=>$value,
            ]);
        };
        foreach($subject as $key=>$value){
            DB::table('transcript_templates')->insert([
                'category'=>'SUBJECT',
                'field_name'=>$key,
                'title_zh'=>$value,
            ]);
        };
        foreach($attitude as $key=>$value){
            DB::table('transcript_templates')->insert([
                'category'=>'ATTITUDE',
                'field_name'=>$key,
                'title_zh'=>$value,
            ]);
        };
        foreach($summary as $key=>$value){
            DB::table('transcript_templates')->insert([
                'category'=>'SUMMARY',
                'field_name'=>$key,
                'title_zh'=>$value,
            ]);
        };
        foreach($general as $key=>$value){
            DB::table('transcript_templates')->insert([
                'category'=>'GENERAL',
                'field_name'=>$key,
                'title_zh'=>$value,
            ]);
        };
        DB::table('transcript_templates')->insert([
            'category'=>'GENERAL',
            'field_name'=>'appraisal',
            'title_zh'=>'學年評定',
        ]);


        // foreach($personal as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'PSN',
        //         'category'=>'PERSONAL',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($subject as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T1E',
        //         'category'=>'SUBJECT',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($subject as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T1P',
        //         'category'=>'SUBJECT',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($subject as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T1A',
        //         'category'=>'SUBJECT',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($subject as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T2E',
        //         'category'=>'SUBJECT',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($subject as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T2P',
        //         'category'=>'SUBJECT',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($subject as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T2A',
        //         'category'=>'SUBJECT',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($subject as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'FIN',
        //         'category'=>'SUBJECT',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };

        // foreach($attitude as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T1',
        //         'category'=>'ATTITUDE',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($attitude as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T2',
        //         'category'=>'ATTITUDE',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($summary as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T1',
        //         'category'=>'SUMMARY',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($summary as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T2',
        //         'category'=>'SUMMARY',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($summary as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'FIN',
        //         'category'=>'SUMMARY',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($general as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T1',
        //         'category'=>'GENERAL',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // foreach($general as $key=>$value){
        //     DB::table('transcript_templates')->insert([
        //         'column'=>'T2',
        //         'category'=>'GENERAL',
        //         'field_name'=>$key,
        //         'title_zh'=>$value,
        //     ]);
        // };
        // DB::table('transcript_templates')->insert([
        //     'column'=>'FIN',
        //     'category'=>'GENERAL',
        //     'field_name'=>'remark',
        //     'title_zh'=>'備註',
        // ]);
        // DB::table('transcript_templates')->insert([
        //     'column'=>'FIN',
        //     'category'=>'GENERAL',
        //     'field_name'=>'appraisal',
        //     'title_zh'=>'學年評定',
        // ]);
    }
}
