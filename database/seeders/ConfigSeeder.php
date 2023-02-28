<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ConfigSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('configs')->insert([
            'key' => 'grade_categories',
            'value' => '[{"value":"P1","label":"P1"},{"value":"P2","label":"P2"},{"value":"P3","label":"P3"}]',
        ]);
        DB::table('configs')->insert([
            'key' => 'student_state',
            'value' => '{"ACT": "Active","RES": "Resigned"}',
        ]);
        DB::table('configs')->insert([
            'key' => 'score_template',
            'value' =>'{"TERM":[{"value":"term1","label":"上學期"},{"value":"term2","label":"下學期"}],"COMMENT":[{"value":"comment","label":"描述"}]}'
        ]);
        DB::table('configs')->insert([
            'key' => 'year_creation',
            'value' => '{ "kgrade":3, "kklass":3, "kgradeDefault":0, "kklassDefault":0, "pgrade":6, "pklass":5, "pgradeDefault":6, "pklassDefault":4, "sgrade":6, "sklass":5, "sgradeDefault":6, "sklassDefault":4 }',
        ]);
        DB::table('configs')->insert([
            'key'=>'klass_letters',
            'value'=>'[{"value":"A","label":"A"},{"value":"B","label":"B"},{"value":"C","label":"C"},{"value":"D","label":"D"},{"value":"E","label":"E"},{"value":"F","label":"F"}]'
        ]);
        DB::table('configs')->insert([
            'key'=>'score_columns',
            'value' =>'[{"REG":"平時分"},{"TST":"測驗分"},{"CLS":"課堂表現"},{"EXM":"考試分"}]'
        ]);
        DB::table('configs')->insert([
            'key'=>'subject_types',
            'value' =>'[{"value":"SUB","label":"學科"},{"value":"ATT","label":"生活習慣和態度"},{"value":"RPAL","label":"獎懲遲缺"},{"value":"LES","label":"餘暇活動"},{"value":"OVA","label":"總體評分"}]'
        ]);
        DB::table('configs')->insert([
            'key'=>'study_streams',
            'value' =>'[{"value":"ALL","label":"全科"},{"value":"ART","label":"文科"},{"value":"SCI","label":"理科"},{"value":"AAS","label":"文理科"}]'
        ]);
        DB::table('configs')->insert([
            'key'=>'year_terms',
            'value' =>'[{"value":1,"label":"上學期"},{"value":2,"label":"下學期"}]'
        ]);
        DB::table('configs')->insert([
            'key'=>'habit_columns',
            'value' =>'[{"name":"health_1","label":"衣服鞋襪整齊清潔","short":"整潔"},
                {"name":"health_2","label":"常剪指甲","short":"指甲"},
                {"name":"health_3","label":"懂得使用手帕或紙巾","short":"紙巾"},
                {"name":"health_4","label":"不把手指雜物放進口裡","short":"手指"},
                {"name":"health_5","label":"能把癈物投入癈紙箱內","short":"癈物"},
                {"name":"behaviour_1","label":"守秩序不喧嚷","short":"喧讓"},
                {"name":"behaviour_2","label":"留心聽講","short":"聽講"},
                {"name":"behaviour_3","label":"坐立行走姿勢正確","short":"姿勢"},
                {"name":"behaviour_4","label":"離開座位把物件桌椅整理好","short":"桌椅"},
                {"name":"behaviour_5","label":"愛護公物用後放回原處","short":"公物"},
                {"name":"behaviour_6","label":"遵守校規","short":"校規"},
                {"name":"social_1","label":"守時","short":"守時"},
                {"name":"social_2","label":"尊敬師長,友愛和睦","short":"尊敬"},
                {"name":"social_3","label":"樂於助人","short":"助人"},
                {"name":"social_4","label":"會和別人分享及輪候","short":"分享"},
                {"name":"social_5","label":"誠實坦白肯認錯","short":"誠實"}]'
        ]);
        DB::table('configs')->insert([
            'key'=>'behaviour_genres',
            'value'=>'[{"value":"LATE","label":"遲到"},
                {"value":"ABSENT","label":"缺席"},
                {"value":"DEMERIT","label":"缺點"},
                {"value":"FAULT_BIG","label":"大過"},
                {"value":"FAULT_SMALL","label":"小過"},
                {"value":"CREDIT_BIG","label":"大功"},
                {"value":"CREDIT_SMALL","label":"小功"},
                {"value":"MERIT","label":"優點"}]'
        ]);
        DB::table('configs')->insert([
            'key'=>'grade_levels',
            'value' =>'[{
                "value": 1,
                "label": "K1",
                "initial": "K",
                "level": 1
            }, {
                "value": 2,
                "label": "K2",
                "initial": "K",
                "level": 2
            }, {
                "value": 3,
                "label": "K3",
                "initial": "K",
                "level": 3
            }, {
                "value": 4,
                "label": "P1",
                "initial": "P",
                "level": 1
            }, {
                "value": 5,
                "label": "P2",
                "initial": "P",
                "level": 2
            }, {
                "value": 6,
                "label": "P3",
                "initial": "P",
                "level": 3
            }, {
                "value": 7,
                "label": "P4",
                "initial": "P",
                "level": 4
            }, {
                "value": 8,
                "label": "P5",
                "initial": "P",
                "level": 5
            }, {
                "value": 9,
                "label": "P6",
                "initial": "P",
                "level": 6
            }, {
                "value": 10,
                "label": "SC1",
                "initial": "SC",
                "level": 1
            }, {
                "value": 11,
                "label": "SC2",
                "initial": "SC",
                "level": 2
            }, {
                "value": 12,
                "label": "SC3",
                "initial": "SC",
                "level": 3
            }, {
                "value": 13,
                "label": "SG1",
                "initial": "SG",
                "level": 1
            }, {
                "value": 14,
                "label": "SG2",
                "initial": "SG",
                "level": 2
            }, {
                "value": 15,
                "label": "SG3",
                "initial": "SG",
                "level": 3
            }]'
        ]);

    }
}
