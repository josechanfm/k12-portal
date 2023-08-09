<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ExtracurricularSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('extracurriculars')->insert([
            'title_zh'=>'迷你麵粉飾物製作',
            'active'=>true
        ]);
        DB::table('extracurriculars')->insert([
            'title_zh'=>'聲樂',
            'active'=>true
        ]);
        DB::table('extracurriculars')->insert([
            'title_zh'=>'時裝設計',
            'active'=>true
        ]);
        DB::table('extracurriculars')->insert([
            'title_zh'=>'手語班',
            'active'=>true
        ]);
        DB::table('extracurriculars')->insert([
            'title_zh'=>'笛子',
            'active'=>true
        ]);

    }
}
