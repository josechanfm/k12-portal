<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Guardian;
use Illuminate\Support\Facades\DB;

class GuardianSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Guardian::factory()->count(1000)->create();
        Guardian::find(1)->update(["user_id"=>100]);
        Guardian::find(2)->update(["user_id"=>101]);
        Guardian::find(3)->update(["user_id"=>102]);
        Guardian::find(4)->update(["user_id"=>103]);

        // DB::table('guardian_student')->insert([
        //     'guardian_id'=>1,
        //     'student_id'=>101,
        // ]);

    }
}
