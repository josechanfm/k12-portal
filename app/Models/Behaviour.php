<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Behaviour extends Model
{
    use HasFactory;
    protected $fillable=['klass_student_id','term_id','staff_id','actor','score','remark'];

    public function staff(){
        return $this->belongsTo(Staff::class);
    }
    public function course(){
        return $this->belongsTo(Course::class);
    }

}
