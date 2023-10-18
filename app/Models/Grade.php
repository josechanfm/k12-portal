<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Grade extends Model
{
    use HasFactory;

    protected $fillable=['year_id','rank','initial','level','tag','title_zh','title_en','description','version','active'];
    protected $casts=['behaviour_scheme'=>'json'];

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

    public function themeTemplates(){
        return $this->hasMany(ThemeTemplate::class)->with('topicTemplates');
    }

    public function topics(){
        return $this->hasMany(ThemeTemplate::class);
        // return $this->hasManyThrough(
        //     Topic::class,
        //     Theme::class,
        // )->with('theme');
    }
    public function transcriptTemplates(){
        //$templateGroups=array_column(TranscriptTemplate::select('category')->where('template_id',$this->transcript_template_id)->groupBy('category')->get()->toArray(),null,'category');
        $templateGroups=TranscriptTemplate::select('category')->where('template_id',$this->transcript_template_id)->groupBy('category')->get()->pluck('category')->mapWithKeys(function($item){
            return [$item=>[]];
        });
        // dd($templateGroups['PERSONAL']);
        foreach($templateGroups as $cat=>$value){
            $templateGroups[$cat]=array_column(TranscriptTemplate::where('template_id',$this->transcript_template_id)->where('category',$cat)->get()->toArray(),null,'reference_code');

        }
        // $templates=TranscriptTemplate::where('template_id',$this->transcript_template_id)->get()->toArray();
        return $templateGroups;
        
        return array_column($templates,null,'category');
        
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
