<?php

namespace App\Observers;

use App\Models\Klass;
use App\Models\Subject;
use App\Models\Course;
use App\Models\ScoreColumn;

class KlassObserver
{
    /**
     * Handle the Klass "created" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function created(Klass $klass)
    {
        $subjects=Subject::where('grade_id',$klass->grade_id)->get();
        $fields=[];
        $data=[];
        foreach($subjects as $subject){
            $fields['klass_id']=$klass->id;
            $fields['code']=$subject->code;
            $fields['title_zh']=$subject->title_zh;
            $fields['title_en']=$subject->title_en;
            $fields['type']=$subject->type;
            $fields['stream']=$subject->stream;
            $fields['elective']=$subject->elective;
            $fields['subject_id']=$subject->id;
            $fields['active']=true;
            $data[]=$fields;
        }
        Course::upsert(
            $data,
            ['klass_id','code'],
            ['title_zh','title_en','type','stream','elective','subject_id','active']
        );
        $courses=Course::whereBelongsTo($klass)->get();
        foreach($courses as $course){
            if($course->code=='LES'){
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='活動名稱';
                $score_column->type=$course->type;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='活動表現';
                $score_column->type=$course->type;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='活動名稱';
                $score_column->type=$course->type;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='活動表現';
                $score_column->type=$course->type;
                $score_column->save();
            }else{
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='上學期';
                $score_column->type=$course->type;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='下學期';
                $score_column->type=$course->type;
                $score_column->save();
            }
        }
    }

    /**
     * Handle the Klass "updated" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function updated(Klass $klass)
    {
        //
    }

    /**
     * Handle the Klass "deleted" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function deleted(Klass $klass)
    {
        Course::where('klass_id',$klass->id)->delete();
    }

    /**
     * Handle the Klass "restored" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function restored(Klass $klass)
    {
        
    }

    /**
     * Handle the Klass "force deleted" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function forceDeleted(Klass $klass)
    {
        //
    }
}

