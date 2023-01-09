<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Klass extends Model
{
    use \Staudenmeir\EloquentHasManyDeep\HasRelationships;

    use HasFactory;
    protected $fillable=['grade_id','head_id','initial','tag','room'];
    
    // public function subjects(){
    //     return $this->belongsToMany(Subject::class);
    // }
   
    protected $appends= ['student_count','promoted_count','year_abbr'];
    
    public function getYearAbbrAttribute(){
        return Grade::find($this->grade_id)->year->abbr;
    }

    public function getStudentCountAttribute(){
        return KlassStudent::where('klass_id',$this->id)->count();
    }
    public function getPromotedCountAttribute(){
        return KlassStudent::where('promote_to',$this->id)->count();
    }
    public function grade(){
        return $this->belongsTo(Grade::class);
    }
    public function students(){
        return $this->belongsToMany(Student::class,'klass_students','klass_id','student_id')->withPivot(['id as pivot_klass_student_id','student_number','stream','state','promote','promote_to']);
    }
    public function promoteTo(){
        return $this->belongsToMany(Student::class,'klass_students','promote_to','student_id')->withPivot(['id as pivot_klass_student_id','student_number','stream','state','promote','promote_to','id as pivot_klass_id']);
    }
    public function courses(){
        return $this->hasMany(Course::class);
    }
    public static function klass_scores($klassId){
        $students=Klass::find($klassId)->students;
        foreach($students as $i=>$student){
            $student->scores=Score::where('klass_student_id',$student->pivot->klass_student_id)->get();
        }
        return $students;
    }
    
}
