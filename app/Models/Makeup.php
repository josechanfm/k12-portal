<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Makeup extends Model
{
    use HasFactory;
    protected $fillable = ['course_student_id','point'];

    public function course(){
        return $this->belongsTo(Course::class);
    }

    public function student(){
        return $this->belongsToMany(Student::class,'klass_student','student_id','klass_id');
    }

}
