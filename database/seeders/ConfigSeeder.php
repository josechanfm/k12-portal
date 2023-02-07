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
            'key' => 'streams',
            'value' =>'[{"value":"ALL","label":"全科"},{"value":"ART","label":"文科"},{"value":"SCI","label":"理科"},{"value":"AAS","label":"文理科"}]'
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
            'key'=>'study_plans',
            'value' =>'[{"value":"ALL","label":"全科"},{"value":"ART","label":"文科"},{"value":"SCI","label":"理科"},{"value":"AAS","label":"文理科"}]'
        ]);
        
    }
}
