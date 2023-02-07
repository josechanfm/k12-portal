<?php

namespace App\Observers;

use App\Models\Klass;
use App\Models\Study;
use App\Models\Course;
use App\Models\ScoreColumn;
use App\Models\ScoreTemplate;

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
        //$subjects=Subject::where('grade_id',$klass->grade_id)->get();
        $subjects=Study::find($klass->study_id)->subjects()->get();
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
            $fields['score_column_template']=$subject->score_column_template;
            $fields['study_id']=$subject->pivot->study_id;
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
            $socreBatches=ScoreTemplate::where('batch',$course->score_template_batch)->get();
            foreach($socreBatches as $score){
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->type=$course->type;
                $score_column->term_id=$score->term_id;
                $score_column->name=$score->name;
                $score_column->sequence=$score->sequence;
                $score_column->scheme=$score->scheme;
                $score_column->description=$score->description;
                $score_column->for_transcript=$score->for_transcript;
                $score_column->save();
            }
        }
/*            
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
            }elseif($course->code=='ATT'){
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='衣服鞋襪整齊清潔。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='常剪指甲。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='懂得使用手帕或紙巾。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='不把手指雜物放進口裡。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='能把廢物投入廢紙箱內。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='守秩序不喧嚷。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='留心聽講。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='坐立行走姿勢正確。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='離開座位把物件桌椅整理好。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='愛護公物用後放回原處。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='遵守校規。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='守時。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='尊敬師長，友受和睦。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='樂於助人。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='會和別人分享及輪候。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=1;
                $score_column->name='誠實坦白肯認錯。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='衣服鞋襪整齊清潔。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='常剪指甲。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='懂得使用手帕或紙巾。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='不把手指雜物放進口裡。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='能把廢物投入廢紙箱內。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='守秩序不喧嚷。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='留心聽講。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='坐立行走姿勢正確。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='離開座位把物件桌椅整理好。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='愛護公物用後放回原處。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='遵守校規。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='守時。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='尊敬師長，友受和睦。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='樂於助人。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='會和別人分享及輪候。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
                $score_column = new ScoreColumn;
                $score_column->course_id=$course->id;
                $score_column->term_id=2;
                $score_column->name='誠實坦白肯認錯。';
                $score_column->type=$course->type;
                $score_column->for_transcript=true;
                $score_column->save();
            }
*/            
            // "H1":"衣服鞋襪整齊清潔。"
            // "H2":"常剪指甲。"
            // "H3":"懂得使用手帕或紙巾。"
            // "H4":"不把手指雜物放進口裡。"
            // "H5":"能把廢物投入廢紙箱內。"

            // "B1":"守秩序不喧嚷。"
            // "B2":"留心聽講。"
            // "B3":"坐立行走姿勢正確。"
            // "B4":"離開座位把物件桌椅整理好。"
            // "B5":"愛護公物用後放回原處。"
            // "B6":"遵守校規。"

            // "S1":"守時。"
            // "S2":"尊敬師長，友受和睦。"
            // "S3":"樂於助人。"
            // "S4":"會和別人分享及輪候。"
            // "S5":"誠實坦白肯認錯。"
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

