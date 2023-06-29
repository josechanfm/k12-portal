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
    public function allScores(){
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
        return $this->belongsToMany(Student::class,'course_student')->withPivot('id as pivot_course_student_id');
    }
    public function scoreColumns(){
        return $this->hasMany(ScoreColumn::class)->orderBy('term_id')->orderByRaw('-sequence DESC');
    }

    public function students2(){
        return $this->belongsToMany(Student::class)->with('scores');
    }
    public function students(){
        return $this->belongsToMany(Student::class,'course_student')->withPivot('id as pivot_course_student_id');
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
        //$students=Course::find($this->id)->students;
        $students=$this->students;
        foreach($students as $student){
            $student->scores=Score::where('course_student_id',$student->pivot->course_student_id)->get();
        }
        return $students;
    }

    public function studentsScores(){
        $terms=Config::item('year_terms');
        $students=$this->students;
        $scores=$this->allScores;
        $scoreColumns=$this->scoreColumns;
        $table=[];

        foreach($students as $student){
            $tmp=[];
            $tmp['student_id']=$student->id;
            $tmp['student_name']=$student->name_zh;
            $tmp['course_student_id']=$student->pivot->course_student_id;
            foreach($scoreColumns as $column){
                $tmp['scores'][$column->id]=[];
                foreach($scores as $score){
                    if($score->course_student_id==$tmp['course_student_id'] && $score->score_column_id==$column->id){
                        $score['column_letter']=$column->column_letter;
                            $tmp['scores'][$score->score_column_id]=$score;
                    }
                }
                if(empty($tmp['scores'][$column->id])){
                    $tmp['scores'][$column->id]=(object)[
                        "course_student_id"=>$student->pivot->course_student_id,
                        "score_column_id"=>$column->id,
                        "student_id"=>$student->id,
                        "point"=>'',
                    ];
                }

            }
            array_push($table, $tmp);
        }
        return $table;

    }

    // public static function students_outcomes($kid){
    //     return Course::where('klass_id',$kid)->whereNot('type','SUB')->get();
    // }
}
