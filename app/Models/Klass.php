<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Klass extends Model
{
    use \Staudenmeir\EloquentHasManyDeep\HasRelationships;

    use HasFactory;
    protected $fillable=['year_id','grade','initial','acronym','room','head_id'];

    
    
    // public function subjects(){
    //     return $this->belongsToMany(Subject::class);
    // }
    protected $appends= ['initial','acronym','student_count','promoted_count'];
    
    public function getInitialAttribute(){
        return Grade::find($this->grade_id)->initial;
    }
    public function getAcronymAttribute(){
        return Grade::find($this->grade_id)->initial.$this->letter;
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
    public function scores(){
        return $this->hasManyDeep(Score::class,[KlassStudent::class ]);
    }
    
}
