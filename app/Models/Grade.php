<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Grade extends Model
{
    use HasFactory;

    protected $fillable=['rank','initial','level','tag','name_zh','name_en','description','version'];
    public function klasses(){
        return $this->hasMany(Klass::class);
    }
    public function year(){
        return $this->belongsTo(Year::class);
    }
    public function subjects(){
        return $this->hasMany(Subject::class);
    }

}
