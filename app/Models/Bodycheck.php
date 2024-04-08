<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bodycheck extends Model
{
    use HasFactory;

    protected $fillable=['healthcare_id','klass_student_id','column_value','value'];
    public $timestamps = false;

    public function healthcare(){
        return $this->belongsTo(Healthcare::class);
    }
    public function klassStudent(){
        return $this->belongsTo(KlassStudent::class)->with('student');
    }
}
