<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class KlassSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {


        $initial=['A','B','C','D','E'];
        
        for($g=1;$g<=12;$g++){
            foreach($initial as $ini){
                DB::table('klasses')->insert([
                    'grade_id'=>$g,
                    'tag'=>$ini,
                ]);
            }
        }

    }
}
