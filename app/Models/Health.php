<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Health extends Model
{
    use HasFactory;
    protected $fillable=['student_id','hospital', 'status', 'chronic', 'hereditary', 'allergy', 'disease', 'remark'];
    
}
