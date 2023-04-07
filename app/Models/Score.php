<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Score extends Model
{
    use HasFactory;
    protected $fillable=['klass_student_id','score_column_id','point'];

    public function score_column(){
        return $this->belongsTo(ScoreColumn::class);
    }

    public function course(){
        return $this->belongsTo(Course::class);
    }

    public function student(){
        //return $this->belongsTo(KlassStudent::class,'klass_student_id','id');
        return $this->belongsToMany(Student::class,'klass_student','student_id','klass_id');
        
    }
}
