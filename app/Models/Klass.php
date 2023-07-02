<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Klass extends Model
{
    use \Staudenmeir\EloquentHasManyDeep\HasRelationships;

    use HasFactory;
    protected $fillable=['grade_id','initial','tag','room'];
    
    // public function subjects(){
    //     return $this->belongsToMany(Subject::class);
    // }
   
    protected $appends= ['student_count','promoted_count','year_code','grade_year'];
    
    public function getGradeYearAttribute(){
        return Grade::find($this->grade_id)->grade_year;
    }
    public function getYearCodeAttribute(){
        return Grade::find($this->grade_id)->year->code;
    }

    public function getStudentCountAttribute(){
        return KlassStudent::where('klass_id',$this->id)->count();
    }
    public function getPromotedCountAttribute(){
        return KlassStudent::where('promote_to',$this->id)->count();
    }
    public function grade(){
        return $this->belongsTo(Grade::class)->with('themes');
    }
    public function students(){
        return $this->belongsToMany(Student::class)
                ->withPivot(['id as pivot_klass_student_id','student_number','stream','state','promote','promote_to']);
    }
    public function teachers(){
        return $this->belongsToMany(Teacher::class,'klass_teacher','klass_id','teacher_id');
    }
    public function promoteTo(){
        return $this->belongsToMany(Student::class,'klass_student','promote_to','student_id')->withPivot(['id as pivot_klass_student_id','student_number','stream','state','promote','promote_to','id as pivot_klass_id']);
    }
    public function courses(){
        return $this->hasMany(Course::class)->with('scoreColumns');
    }

    public function coursesStudents(){
        return $this->hasMany(Course::class)->with('students');
    }
    public function coursesScores(){
        return $this->hasMany(Course::class)->with('all_scores');
    }
    public function transcriptCoursesScores(){
        return $this->hasMany(Course::class)->where('in_transcript',1)->with('allScores');
        // return $this->hasMany(Course::class)->with('scores')->with('students');
    }
    public function outcomes(){
        return $this->hasManyThrough(Outcome::class, KlassStudent::class,'klass_id', 'klass_student_id')->with('student');
    }
    public function students_abilities(){
        return $this->belongsToMany(Student::class)->with('abilities')->withPivot('id as pivot_klass_student_id');
    }

    public function themes(){
        return $this->belongsToMany(Theme::class,'grades','id','grade_year','grade_year','grade_year');
    }

    // public static function klass_scores($klassId){
    //     $students=Klass::find($klassId)->students;
    //     foreach($students as $i=>$student){
    //         $student->scores=Score::where('klass_student_id',$student->pivot->klass_student_id)->get();
    //     }
    //     return $students;
    // }
    public function transcript(){
        $coursesScores = $this->transcriptCoursesScores; //all Courses in transcript with scores
        $students = $this->students; //all student in the klass
        $courses = $this->courses->where('in_transcript', 1); //all Courses in the klass with score_columns
        //rebuild all scores in an array, index with student_id, course_id and score_column_id
        $tmpScores = [];
        foreach ($coursesScores as $course) {
            foreach ($course->allScores as $score) {
                $tmpScores[$score->student_id][$course->id][$score->score_column_id] = $score->point;
            }
        }
        //generate student list with personal info required in transcript
        //loop all scores in term_id==9 in all courses and put it in student array list
        $transcript = [];
        $scoreColumns = [];
        foreach ($students as $student) {
            $tmp = [
                'student_id' => $student->id,
                'student_name' => $student->name_zh,
                'klass_student_id' => $student->pivot->klass_student_id
            ];
            foreach ($courses as $course) {
                $scoreColumn = $course->scoreColumns->where('term_id', 9)->first();
                //$transcript[]['scores'][$scoreColumnId]=$tmpScores[$student->id][$course->id][$scoreColumnId];
                if (isset($tmpScores[$student->id][$course->id])) {
                    $tmp['scores'][$scoreColumn->id] = $tmpScores[$student->id][$course->id][$scoreColumn->id];
                } else {
                    $tmp['scores'][$scoreColumn->id] = '--';
                }
                $scoreColumn['course_code'] = $course->code;
                $scoreColumn['course_title'] = $course->title_zh;
                $scoreColumns[$scoreColumn->id] = $scoreColumn;
            }
            $transcript['students'][] = $tmp;
        }
        $transcript['score_columns']=$scoreColumns;
        return $transcript;
    }


}
