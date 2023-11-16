<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Physical extends Model
{
    use HasFactory;

    public function strengths(){
        return $this->hasMany(Strength::class);
    }
    public function klass(){
        return $this->belongsTo(Klass::class);
    }
}
