<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Mockery\Undefined;

class Habit extends Model
{
    use HasFactory;

    // static function byKlassId($kid){
    //     $klass=Klass::with('students')->find($kid);
    //     if(isset($klass->students)){
    //         return Habit::whereIn('klass_student_id',$klass->students->pluck('pivot.klass_student_id'))->get();
    //     }else{
    //         return [];
    //     }
    // }
}
