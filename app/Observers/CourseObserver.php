<?php

namespace App\Observers;

use App\Models\Course;
use App\Models\ScoreColumn;

class CourseObserver
{
    /**
     * Handle the Course "created" event.
     *
     * @param  \App\Models\Course  $course
     * @return void
     */
    public function created(Course $course)
    {
        
        if($course->code=='LES'){
            $score_column = new ScoreColumn;
            $score_column->course_id=$course->id;
            $score_column->term_id=1;
            $score_column->type=$course->type;
            $score_column->name='活動名稱';
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

    /**
     * Handle the Course "updated" event.
     *
     * @param  \App\Models\Course  $course
     * @return void
     */
    public function updated(Course $course)
    {
        
    }

    /**
     * Handle the Course "deleted" event.
     *
     * @param  \App\Models\Course  $course
     * @return void
     */
    public function deleted(Course $course)
    {
        //
    }

    /**
     * Handle the Course "restored" event.
     *
     * @param  \App\Models\Course  $course
     * @return void
     */
    public function restored(Course $course)
    {
        //
    }

    /**
     * Handle the Course "force deleted" event.
     *
     * @param  \App\Models\Course  $course
     * @return void
     */
    public function forceDeleted(Course $course)
    {
        //
    }
}
