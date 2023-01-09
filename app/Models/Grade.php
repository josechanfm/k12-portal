<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Grade extends Model
{
    use HasFactory;

    public function klasses(){
        return $this->hasMany(Klass::class);
    }
    public function year(){
        return $this->belongsTo(Year::class);
    }

}
