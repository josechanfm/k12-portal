<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ThemeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */

    public function run()
    {
        $grades=DB::table('grades')->where('grade_year','<=',3)->get();
        foreach($grades as $grade){
            $klasses=DB::table('klasses')->where('grade_id',$grade->id)->get();
            foreach($klasses as $klass){
                $themes=DB::table('theme_templates')->where('grade_year',$grade->grade_year)->get();
                foreach($themes as $theme){
                    $topics=DB::table('topic_templates')->where('theme_template_id',$theme->id)->get();
                    unset($theme->id);
                    unset($theme->grade_year);
                    $theme->klass_id=$klass->id;
                    DB::table('themes')->insert(
                        (array)$theme
                    );
                    $themeId=DB::getPdo()->lastInsertId();
                    foreach($topics as $topic){
                        unset($topic->id);
                        unset($topic->theme_template_id);
                        $topic->theme_id=$themeId;
                        DB::table('topics')->insert(
                            (array)$topic
                        );
                    };
                }
            }    
        }
    }
}
