<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Action;

class Activity extends Model
{
    use HasFactory;

    protected $fillable=['term_id','title_zh','title_en','description','date_start','date_end','staff_id','active'];

    public function students(){
        return $this->belongsToMany(Student::class)->withPivot(['klass_id','score']);
    }

    public static function studentsOf(){
        $activities=Activity::where('active',true)->with('students')->get();
        foreach($activities as $activity){
            foreach($activity->students as $student){
                $student->klass=Klass::find($student->pivot->klass_id);
            }
        }
        return $activities;
    }
}
