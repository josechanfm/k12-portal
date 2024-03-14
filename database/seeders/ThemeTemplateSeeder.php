<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ThemeTemplateSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data=[
            [
            'grade_year'=>1,'term_id'=>1,'sequence'=>1,'title'=>'第一天上學(上)',],[
            'grade_year'=>1,'term_id'=>1,'sequence'=>2,'title'=>'第二天上學(上)',],[
            'grade_year'=>1,'term_id'=>1,'sequence'=>3,'title'=>'第三天上學(上)',],[
            'grade_year'=>1,'term_id'=>2,'sequence'=>1,'title'=>'第一天上學(下)',],[
            'grade_year'=>1,'term_id'=>2,'sequence'=>2,'title'=>'第二天上學(下)',],[
            'grade_year'=>1,'term_id'=>2,'sequence'=>3,'title'=>'第三天上學(下)',],[
            'grade_year'=>2,'term_id'=>1,'sequence'=>1,'title'=>'第一天上學(上)',],[
            'grade_year'=>2,'term_id'=>1,'sequence'=>2,'title'=>'第二天上學(上)',],[
            'grade_year'=>2,'term_id'=>1,'sequence'=>3,'title'=>'第三天上學(上)',],[
            'grade_year'=>2,'term_id'=>2,'sequence'=>1,'title'=>'第一天上學(下)',],[
            'grade_year'=>2,'term_id'=>2,'sequence'=>2,'title'=>'第二天上學(下)',],[
            'grade_year'=>2,'term_id'=>2,'sequence'=>3,'title'=>'第三天上學(下)',],[
            'grade_year'=>3,'term_id'=>1,'sequence'=>1,'title'=>'第一天上學(上)',],[
            'grade_year'=>3,'term_id'=>1,'sequence'=>2,'title'=>'第二天上學(上)',],[
            'grade_year'=>3,'term_id'=>1,'sequence'=>3,'title'=>'第三天上學(上)',],[
            'grade_year'=>3,'term_id'=>2,'sequence'=>1,'title'=>'第一天上學(下)',],[
            'grade_year'=>3,'term_id'=>2,'sequence'=>2,'title'=>'第二天上學(下)',],[
            'grade_year'=>3,'term_id'=>2,'sequence'=>3,'title'=>'第三天上學(下)',]
        ];
        foreach($data as $i=>$d){
            DB::table('theme_templates')->insert($d);
        }  
}
}
