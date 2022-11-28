<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Klass extends Model
{
    use HasFactory;
    protected $fillable=['year_id','grade','initial','acronym','room','head_id'];

    public function subjects(){
        return $this->belongsToMany(Subject::class);
    }
}
