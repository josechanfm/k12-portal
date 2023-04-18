<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Grade extends Model
{
    use HasFactory;

    protected $fillable=['year_id','rank','initial','level','tag','title_zh','title_en','description','version','active'];

    public function klasses(){
        return $this->hasMany(Klass::class);
    }
    public function year(){
        return $this->belongsTo(Year::class);
    }
    public function subjects(){
        return $this->hasMany(Subject::class);
    }

    public function themes(){
        return $this->hasMany(Theme::class,'grade_year','grade_year')->with('topics');
    }

    public function topics(){
        return $this->hasManyThrough(
            Topic::class,
            Theme::class,
            'grade_year',
            'theme_id',
            'grade_year',
            'id'
        )->with('theme');
    }

}
