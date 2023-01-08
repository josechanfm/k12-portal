<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TranscriptSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $personal=DB::table('transcript_templates')->where('category','PERSONAL')->get();
        $subject=DB::table('transcript_templates')->where('category','SUBJECT')->get();
        $attitude=DB::table('transcript_templates')->where('category','ATTITUDE')->get();
        $summary=DB::table('transcript_templates')->where('category','SUMMARY')->get();
        $general=DB::table('transcript_templates')->where('category','GENERAL')->get();
        foreach($personal as $p){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'T1',
                'category'=>$p->category,
                'field_name'=>$p->field_name,
                'field_value'=>'TEST '.$p->field_name,
            ]);
        };
        foreach($subject as $s){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'T1E',
                'category'=>$s->category,
                'field_name'=>$s->field_name,
                'field_value'=>rand(1,100),
            ]);
        };
        foreach($subject as $s){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'T1P',
                'category'=>$s->category,
                'field_name'=>$s->field_name,
                'field_value'=>rand(1,100),
            ]);
        };
        foreach($subject as $s){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'T1A',
                'category'=>$s->category,
                'field_name'=>$s->field_name,
                'field_value'=>rand(1,100),
            ]);
        };
        foreach($subject as $s){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'T2E',
                'category'=>$s->category,
                'field_name'=>$s->field_name,
                'field_value'=>rand(1,100),
            ]);
        };
        foreach($subject as $s){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'T2P',
                'category'=>$s->category,
                'field_name'=>$s->field_name,
                'field_value'=>rand(1,100),
            ]);
        };
        foreach($subject as $s){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'T2A',
                'category'=>$s->category,
                'field_name'=>$s->field_name,
                'field_value'=>rand(1,100),
            ]);
        };
        foreach($subject as $s){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'FIN',
                'category'=>$s->category,
                'field_name'=>$s->field_name,
                'field_value'=>rand(50,100),
            ]);
        };

        foreach($attitude as $a){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'T1',
                'category'=>$a->category,
                'field_name'=>$a->field_name,
                'field_value'=>'A',
            ]);
        };
        foreach($attitude as $a){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'T2',
                'category'=>$a->category,
                'field_name'=>$a->field_name,
                'field_value'=>'B',
            ]);
        };
        foreach($summary as $s){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'T1',
                'category'=>$s->category,
                'field_name'=>$s->field_name,
                'field_value'=>rand(1,100),
            ]);
        };
        foreach($summary as $s){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'T2',
                'category'=>$s->category,
                'field_name'=>$s->field_name,
                'field_value'=>rand(1,100),
            ]);
        };
        foreach($summary as $s){
            DB::table('transcripts')->insert([
                'klass_student_id'=>1,
                'column'=>'FIN',
                'category'=>$s->category,
                'field_name'=>$s->field_name,
                'field_value'=>rand(1,100),
            ]);
        };
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'T1',
            'category'=>'GENERAL',
            'field_name'=>'comment',
            'field_value'=>'T1 Comment',
        ]);
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'T2',
            'category'=>'GENERAL',
            'field_name'=>'comment',
            'field_value'=>'T2 Coment',
        ]);
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'T1',
            'category'=>'GENERAL',
            'field_name'=>'reward_punishment',
            'field_value'=>'T1 reward punishment',
        ]);
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'T2',
            'category'=>'GENERAL',
            'field_name'=>'reward_punishment',
            'field_value'=>'T2 reward punishment',
        ]);
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'T1',
            'category'=>'GENERAL',
            'field_name'=>'leisure_name',
            'field_value'=>'T1 leisure name',
        ]);
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'T2',
            'category'=>'GENERAL',
            'field_name'=>'leisure_name',
            'field_value'=>'T2 leisure name',
        ]);
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'T1',
            'category'=>'GENERAL',
            'field_name'=>'leisure_performance',
            'field_value'=>'T1 leisure performance',
        ]);
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'T2',
            'category'=>'GENERAL',
            'field_name'=>'leisure_performance',
            'field_value'=>'T2 leisure performance',
        ]);
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'T1',
            'category'=>'GENERAL',
            'field_name'=>'remark',
            'field_value'=>'T1 remark',
        ]);
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'T2',
            'category'=>'GENERAL',
            'field_name'=>'remark',
            'field_value'=>'T2 remark',
        ]);
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'FIN',
            'category'=>'GENERAL',
            'field_name'=>'remark',
            'field_value'=>'FIN remark',
        ]);
        DB::table('transcripts')->insert([
            'klass_student_id'=>1,
            'column'=>'FIN',
            'category'=>'GENERAL',
            'field_name'=>'appraisal',
            'field_value'=>'FIN Appraisal',
        ]);

    }
}
