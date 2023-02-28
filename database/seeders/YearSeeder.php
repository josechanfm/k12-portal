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
            for($i=1;$i<=6;$i++){
                DB::table('grades')->insert([
                        'year_id'=>$yearId,
                        'sequence'=>$i,
                        'initial'=>'P',
                        'level'=>$i,
                        'tag'=>'P'.$i,
                        'version'=>1,
                        'active'=>1
                ]);
            }
            for($i=7;$i<=9;$i++){
                DB::table('grades')->insert([
                        'year_id'=>$yearId,
                        'sequence'=>$i,
                        'initial'=>'SC',
                        'level'=>$i-6,
                        'tag'=>'SC'.$i-6,
                        'version'=>1,
                        'active'=>1
                ]);
            }
            for($i=10;$i<=12;$i++){
                DB::table('grades')->insert([
                        'year_id'=>$yearId,
                        'sequence'=>$i,
                        'initial'=>'SG',
                        'level'=>$i-9,
                        'tag'=>'SG'.$i-9,
                        'version'=>1,
                        'active'=>1
                ]);
            }
        };

        Year::where('id',1)->update(['active'=>'1']);
    }
}
