<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Config;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;

class GradeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $currentYear=date('Y');
        $year=Year::where('code',$currentYear)->first();
        $initial=array_column(Config::item('klass_letters'),'label');
        //Kindergarten
        for($i=1;$i<=3;$i++){
            $grade=Grade::firstOrCreate([
                    'year_id'=>$year->id,
                    'grade_year'=>$i,
                    'initial'=>'K',
                    'level'=>$i,
                    'tag'=>'K'.$i,
                    'version'=>1,
                    'transcript_template_id'=>2,
                    'behaviour_scheme'=>'{"SUBJECT":0.3,"KLASS_HEAD":0.2,"DIRECTOR":0.5,"ADJUST":1}',
                    'active'=>1
            ]);
            foreach($initial as $ini){
                $grade->klasses()->create([
                    'letter'=>$ini,
                    'tag'=>$grade->tag.$ini,
                    'study_id'=>1,
                    'klass_head_ids'=>[rand(1,50)]
                ]);
            };

        }

        //primary
        for($i=4;$i<=9;$i++){
            $grade=Grade::firstOrCreate([
                    'year_id'=>$year->id,
                    'grade_year'=>$i,
                    'initial'=>'P',
                    'level'=>$i-3,
                    'tag'=>'P'.$i-3,
                    'version'=>1,
                    'transcript_template_id'=>1,
                    'behaviour_scheme'=>'{"SUBJECT":0.3,"KLASS_HEAD":0.2,"DIRECTOR":0.5,"ADJUST":1}',
                    'active'=>1
            ]);
            foreach($initial as $ini){
                $grade->klasses()->create([
                    'letter'=>$ini,
                    'tag'=>$grade->tag.$ini,
                    'study_id'=>1,
                    'klass_head_ids'=>[rand(1,50)]
                ]);
            };
        }
        //secondary junior
        for($i=10;$i<=12;$i++){
            $grade=Grade::firstOrCreate([
                    'year_id'=>$year->id,
                    'grade_year'=>$i,
                    'initial'=>'SC',
                    'level'=>$i-9,
                    'tag'=>'SC'.$i-9,
                    'version'=>1,
                    'transcript_template_id'=>1,
                    'behaviour_scheme'=>'{"SUBJECT":0.3,"KLASS_HEAD":0.2,"DIRECTOR":0.5,"ADJUST":1}',
                    'active'=>1
            ]);
            foreach($initial as $ini){
                $grade->klasses()->create([
                    'letter'=>$ini,
                    'tag'=>$grade->tag.$ini,
                    'study_id'=>1,
                    'klass_head_ids'=>[rand(1,50)]
                ]);
            };
        }
        //secondary senior
        for($i=13;$i<=15;$i++){
            $grade=Grade::firstOrCreate([
                    'year_id'=>$year->id,
                    'grade_year'=>$i,
                    'initial'=>'SG',
                    'level'=>$i-12,
                    'tag'=>'SG'.$i-12,
                    'version'=>1,
                    'transcript_template_id'=>1,
                    'behaviour_scheme'=>'{"SUBJECT":0.3,"KLASS_HEAD":0.2,"DIRECTOR":0.5,"ADJUST":1}',
                    'active'=>1
            ]);
            foreach($initial as $ini){
                $grade->klasses()->create([
                    'letter'=>$ini,
                    'tag'=>$grade->tag.$ini,
                    'study_id'=>1,
                    'klass_head_ids'=>[rand(1,50)]
                ]);
            };
        }
    }
}
