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
            'behave'=>[
                'attenance'=>[
                    'late'=>'遲到次數',
                    'forgot'=>'忘帶次數',
                    'missing'=>'欠交功課',
                    'leave'=>'請假節數',
                    'absent'=>'曠課節數'
                ],
                'perform'=>[
                    'good'=>'優點',
                    'great'=>'小功',
                    'excellent'=>'大功',
                    'leave'=>'缺點',
                    'minor'=>'小過',
                    'major'=>'大過',
                    'warning'=>'警告',
                    'honor'=>'光榮榜'
                ],
                'conduct'=>[
                    'conduct'=>'操行',
                ]
            ],
            'remarks'=>[
                'comments'=>[
                    'comment_t1'=>'備註',
                    'comment_t2'=>'備註',
                    'comment_final'=>'備註',
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
