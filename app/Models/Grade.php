<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Grade extends Model
{
    use HasFactory;

    protected $fillable=['year_id','rank','initial','level','tag','title_zh','title_en','description','transcript_template_id','behaviour_scheme','version','active'];
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
        $yearTerms=Config::item('year_terms');
        //$templateGroups=array_column(TranscriptTemplate::select('category')->where('template_id',$this->transcript_template_id)->groupBy('category')->get()->toArray(),null,'category');
        $byTermCategories=['GENERAL'];
        $byYearCategories=['PERSONAL','SUMMARY'];
        $byTemplate=['appraisal','passing'];
        //SUBJECT are different with specific process
        $data=[];
        //dd($templateCategories);
        // dd($templateGroups['PERSONAL']);
        //PERSONAL category
        foreach($byYearCategories as $cat){
            $data[$cat]=array_column(TranscriptTemplate::where('template_id',$this->transcript_template_id)
                ->where('category',$cat)
                ->orderBy('id')->get()->toArray(),
                null,
                'reference_code'
            );
        }

        foreach($byTermCategories as $cat){
            $referenceCodes=TranscriptTemplate::select('reference_code')
                ->where('template_id',$this->transcript_template_id)
                ->where('category',$cat)
                ->groupBy('reference_code')->get()
                ->pluck('reference_code')
                ->mapWithKeys(function($item){
                    return [$item=>[]];
                });
            //dd($referenceCodes);
            foreach($referenceCodes as $referenceCode=>$value){
                foreach($yearTerms as $term){
                    $data[$cat][$term->value][$referenceCode]=
                        TranscriptTemplate::where('template_id',$this->transcript_template_id)
                            ->where('term_id',$term->value)
                            ->where('category',$cat)
                            ->where('reference_code',$referenceCode)
                            ->orderBy('id')->first();
                }
                $data[$cat][9][$referenceCode]=
                    TranscriptTemplate::where('template_id',$this->transcript_template_id)
                        ->where('term_id',9)
                        ->where('category',$cat)
                        ->where('reference_code',$referenceCode)
                        ->orderBy('id')->first();

            }
        }
        //SUBJECT Specifics
        $referenceCodes=TranscriptTemplate::select('reference_code')
            ->where('template_id',$this->transcript_template_id)
            ->where('category','SUBJECT')
            ->groupBy('reference_code')->get()
            ->pluck('reference_code')
            ->mapWithKeys(function($item){
                return [$item=>[]];
            });
        foreach($referenceCodes as $referenceCode=>$value){
            foreach($yearTerms as $term){
                $data['SUBJECT'][$term->value][$referenceCode]=array_column(
                    TranscriptTemplate::where('template_id',$this->transcript_template_id)
                        ->where('term_id',$term->value)
                        ->where('category','SUBJECT')
                        ->where('reference_code',$referenceCode)
                        ->orderBy('id')->get()->toArray()
                    ,null,
                    'field_name'
                );
            }
            $data['SUBJECT'][9][$referenceCode]=array_column(
                TranscriptTemplate::where('template_id',$this->transcript_template_id)
                    ->where('term_id',9)
                    ->where('category','SUBJECT')
                    ->where('reference_code',$referenceCode)
                    ->orderBy('id')->get()->toArray()
                ,null,
                'field_name'
            );  
        }
        $data['APPRAISAL']['appraisal']=TranscriptTemplate::where('template_id',$this->transcript_template_id)
            ->where('category','APPRAISAL')->first()->toArray();
        $data['PASSING']['passing']=TranscriptTemplate::where('template_id',$this->transcript_template_id)
            ->where('category','PASSING')->first()->toArray();
        return $data;
    }

    public function passingScore(){
        $template=TranscriptTemplate::where('template_id',$this->transcript_template_id)->where('reference_code','passing')->first();
        if(isset($template) && isset($template->value)){
            return $template->value;
        }
        return 60;
    }

}
