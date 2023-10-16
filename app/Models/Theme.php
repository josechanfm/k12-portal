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

    public function klassAbilities(Klass $klass){
        $data=[];
        $data['theme']=$this;
        foreach($klass->students as $student){
            $data['students'][$student->pivot->klass_student_id]=$student;
            $abilities=array_column(KlassStudent::find($student->pivot->klass_student_id)->hasMany(Ability::class)->get()->toArray(),null,'topic_id');
            foreach($this->topics as $topic){
                $data['scores'][$student->pivot->klass_student_id][$topic->id]=$abilities[$topic->id];
            }
        }
        
        return $data;
    }
    public function studentAbilities(KlassStudent $klassStudent){
        $data=[];
        $data['theme']=array_column($this->toArray(),null,'id');
        $abilities=array_column($klassStudent->hasMany(Ability::class)->get()->toArray(),null,'topic_id');
        $data['students'][$klassStudent->id]=$klassStudent->student;
        foreach($this->topics as $topic){
            $data['scores'][$klassStudent->id][$topic->id]=$abilities[$topic->id]?$abilities[$topic->id]:null;
        }
        //dd($data);
        return $data;
    
    }
    public static function summary(Klass $klass){
        $data=[];
        $topicSectionGroupKeys=['1','2','3','4','5'];
        
        //$topicGroups[]=array_fill_keys($topicKeys,null);
        //dd($topicGroups);

        $themes=$klass->themes;
        $data['themes']=array_column($klass->themes->toArray(),null,'id');
        foreach($klass->students as $student){
            $data['students'][$student->pivot->klass_student_id]=$student;
            $abilities=KlassStudent::find($student->pivot->klass_student_id)->hasMany(Ability::class)->get();
            foreach($topicSectionGroupKeys as $sectionGroupKey){
                dd($klass->topics->where('section_group',$sectionGroupKey));
                $data['summary'][$topicGroup]=null;
            }
            
            foreach($klass->topics as $topic){
                $data['scores'][$student->pivot->klass_student_id][$topic->id]=$abilities->where('topic_id',$topic->id);
            }
        }
        dd($data); 
        dd($themes);
        dd($klass);
    }
    // public function reportStudent($student){
    //     $data=[];
    //     $klass=Klass::find($this->klass_id);
    //     $students=$klass->students;
    //     $yearTerms=Config::item('year_terms');
    //     $topicSections=$this->topics->groupBy('section_group');
    //     // $klass->themes;
    //     // $klass->topics;
    //     //$data['klass']=$klass;
    //     $data['theme']=$this;

    //     foreach($students as $student){
    //         $data['students'][$student->pivot->klass_student_id]=$student;
    //         foreach($yearTerms as $term){
    //             $data['sections'][$term->value]=$this->topics->where('term_id',$term->value)->groupBy('section_group');
    //             $data['topics'][$term->value]=$this->topics->where('term_id',$term->value);
    //             $data['abilities'][$student->pivot->klass_student_id][$term->value]=array_column(Ability::where('klass_student_id',$student->pivot->klass_student_id)->where('term_id',$term->value)->get()->toArray(),null,'topic_id');
    //         }
    //     }
        
    //     return $data;

    // }
    // public function reportKlass(){
    //     $data=[];
    //     $klass=Klass::find($this->klass_id);
    //     $students=$klass->students;
    //     $yearTerms=Config::item('year_terms');
    //     $topicSections=$this->topics->groupBy('section_group');
    //     // $klass->themes;
    //     // $klass->topics;
    //     //$data['klass']=$klass;
    //     $data['theme']=$this;

    //     foreach($students as $student){
    //         $data['students'][$student->pivot->klass_student_id]=$student;
    //         foreach($yearTerms as $term){
    //             $data['sections'][$term->value]=$this->topics->where('term_id',$term->value)->groupBy('section_group');
    //             $data['topics'][$term->value]=$this->topics->where('term_id',$term->value);
    //             $data['abilities'][$student->pivot->klass_student_id][$term->value]=array_column(Ability::where('klass_student_id',$student->pivot->klass_student_id)->where('term_id',$term->value)->get()->toArray(),null,'topic_id');
    //         }
    //     }
        
    //     return $data;
    // }
}
