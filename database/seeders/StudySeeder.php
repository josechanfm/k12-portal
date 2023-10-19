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
            'grade_level'=>'4',
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
            'grade_level'=>'5',
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
            'grade_level'=>'6',
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
            'grade_level'=>'7',
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
            'grade_level'=>'8',
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
            'grade_level'=>'9',
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
            'grade_level'=>'10',
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
            'grade_level'=>'11',
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
            'grade_level'=>'12',
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
            'grade_level'=>'13',
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
            'grade_level'=>'14',
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
            'grade_level'=>'15',
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
