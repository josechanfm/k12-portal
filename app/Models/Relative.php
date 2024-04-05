<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Relative extends Model
{
    use HasFactory;
    protected $fillable=['student_id','relation','kinship','name_zh','name_fn','birth_year','age','organization','occupation','mobile'];
}
