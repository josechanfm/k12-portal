<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ability extends Model
{
    use HasFactory;

    public function student(){
        return $this->hasOneThrough(Student::class, KlassStudent::class,'id','id');
    }

    public function topic(){
        return $this->belongsTo(Topic::class);
    }
    

}
