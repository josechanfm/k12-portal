<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Study;
use App\Models\Subject;

class StudySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data=[
            ['code'=>'NAT', 'title_zh'=>'科學', 'title_en'=>'Nature Science', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'],
            ['code'=>'MAN', 'title_zh'=>'普通話', 'title_en'=>'Mandarin', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'],
            ['code'=>'HIS', 'title_zh'=>'歷史', 'title_en'=>'History', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'],
            ['code'=>'GEO', 'title_zh'=>'地理', 'title_en'=>'Geography', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'0', 'unit'=>'1', 'active'=>'1', 'version'=> '1'],
            ['code'=>'RED', 'title_zh'=>'閱讀', 'title_en'=>'Reading', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'0', 'unit'=>'1', 'active'=>'1', 'version'=> '1'],
            ['code'=>'VAR', 'title_zh'=>'視覺藝術', 'title_en'=>'Visual Art', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'],
            ['code'=>'MUS', 'title_zh'=>'音樂', 'title_en'=>'Music', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'],
            ['code'=>'MAT', 'title_zh'=>'數學', 'title_en'=>'mathematic', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'],
            ['code'=>'ENG', 'title_zh'=>'英語', 'title_en'=>'English', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'],
            ['code'=>'PED', 'title_zh'=>'體育', 'title_en'=>'Physical Education', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'],
            ['code'=>'REL', 'title_zh'=>'宗教', 'title_en'=>'Religious Education', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'],
            ['code'=>'CED', 'title_zh'=>'公民', 'title_en'=>'Civic Education', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'],
            ['code'=>'CHI', 'title_zh'=>'中國語文', 'title_en'=>'Chinese Literature', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1'],
            ['code'=>'ICT', 'title_zh'=>'資訊科技', 'title_en'=>'Information and Communication Technology', 'type'=> 'SUB', 'stream'=>'ALL', 'elective'=>'COM', 'in_transcript'=>'1', 'unit'=>'1',  'active'=>'1', 'version'=> '1']
        ];
        foreach($data as $d){
            Subject::create($d);
        }

        $data=[
            ['grade_level'=>'4','title_zh'=>'小學一年級','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_level'=>'5','title_zh'=>'小學二年級','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_level'=>'6','title_zh'=>'小學三年級','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_level'=>'7','title_zh'=>'小學四年級','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_level'=>'8','title_zh'=>'小學五年級','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_level'=>'9','title_zh'=>'小學六年級','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_level'=>'10','title_zh'=>'初中一年級','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_level'=>'11','title_zh'=>'初中二年級','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_level'=>'12','title_zh'=>'初中三年級','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_level'=>'13','title_zh'=>'高中一年級','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_level'=>'14','title_zh'=>'高中二年級','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_level'=>'15','title_zh'=>'高中三年級','stream'=>'ALL','version'=>1,'active'=>true],
        ];

        foreach($data as $d){
            $study=Study::create($d);
            $subjectIds=array_column(Subject::get()->toArray(),'id');
            $study->subjects()->sync($subjectIds);
        }
    }
}
