<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Grade;
use App\Models\Klass;

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
            $grade=Grade::find($g);
            foreach($initial as $ini){
                // DB::table('klasses')->insert([
                Klass::create([
                    'grade_id'=>$g,
                    'letter'=>$ini,
                    'tag'=>$grade->tag.$ini,
                ]);
            }
        }

    }
}
