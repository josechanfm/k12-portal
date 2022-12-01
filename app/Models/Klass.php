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
    public function students(){
        return $this->belongsToMany(Student::class,'klassmates','klass_id','student_id')->withPivot(['id as pivot_klassmate_id','stream','state','promote']);
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
