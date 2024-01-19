<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AdditiveTemplateSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data=[
            'BEHAVE'=>[
                'ATTENDANCE'=>[
                    'LATE'=>'遲到次數',
                    'FORGOT'=>'忘帶次數',
                    'MISSING'=>'欠交功課',
                    'LEAVE'=>'請假節數',
                    'ABSENT'=>'曠課節數'
                ],
                'PERFORM'=>[
                    'GOOD'=>'優點',
                    'GREAT'=>'小功',
                    'EXCELENT'=>'大功',
                    'FAULT'=>'缺點',
                    'MINOR'=>'小過',
                    'MAJOR'=>'大過',
                    'WARNING'=>'警告',
                    'HONOR'=>'光榮榜'
                ],
                'CONDUCT'=>[
                    'CONDUCT'=>'操行',
                ]
            ],
            'REMARK'=>[
                'COMMENT'=>[
                    'COMMENT_T1'=>'備註',
                    'COMMENT_T2'=>'備註',
                    'COMMENT_FINAL'=>'備註',
                ],
            ],
            'VIOLATION'=>[
                'VIOLATION'=>[
                    'VIOLATION'=>'違規'
                ],
            ]
        ];

        foreach($data as $scope=>$d){
            foreach($d as $category=>$r){
                foreach($r as $field=>$value){
                    DB::table('additive_templates')->insert([
                        'scope'=>$scope,
                        'category'=>$category,            
                        'reference_code'=>$field,
                        'title_zh'=>$value
                    ]);
                }
            }
        }
    }
}
