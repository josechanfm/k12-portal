<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Habit extends Model
{
    use HasFactory;

    static function byKlassId($kid){
        $klass=Klass::with('students')->find($kid);
        return Habit::whereIn('klass_student_id',$klass->students->pluck('pivot.klass_student_id'))->get();
    }
}
