<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Course extends Model
{
    use HasFactory;
    // protected $appends=['student_count'];

    // public function getStudentCountAttribute(){
    //     return $this->students->count();
    // }
    public function klass(){
        return $this->belongsTo(Klass::class);
    }
    public function all_scores(){
        return $this->hasManyThrough(
            Score::class,
            CourseStudent::class,
            'course_id',
            'course_student_id',
            'id',
            'id'
        );
    }
    public function scores(){
        return $this->belongsToMany(Student::class,'course_students')->withPivot('id as pivot_course_student_id');
    }
    public function scoreColumns(){
        return $this->hasMany(ScoreColumn::class)->orderByRaw('-sequence DESC');
    }

    public function students2(){
        return $this->belongsToMany(Student::class)->with('scores');
    }
    public function students(){
        return $this->belongsToMany(Student::class,'course_students')->withPivot('id as pivot_course_student_id');
    }
    public function teachers(){
        return $this->belongsToMany(Teacher::class)->withPivot('is_head');
    }
    // public function subject(){
    //     return $this->belongsTo(Subject::class);
    // }
    // public static function gather_scores($courseId){
    //     $students=Course::find($courseId)->students;
    //     foreach($students as $student){
    //         $student->scores=Score::where('klass_student_id',$student->pivot->klass_student_id)->get();
    //     }
    //     return $students;
    // }

    //public static function students_scores($cid){
    public function students_scores(){
        $students=Course::find($this->id)->students;
        foreach($students as $student){
            $student->scores=Score::where('course_student_id',$student->pivot->course_student_id)->get();
        }
        return $students;
    }
    // public static function students_outcomes($kid){
    //     return Course::where('klass_id',$kid)->whereNot('type','SUB')->get();
    // }
}
