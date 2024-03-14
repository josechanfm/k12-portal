<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Staff;
use Illuminate\Support\Facades\DB;

class StaffSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //Staff::factory()->count(100)->create();
        $genders='MF';
        for($i=1;$i<100;$i++){
            DB::table('staffs')->insert([
                'user_id'=>$i,
                'name_zh'=>'Teacher '.$i,
                'gender'=>substr($genders,rand(0,1),1),
            ]);
        }
    }
}
