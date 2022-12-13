<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Score extends Model
{
    use HasFactory;

    public function course(){
        return $this->belongsTo(Course::class);
    }

    public function student(){
        //return $this->belongsTo(KlassStudent::class,'klass_student_id','id');
        return $this->belongsToMany(Student::class,'klass_students','student_id','klass_id');
        
    }
}
