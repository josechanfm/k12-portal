<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Mockery\Undefined;

class Habit extends Model
{
    use HasFactory;
    use \Znck\Eloquent\Traits\BelongsToThrough;

    // static function byKlassId($kid){
    //     $klass=Klass::with('students')->find($kid);
    //     if(isset($klass->students)){
    //         return Habit::whereIn('klass_student_id',$klass->students->pluck('pivot.klass_student_id'))->get();
    //     }else{
    //         return [];
    //     }
    // }

    public function student(){
        return $this->belongsToThrough(
            Student::class,
            KlassStudent::class
        );
        //return $this->belongsTo(KlassStudent::class,'klass_student_id')->with('student');
        //return $this->belongsToMany(Student::class,'klass_student','id','student_id');
    }
}
