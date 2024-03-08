<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ScoreColumn extends Model
{
    use HasFactory;
    protected $fillable=['term_id','course_id','sequence','column_letter','field_name','field_label','scheme','formular','merge','description','is_total','for_transcript'];
    protected $casts=['merge'=>'json'];
    
    public function course(){
        return $this->belongsTo(Course::class);
    }
}
