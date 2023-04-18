<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Year;

class YearSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //$yearId=DB::table('years')->orderBy('id','desc')->first()->id;
        for($y=2021;$y<2023;$y++){
            DB::table('years')->insert([
                'code'=>$y,
                'title'=>$y.'-'.($y+1),
                'start'=>$y.'-09-01',
                'end'=>($y+1).'-07-30',
                'active'=>0
            ]);
            $yearId = DB::getPdo()->lastInsertId();
            //Kindergarten

            for($i=1;$i<=3;$i++){
                DB::table('grades')->insert([
                        'year_id'=>$yearId,
                        'grade_year'=>$i,
                        'initial'=>'K',
                        'level'=>$i,
                        'tag'=>'K'.$i,
                        'version'=>1,
                        'active'=>1
                ]);
            }

            //primary
            for($i=4;$i<=9;$i++){
                DB::table('grades')->insert([
                        'year_id'=>$yearId,
                        'grade_year'=>$i,
                        'initial'=>'P',
                        'level'=>$i-3,
                        'tag'=>'P'.$i-3,
                        'version'=>1,
                        'active'=>1
                ]);
            }
            //secondary junior
            for($i=10;$i<=12;$i++){
                DB::table('grades')->insert([
                        'year_id'=>$yearId,
                        'grade_year'=>$i,
                        'initial'=>'SC',
                        'level'=>$i-9,
                        'tag'=>'SC'.$i-9,
                        'version'=>1,
                        'active'=>1
                ]);
            }
            //secondary senior
            for($i=13;$i<=15;$i++){
                DB::table('grades')->insert([
                        'year_id'=>$yearId,
                        'grade_year'=>$i,
                        'initial'=>'SG',
                        'level'=>$i-12,
                        'tag'=>'SG'.$i-12,
                        'version'=>1,
                        'active'=>1
                ]);
            }
        };

        Year::where('id',1)->update(['active'=>'1']);
    }
}
