<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transcript extends Model
{
    use HasFactory;
    protected $fillable=['transcript_template_id','klass_student_id','term_id','column','category','reference_code','field_name','value'];

}
