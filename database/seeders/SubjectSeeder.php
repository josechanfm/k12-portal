<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Year;

class SubjectSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        /*
        5	NAS	科學	Natural sciences
81		普通話	Mandarin
6	HIS	歷史	History
7	GEO	地理	Geography
64	閱讀	閱讀	Reading
42	VART	視覺藝術	visual art
47	MUS	音樂	Music
41	MAT	數學	Math
45	ENG	英語	English
49	PE	體育	Physical Education
51	REL	宗教	Religious Education
57	公民	公民	Civic Education
44	CHI	中國語文	Chinese
73	資訊科技(一)	資訊科技(一)	IT(I)

        */
        DB::table('subjects')->insert([
            'code'=>'REL', 'title_zh'=>'宗教', 'title_en'=>'Relegion', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subjects')->insert([
            'code'=>'PHY', 'title_zh'=>'體能', 'title_en'=>'Physic', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subjects')->insert([
            'code'=>'CLT', 'title_zh'=>'語文', 'title_en'=>'Chinese Literature', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subjects')->insert([
            'code'=>'STY', 'title_zh'=>'故事', 'title_en'=>'Stry', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'0', 'unit'=>'1', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subjects')->insert([
            'code'=>'CWR', 'title_zh'=>'中寫', 'title_en'=>'Chinse_writting', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'0', 'unit'=>'1', 'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subjects')->insert([
            'code'=>'ELT', 'title_zh'=>'英文', 'title_en'=>'English Literature', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subjects')->insert([
            'code'=>'EWR', 'title_zh'=>'英寫', 'title_en'=>'English Writing', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subjects')->insert([
            'code'=>'OCS', 'title_zh'=>'常識', 'title_en'=>'Ordinary Common Sense', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subjects')->insert([
            'code'=>'NUM', 'title_zh'=>'識數', 'title_en'=>'Numeracy', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subjects')->insert([
            'code'=>'COM', 'title_zh'=>'電腦', 'title_en'=>'Computer', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subjects')->insert([
            'code'=>'PLA', 'title_zh'=>'唱遊', 'title_en'=>'Playgroup', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'
        ]);
        DB::table('subjects')->insert([
            'code'=>'ART', 'title_zh'=>'美勞', 'title_en'=>'Art Craft', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'
        ]); 
        /*       
        $year=Year::currentYear();
        DB::table('subjects')->insert([
            'grade_id'=>$year->id,
            'code'=>'CHN',
            'title_zh'=>'中文',
            'title_en'=>'Chinese',
            'type'=>'',
            'stream'=>'ART',
            'elective'=>0,
            'active'=>1
        ]);
        DB::table('subjects')->insert([
            'grade_id'=>$year->id,
            'code'=>'ENG',
            'title_zh'=>'英文',
            'title_en'=>'English',
            'type'=>'',
            'stream'=>'ART',
            'elective'=>0,
            'active'=>1
        ]);
        DB::table('subjects')->insert([
            'grade_id'=>$year->id,
            'code'=>'MAT',
            'title_zh'=>'數學',
            'title_en'=>'Mathematic',
            'type'=>'',
            'stream'=>'SCI',
            'elective'=>0,
            'active'=>1
        ]);
        DB::table('subjects')->insert([
            'grade_id'=>$year->id,
            'code'=>'PHY',
            'title_zh'=>'物理',
            'title_en'=>'Physics',
            'type'=>'',
            'stream'=>'SCI',
            'elective'=>1,
            'active'=>1
        ]);
        DB::table('subjects')->insert([
            'grade_id'=>$year->id,
            'code'=>'GEN',
            'title_zh'=>'常識',
            'title_en'=>'General',
            'type'=>'',
            'stream'=>'ART',
            'elective'=>1,
            'active'=>1
        ]);
        */
    }
}
