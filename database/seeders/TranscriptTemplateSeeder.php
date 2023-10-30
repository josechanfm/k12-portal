<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Config;

class TranscriptTemplateSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $yearTerms=Config::item('year_terms');
        $personal=[
            'name_zh'=>'姓名中文',
            'name_fn'=>'姓名外文',
            'academic_year'=>'年度',
            'grade_class'=>'級別',
            'student_number'=>'學生證編號',
            'id_number'=>'身份證編號',
            'issue_date'=>'簽發日期',
        ];
        $subject=[
            'REL'=>'宗教',
            'PHY'=>'體能',
            'CLT'=>'語文',
            'ELT'=>'英文',
            'EWR'=>'英寫',
            'OCS'=>'常識',
            'NUM'=>'識數',
            'COM'=>'電腦',
            'PLA'=>'唱遊',
            'ART'=>'美勞',
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


        //template 1
        //primary to secondary grades
        //'title_zh'=>'學年評定',
        $cnt=1;
        foreach($personal as $key=>$value){
            DB::table('transcript_templates')->insert([
                'template_id'=>1,
                'term_id'=>9,
                'category'=>'PERSONAL',
                'reference_code'=>$key,
                'field_name'=>'',
                'sequence'=>$cnt++,
                'title_zh'=>$value,
            ]);
        };
        $cnt=1;
        foreach($subject as $key=>$value){
            foreach($yearTerms as $term){
                DB::table('transcript_templates')->insert([
                    'template_id'=>1,
                    'term_id'=>$term->value,
                    'category'=>'SUBJECT',
                    'reference_code'=>$key,
                    'field_name'=>'REGULAR',
                    'sequence'=>$cnt++,
                    'title_zh'=>$value,
                    'version'=>1,
                ]);
                DB::table('transcript_templates')->insert([
                    'template_id'=>1,
                    'term_id'=>$term->value,
                    'category'=>'SUBJECT',
                    'reference_code'=>$key,
                    'field_name'=>'TERM',
                    'sequence'=>$cnt++,
                    'title_zh'=>$value,
                    'version'=>1,
                ]);
                DB::table('transcript_templates')->insert([
                    'template_id'=>1,
                    'term_id'=>$term->value,
                    'category'=>'SUBJECT',
                    'reference_code'=>$key,
                    'field_name'=>'YEAR',
                    'sequence'=>$cnt++,
                    'title_zh'=>$value,
                    'version'=>1,
                ]);
            }
            DB::table('transcript_templates')->insert([
                'template_id'=>1,
                'term_id'=>9,
                'category'=>'SUBJECT',
                'reference_code'=>$key,
                'field_name'=>'FINAL',
                'sequence'=>$cnt++,
                'title_zh'=>$value,
                'version'=>1,
            ]);
        };
        $cnt=1;
        foreach($summary as $key=>$value){
            DB::table('transcript_templates')->insert([
                'template_id'=>1,
                'term_id'=>9,
                'category'=>'SUMMARY',
                'reference_code'=>$key,
                'field_name'=>'',
                'sequence'=>$cnt++,
                'title_zh'=>$value,
                'version'=>1,
            ]);
        };
        $cnt=1;
        foreach($general as $key=>$value){
            foreach($yearTerms as $term){
                DB::table('transcript_templates')->insert([
                    'template_id'=>1,
                    'category'=>'GENERAL',
                    'term_id'=>$term->value,
                    'reference_code'=>$key,
                    'field_name'=>'',
                    'sequence'=>$cnt++,
                    'title_zh'=>$value,
                    'version'=>1,
                ]);
            }
            DB::table('transcript_templates')->insert([
                'template_id'=>1,
                'category'=>'GENERAL',
                'term_id'=>9,
                'reference_code'=>$key,
                'field_name'=>'',
                'sequence'=>$cnt++,
                'title_zh'=>$value,
                'version'=>1,
            ]);
        };
        $cnt=1;
        DB::table('transcript_templates')->insert([
            'template_id'=>1,
            'term_id'=>9,
            'category'=>'APPRAISAL',
            'reference_code'=>'appraisal',
            'sequence'=>$cnt++,
            'field_name'=>'',
            'title_zh'=>'學年評定',
            'version'=>1,
        ]);
        $cnt=1;
        DB::table('transcript_templates')->insert([
            'template_id'=>1,
            'term_id'=>9,
            'category'=>'PASSING',
            'reference_code'=>'passing',
            'title_zh'=>'合格分數',
            'sequence'=>$cnt++,
            'value'=>60,
            'version'=>1,
        ]);





        //template 2
        //kindergarden
        //'title_zh'=>'學年評定',
        $cnt=1;
        foreach($personal as $key=>$value){
            DB::table('transcript_templates')->insert([
                'template_id'=>2,
                'term_id'=>9,
                'category'=>'PERSONAL',
                'reference_code'=>$key,
                'sequence'=>$cnt++,
                'title_zh'=>$value,
            ]);
        };
        $cnt=1;
        foreach($attitude as $key=>$value){
            DB::table('transcript_templates')->insert([
                'template_id'=>2,
                'term_id'=>9,
                'category'=>'ATTITUDE',
                'reference_code'=>$key,
                'sequence'=>$cnt++,
                'title_zh'=>$value,
                'version'=>1,
            ]);
        };
        $cnt=1;
        foreach($summary as $key=>$value){
            DB::table('transcript_templates')->insert([
                'template_id'=>2,
                'term_id'=>9,
                'category'=>'SUMMARY',
                'reference_code'=>$key,
                'sequence'=>$cnt++,
                'title_zh'=>$value,
                'version'=>1,
            ]);
        };
        $cnt=1;
        foreach($general as $key=>$value){
            DB::table('transcript_templates')->insert([
                'template_id'=>2,
                'term_id'=>9,
                'category'=>'GENERAL',
                'reference_code'=>$key,
                'sequence'=>$cnt++,
                'title_zh'=>$value,
                'version'=>1,
            ]);
        };
        $cnt=1;
        DB::table('transcript_templates')->insert([
            'template_id'=>2,
            'term_id'=>9,
            'category'=>'APPRAISAL',
            'reference_code'=>'appraisal',
            'sequence'=>$cnt++,
            'title_zh'=>'學年評定',
            'version'=>1,
        ]);






        // 'code'=>'1', 'title_zh'=>'1', 'title_en'=>'PERSONAL', 'type'=> 'name_zh', 'stream'=>'姓名中文'
        // 'code'=>'2', 'title_zh'=>'1', 'title_en'=>'PERSONAL', 'type'=> 'name_fn', 'stream'=>'姓名外文'
        // 'code'=>'3', 'title_zh'=>'1', 'title_en'=>'PERSONAL', 'type'=> 'academic_year', 'stream'=>'年度'
        // 'code'=>'4', 'title_zh'=>'1', 'title_en'=>'PERSONAL', 'type'=> 'grade_class', 'stream'=>'級別'
        // 'code'=>'5', 'title_zh'=>'1', 'title_en'=>'PERSONAL', 'type'=> 'student_number', 'stream'=>'學生證編號'
        // 'code'=>'6', 'title_zh'=>'1', 'title_en'=>'PERSONAL', 'type'=> 'id_number', 'stream'=>'身份證編號'
        // 'code'=>'7', 'title_zh'=>'1', 'title_en'=>'PERSONAL', 'type'=> 'issue_date', 'stream'=>'簽發日期'
        // 'code'=>'8', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'religion', 'stream'=>'宗教'
        // 'code'=>'9', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'chinese_literature', 'stream'=>'語文'
        // 'code'=>'10', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'common_sense', 'stream'=>'常識'
        // 'code'=>'11', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'story', 'stream'=>'故事'
        // 'code'=>'12', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'chinese_writing', 'stream'=>'中寫'
        // 'code'=>'13', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'numeracy', 'stream'=>'識數'
        // 'code'=>'14', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'english_reading', 'stream'=>'讀本'
        // 'code'=>'15', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'english_writing', 'stream'=>'英寫'
        // 'code'=>'16', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'computer', 'stream'=>'電腦'
        // 'code'=>'17', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'mandarin', 'stream'=>'普通話'
        // 'code'=>'18', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'art_craft', 'stream'=>'美勞'
        // 'code'=>'19', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'playgroup', 'stream'=>'唱遊'
        // 'code'=>'20', 'title_zh'=>'1', 'title_en'=>'SUBJECT', 'type'=> 'physical_fitness', 'stream'=>'體能'
        // 'code'=>'21', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'health_1', 'stream'=>'衣服鞋襪整齊清潔'
        // 'code'=>'22', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'health_2', 'stream'=>'常剪指甲'
        // 'code'=>'23', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'health_3', 'stream'=>'懂得使用手帕或紙巾'
        // 'code'=>'24', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'health_4', 'stream'=>'不把手指雜物放進口裡'
        // 'code'=>'25', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'health_5', 'stream'=>'能把癈物投入廢紙箱內'
        // 'code'=>'26', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'behaviour_1', 'stream'=>'守秩序不喧嚷'
        // 'code'=>'27', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'behaviour_2', 'stream'=>'留心聽講'
        // 'code'=>'28', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'behaviour_3', 'stream'=>'坐立行走姿勢正確'
        // 'code'=>'29', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'behaviour_4', 'stream'=>'離開坐位把物件桌椅整理好'
        // 'code'=>'30', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'behaviour_5', 'stream'=>'愛護公物用後放回原處'
        // 'code'=>'31', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'behaviour_6', 'stream'=>'遵守校規'
        // 'code'=>'32', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'social_1', 'stream'=>'守時'
        // 'code'=>'33', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'social_2', 'stream'=>'尊敬師長,友愛和睦'
        // 'code'=>'34', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'social_3', 'stream'=>'樂於助人'
        // 'code'=>'35', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'social_4', 'stream'=>'會和別人分享及輪侯'
        // 'code'=>'36', 'title_zh'=>'1', 'title_en'=>'ATTITUDE', 'type'=> 'social_5', 'stream'=>'誠實坦白肯認錯'
        // 'code'=>'37', 'title_zh'=>'1', 'title_en'=>'SUMMARY', 'type'=> 'total_score', 'stream'=>'總分'
        // 'code'=>'38', 'title_zh'=>'1', 'title_en'=>'SUMMARY', 'type'=> 'average_score', 'stream'=>'平均分'
        // 'code'=>'39', 'title_zh'=>'1', 'title_en'=>'SUMMARY', 'type'=> 'class_size', 'stream'=>'全班人數'
        // 'code'=>'40', 'title_zh'=>'1', 'title_en'=>'SUMMARY', 'type'=> 'ranking', 'stream'=>'考列名次'
        // 'code'=>'41', 'title_zh'=>'1', 'title_en'=>'SUMMARY', 'type'=> 'late', 'stream'=>'遲到次數'
        // 'code'=>'42', 'title_zh'=>'1', 'title_en'=>'SUMMARY', 'type'=> 'absent', 'stream'=>'缺席節數'
        // 'code'=>'43', 'title_zh'=>'1', 'title_en'=>'GENERAL', 'type'=> 'comment', 'stream'=>'評語'
        // 'code'=>'44', 'title_zh'=>'1', 'title_en'=>'GENERAL', 'type'=> 'reward_punishment', 'stream'=>'奬懲記錄'
        // 'code'=>'45', 'title_zh'=>'1', 'title_en'=>'GENERAL', 'type'=> 'leisure_name', 'stream'=>'餘暇活動名稱'
        // 'code'=>'46', 'title_zh'=>'1', 'title_en'=>'GENERAL', 'type'=> 'leisure_performance', 'stream'=>'餘暇活動表現'
        // 'code'=>'47', 'title_zh'=>'1', 'title_en'=>'GENERAL', 'type'=> 'remark', 'stream'=>'備註'
        // 'code'=>'48', 'title_zh'=>'1', 'title_en'=>'GENERAL', 'type'=> 'appraisal', 'stream'=>'學年評定'
        

    }
}
