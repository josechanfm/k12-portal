<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubjectTemplate extends Model
{
    use HasFactory;
    protected $fillable = ['code', 'title_zh', 'title_en','type','description', 'active',];

    public function courses(){
        return $this->hasMany(Course::class);
    }
    public function klasses(){
        return $this->hasManyDeep(Klass::class,['courses']);
    }

}
