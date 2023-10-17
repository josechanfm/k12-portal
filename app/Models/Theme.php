<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Theme extends Model
{
    use HasFactory;
    protected $fillable=['klass_id','term_id','sequence','title'];
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
        $this->topics;
        $data['theme']=$this;
        
        $abilities=array_column($klassStudent->hasMany(Ability::class)->get()->toArray(),null,'topic_id');
        $data['students'][$klassStudent->id]=$klassStudent->student;
        foreach($this->topics as $topic){
            $data['scores'][$klassStudent->id][$topic->id]=$abilities[$topic->id]?$abilities[$topic->id]:null;
        }
        //dd($data['theme']);
        return $data;
    
    }
    public static function summary(Klass $klass){
        $data=[];
        $topicSectionGroupKeys=['1','2','3','4','5'];
        $sectionIds=[1,2,3,4,5,6,7,8,9,10];
        $topicSections[]=array_fill_keys($sectionIds,null);
        //dd($topicSections);

        $themeCount=$klass->themes->count();
        $data['topics']=$klass->themes->first()->topics;
        foreach($klass->students as $student){
            $data['summaries'][$student->pivot->klass_student_id]=array_fill_keys($sectionIds,0);
            $data['students'][$student->pivot->klass_student_id]=$student;
            $abilities=KlassStudent::find($student->pivot->klass_student_id)->hasMany(Ability::class)->get();
            foreach($klass->topics as $topic){
                $ability=$abilities->where('topic_id',$topic->id)->first();
                // echo json_encode($ability);
                // echo '<hr>';
                $data['scores'][$student->pivot->klass_student_id][$topic->id]=$ability;
                $data['summaries'][$student->pivot->klass_student_id][$topic->section_id]+=$ability->credit;
            }
            foreach($data['summaries'][$student->pivot->klass_student_id] as $sectionId=>$sum){
                $data['averages'][$student->pivot->klass_student_id][$sectionId]=round($sum/$themeCount,2);
            }
            //$data['average'][$student->pivot->klass_student_id][]
        }
        return $data;
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
