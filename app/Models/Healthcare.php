<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Healthcare extends Model
{
    use HasFactory;
    protected $casts=['data_fields'=>'json'];
    protected $fillable=['klass_id','category','title','date','responsible','description','data_fields'];
    public function physicals(){
        return $this->hasMany(Physical::class);
    }
    public function klass(){
        return $this->belongsTo(Klass::class)->with('students');
    }
    public function klasses(){
        return $this->hasMany(Physical::class)->with('klass');
    }
}
