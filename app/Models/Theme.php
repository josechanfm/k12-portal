<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Theme extends Model
{
    use HasFactory;
    protected $fillable=['klass_id','term_id','sequence','title','description'];
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
    public static function abilitiesGroupByTopicCategory(Klass $klass){
        $data=[];
        $data['topics']=$klass->themes->first()->topics;
        $sum=0;
        foreach($klass->students as $student){
            //$data['summaries'][$student->pivot->klass_student_id]=array_fill_keys($categoryCodes,0);
            $data['students'][$student->pivot->klass_student_id]=$student;
            $abilities=KlassStudent::find($student->pivot->klass_student_id)->hasMany(Ability::class)->get();
            foreach($klass->topics as $topic){
                $data['summaries'][$student->pivot->klass_student_id][$topic->category_code]=0;
            }
            foreach($klass->topics as $topic){
                $ability=$abilities->where('topic_id',$topic->id)->first();
                //scores store ability record into array
                $data['scores'][$student->pivot->klass_student_id][$topic->id]=$ability;
                $data['summaries'][$student->pivot->klass_student_id][$topic->category_code]+=$ability->credit;
                $sum+=$ability->credit;
            }
            $data['averages'][$student->pivot->klass_student_id]=round($sum/count($data['topics']),2);
        }
        return $data;
    }
}
