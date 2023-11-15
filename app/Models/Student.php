<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    use HasFactory;
    protected $fillable=['name_zh','name_fn','gender','dob'];

    // public function klasses(){
    //     return $this->belongsToMany(Klass::class,'klass_students','student_id','klass_id');
    // }
    // public static function scores(){
    //     return $this->hasManyThrough(Score::class, KlassStudent::class);
    // }
    public function treatments(){
        return $this->hasMany(Treatment::class);
    }
    public function klasses(){
        return $this->belongsToMany(Klass::class)->withPivot('student_number');
    }
    public function courses(){
        return $this->belongsToMany(Course::class,'course_student');
    }
    public function coursesScores(){
        return $this->belongsToMany(Course::class,'course_students')->with('scores');
    }
    public function addresses(){
        return $this->morphMany(Address::class, 'addressable');
    }

    public function address(){
        return $this->morphOne(Address::class, 'addressable')->latestOfMany();
    }
    public function identity_document(){
        return $this->morphOne(IdentityDocument::class, 'identity_documentable')->latestOfMany();
    }
    public function bank(){
        return $this->morphOne(Bank::class, 'bankable')->latestOfMany();
    }
    public function detail(){
        return $this->hasOne(StudentDetail::class);
    }
    public function parent()
    {
        return $this->hasOne(Parental::class);
    }
    public function guardians()
    {
        return $this->hasMany(Guardian::class);
    }
    public function guardian()
    {
        return $this->hasOne(Guardian::class)->latestOfMany();
    }
    public function healthcare(){
        return $this->hasOne(Healthcare::class);
    }
    public function abilities(){
        return $this->hasManyThrough(Ability::class, KlassStudent::class, 'student_id','klass_student_id')->with('topic');
    }
    public function activities(){
        return $this->belongsToMany(Student::class);
    }

    public static function getBehaviours($klassStudentId, $staff, $terms, $referenceId,$actor='SUBJECT'){
        $behaviours=[];
        foreach($terms as $term){
            if($staff==null){ //if director
                $tmp=Behaviour::where('klass_student_id',$klassStudentId)
                ->where('term_id',$term->value)
                ->where('actor',$actor)->first();
                if(empty($tmp)){
                    // dd('is empty'.$klassStudentId.$term->value);
                    $tmp=Behaviour::make([
                        'klass_student_id'=>$klassStudentId,
                        'staff_id'=>null,
                        'term_id'=>$term->value,
                        'reference_id'=>$referenceId,
                        'actor'=>$actor,
                        'score'=>null
                    ]);
                }
            }else{ //include course teachers and klass head teachers
                $tmp=Behaviour::where('klass_student_id',$klassStudentId)
                ->where('staff_id',$staff->id)
                ->where('term_id',$term->value)
                ->where('actor',$actor)->first();
                if(empty($tmp)){
                    // dd('is empty'.$klassStudentId.$term->value);
                    $tmp=Behaviour::make([
                        'klass_student_id'=>$klassStudentId,
                        'staff_id'=>$staff->id,
                        'term_id'=>$term->value,
                        'reference_id'=>$referenceId,
                        'actor'=>$actor,
                        'score'=>null
                    ]);
                }
    
            }
            $behaviours[$term->value]=$tmp;
        }
        return $behaviours;
    }
}
