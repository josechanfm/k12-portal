<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Klass;

class Discipline extends Model
{
    use HasFactory;
    protected $fillable=['klass_id','subject_id'];

}
