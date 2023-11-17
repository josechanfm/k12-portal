<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Physical extends Model
{
    use HasFactory;

    protected $fillabled=['healthcare_id','klass_student_id','field_name','value'];
    public $timestamps = false;

    public function healthcare(){
        return $this->belongsTo(Healthcare::class);
    }
}
