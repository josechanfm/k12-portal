<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Healthcare extends Model
{
    use HasFactory;
    protected $fillable=['category','title','start_at','finish_at','responsible','description','bodycheck_columns','is_active'];
    protected $casts=['bodycheck_columns'=>'json', 'is_active'=>'boolean'];
   
    public function bodychecks(){
        return $this->hasMany(Bodycheck::class)->with('klassStudent');
    }
    public function klass(){
        return $this->belongsTo(Klass::class)->with('students');
    }
    public function klasses(){
        return $this->belongsToMany(Klass::class);
        // $klassStudentsIds=$this->physicals()->pluck('klass_student_id');
        // return Klass::where('id',KlassStudent::whereIn('id',$klassStudentsIds)->groupBy('klass_id')->pluck('klass_id'))->get();
    }

}
