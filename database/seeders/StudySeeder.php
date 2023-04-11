<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class StudySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'P1',
            'title_zh'=>'小學一年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        };

        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'P2',
            'title_zh'=>'小學二年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        };

        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'P3',
            'title_zh'=>'小學三年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        };

        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'P4',
            'title_zh'=>'小學四年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        };

        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'P5',
            'title_zh'=>'小學五年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        };

        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'P6',
            'title_zh'=>'小學六年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        };

        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'SC1',
            'title_zh'=>'初中一年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        };

        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'SC2',
            'title_zh'=>'初中二年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        };

        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'SC3',
            'title_zh'=>'初中三年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        };

        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'SG1',
            'title_zh'=>'高中一年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        };

        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'SG2',
            'title_zh'=>'高中二年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        };

        $id=DB::table('studies')->insertGetId([
            'version'=>1,
            'grade'=>'SG3',
            'title_zh'=>'高中三年級',
            'stream'=>'ALL',
            'active'=>true
        ]);
        for($i=1;$i<=10;$i++){
            DB::table('study_subject')->insert([
                "study_id"=>$id,
                "subject_id"=>$i
            ]);
        }
    }
}
