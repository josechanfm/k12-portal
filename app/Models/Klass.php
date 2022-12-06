<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Klass extends Model
{
    use HasFactory;
    protected $fillable=['year_id','grade','initial','acronym','room','head_id'];

    
    
    // public function subjects(){
    //     return $this->belongsToMany(Subject::class);
    // }
    protected $appends= ['initial','acronym'];
    
    public function getInitialAttribute(){
        return Grade::find($this->grade_id)->initial;
    }
    public function getAcronymAttribute(){
        return Grade::find($this->grade_id)->initial.$this->letter;
    }
    public function grade(){
        return $this->belongsTo(Grade::class);
    }
    public function students(){
        return $this->belongsToMany(Student::class,'klass_students','klass_id','student_id')->withPivot(['id as pivot_klass_student_id','student_number','stream','state','promote','promote_to']);
    }
    public function courses(){
        return $this->hasMany(Course::class);
    }
    // public function scores(){
    //     return $this->hasManyThrough(
    //         Score::class,
    //         KlassStudent::class,
    //         'klass_id',
    //         'klass_student_id',
    //         'id',
    //         'id'
    //     );
    // }
}
