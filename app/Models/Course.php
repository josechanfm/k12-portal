<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Course extends Model
{
    use HasFactory;

    protected $fillable=['student_id','code','title_zh','title_en','type','stream','elective','description','score_column','score_scheme','in_transcript','unit','active','subject_head_ids','marks_student','marks_guardian'];

    public function students(){
        return $this->belongsTo(Student::class);
    }

}
