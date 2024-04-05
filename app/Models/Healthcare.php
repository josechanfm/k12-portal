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
        return $this->hasMany(Physical::class)->with('klassStudent');
    }
    public function klass(){
        return $this->belongsTo(Klass::class)->with('students');
    }
    public function klasses(){
        $klassStudentsIds=$this->physicals()->pluck('klass_student_id');
        return Klass::where('id',KlassStudent::whereIn('id',$klassStudentsIds)->groupBy('klass_id')->pluck('klass_id'))->get();
    }
}
