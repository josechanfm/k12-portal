<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Grade extends Model
{
    use HasFactory;

    protected $fillable=['year_id','rank','initial','level','tag','title_zh','title_en','description','version','active'];

    public function klasses(){
        return $this->hasMany(Klass::class);
    }
    public function students(){
        $klasses=$this->klasses;
        $students=new \Illuminate\Database\Eloquent\Collection;;
        foreach($klasses as $klass){
            $students=$students->merge($klass->students);
        }
        return $students;
    }
    public function year(){
        return $this->belongsTo(Year::class);
    }
    public function subjects(){
        return $this->hasMany(Subject::class);
    }

    public function themes(){
        return $this->hasMany(Theme::class,'grade_year','grade_year')->with('topics');
    }

    public function topics(){
        return $this->hasManyThrough(
            Topic::class,
            Theme::class,
            'grade_year',
            'theme_id',
            'grade_year',
            'id'
        )->with('theme');
    }
    public function transcriptTemplates(){
        $templates=TranscriptTemplate::where('template_id',$this->transcript_template_id)->get()->toArray();
        return array_column($templates,null,'reference_code');
        
        //return $this->hasMany(TranscriptTemplate::class,'template_id','transcript_template_id');
    }

    public function passingScore(){
        $template=TranscriptTemplate::where('template_id',$this->transcript_template_id)->where('reference_code','passing')->first();
        if(isset($template) && isset($template->value)){
            return $template->value;
        }
        return 60;
    }

}
