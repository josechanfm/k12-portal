<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SubjectTemplateSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('subject_templates')->insert([
            'code'=>'REL', 'title_zh'=>'宗教', 'title_en'=>'Relegion', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'PHY', 'title_zh'=>'體能', 'title_en'=>'Physic', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'CLT', 'title_zh'=>'語文', 'title_en'=>'Chinese Literature', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'STY', 'title_zh'=>'故事', 'title_en'=>'Stry', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'CWR', 'title_zh'=>'中寫', 'title_en'=>'Chinse_writting', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'ELT', 'title_zh'=>'英文', 'title_en'=>'English Literature', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'EWR', 'title_zh'=>'英寫', 'title_en'=>'English Writing', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'OCS', 'title_zh'=>'常識', 'title_en'=>'Ordinary Common Sense', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'NUM', 'title_zh'=>'識數', 'title_en'=>'Numeracy', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'COM', 'title_zh'=>'電腦', 'title_en'=>'Computer', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'PLA', 'title_zh'=>'Playgroup', 'title_en'=>'唱遊', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'ART', 'title_zh'=>'美勞', 'title_en'=>'Art Craft', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'ATT', 'title_zh'=>'生活習慣和態度', 'title_en'=>'Habits and Attitudes', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'RPLA', 'title_zh'=>'獎懲遲缺', 'title_en'=>'Reword Punishment  Late and Absent', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'LES', 'title_zh'=>'餘暇活動', 'title_en'=>'Leisure Activies', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subject_templates')->insert([
            'code'=>'OVA', 'title_zh'=>'總體評分', 'title_en'=>'Overall Score', 'type'=> 'SUB', 'stream'=>'LIB', 'elective'=>'COP', 'active'=>'1', 'version'=> '1'
        ]);
    }
}
