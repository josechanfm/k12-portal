<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Theme extends Model
{
    use HasFactory;
    protected $appends= ['topic_count'];
    
    public function getTopicCountAttribute(){
        return Topic::where('theme_id',$this->id)->count();
    }
    
    public function grade(){
        return $this->belongsTo(Garde::class);
    }

    public function topics(){
        return $this->hasMany(Topic::class);
    }

    public function report(){
        $data=[];
        $students=Klass::find($this->klass_id)->students;
        $yearTerms=Config::item('year_terms');
        $topicSections=$this->topics->groupBy('section_group');

        foreach($students as $student){
            $data['students'][$student->pivot->klass_student_id]=$student;
            foreach($yearTerms as $term){
                $data['sections'][$term->value]=$this->topics->where('term_id',$term->value)->groupBy('section_group');
                $data['topics'][$term->value]=$this->topics->where('term_id',$term->value);
                $data['abilities'][$student->pivot->klass_student_id][$term->value]=array_column(Ability::where('klass_student_id',$student->pivot->klass_student_id)->where('term_id',$term->value)->get()->toArray(),null,'topic_id');
            }
        }
        
        return $data;
    }
}
