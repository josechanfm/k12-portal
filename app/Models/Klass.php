<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Klass extends Model
{
    use \Staudenmeir\EloquentHasManyDeep\HasRelationships;

    use HasFactory;
    protected $fillable=['grade_id','initial','tag','room'];
    protected $casts=['klass_head_ids'=>'json'];
    // public function subjects(){
    //     return $this->belongsToMany(Subject::class);
    // }
   
    protected $appends= ['klass_heads','course_count','student_count','promoted_count','year_code','grade_year'];
    
    public function hasRight(){
        if(auth()->user()->hasRole('master') || auth()->user()->hasRole('admin')){
            return true;
        }
        return false;
    }
    public function isKlassHead(){
        if(empty(auth()->user()->staff)){
            return false;
        }
        if(is_array($this->klass_head_ids)){
            return in_array(auth()->user()->staff->id,$this->klass_head_ids);
        }else{
            return false;
        }
        
    }

    public function getKlassHeadsAttribute(){
        if(is_array($this->klass_head_ids)){
            return Staff::whereIn('id',$this->klass_head_ids)->get();
        };
        return [];
    }
    public function getGradeYearAttribute(){
        return Grade::find($this->grade_id)->grade_year;
    }
    public function getYearCodeAttribute(){
        return Grade::find($this->grade_id)->year->code;
    }
    public function getCourseCountAttribute(){
        return Course::where('klass_id',$this->id)->count();
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
    public function behaviours($actor='KLASS_HEAD'){
        $students=$this->students;
        $terms=Config::item('year_terms');
        $staff=auth()->user()->staff;
        //$actor="KLASS_HEAD";
        $klass=$this;
        $data=[];
        $referenceId=$this->id;
        foreach($students as $student){
            $data['students'][$student->pivot->klass_student_id]=$student;
            $data['scores'][$student->pivot->klass_student_id]=$student->getBehaviours($student->pivot->klass_student_id, $staff, $terms, $referenceId , $actor);
        }
        return $data;
        //return $students;
    }
    public function behaviourSummary(){
        $students=$this->students;
        $terms=Config::item('year_terms');
        $klass=$this;
        $data=[];
        //course teacher behaviours scores
        $actor='SUBJECT';
        foreach($students as $student){
            $data['students'][$student->pivot->klass_student_id]=$student;
            $tmpTerms=[];
            $tmp=[];
            foreach($this->courses as $course){
                $referenceId=$course->id;
                $tmp[$course->id]=array_column(
                    Behaviour::selectRaw('term_id, round(avg(score),0) as score_total')->where('klass_student_id',$student->pivot->klass_student_id)->where('actor',$actor)->where('reference_id',$course->id)->groupBy('term_id','reference_id')->get()->toArray(),
                    null,
                    'term_id'
                );
            };
            $data['subjects'][$student->pivot->klass_student_id]=$tmp;
            $student->courseTeachers=$tmp;
        }
        //Klass Head behaviours scores
        $actor='KLASS_HEAD';
        foreach($students as $student){
            $tmp=[];
            $data['klassHeads'][$student->pivot->klass_student_id]=array_column(
                Behaviour::selectRaw('term_id, round(avg(score),0) as score_total')->where('klass_student_id',$student->pivot->klass_student_id)->where('actor',$actor)->where('reference_id',$this->id)->groupBy('term_id','reference_id')->get()->toArray(),
                null,
                'term_id'
            );
            $student->klassHeads=array_column(
                Behaviour::selectRaw('term_id, round(avg(score),0) as score_total')->where('klass_student_id',$student->pivot->klass_student_id)->where('actor',$actor)->where('reference_id',$this->id)->groupBy('term_id','reference_id')->get()->toArray(),
                null,
                'term_id'
            );
        }
        //Director behaviours scores
        $actor='DIRECTOR';
        $referenceId=$this->id;
        $staff=auth()->user()->staff;
        foreach($students as $student){
            $data['director'][$student->pivot->klass_student_id]=$student->getBehaviours($student->pivot->klass_student_id, $staff, $terms, $referenceId , $actor);
            $student->director=$student->getBehaviours($student->pivot->klass_student_id, $staff, $terms, $referenceId , $actor);
        }
        //Director behaviours adjustment
        $actor='ADJUST';
        $referenceId=$this->id;
        $staff=auth()->user()->staff;
        foreach($students as $student){
            $data['adjust'][$student->pivot->klass_student_id]=$student->getBehaviours($student->pivot->klass_student_id, $staff, $terms, $referenceId , $actor);
            $student->adjust=$student->getBehaviours($student->pivot->klass_student_id, $staff, $terms, $referenceId , $actor);
        }
        
        foreach($data['students'] as $ksid=>$student){
            foreach($terms as $term){
                $coursesSum=0;
                $data['sumTerms'][$ksid][$term->value]=null;
                foreach($data['subjects'][$ksid] as $course){
                    if(isset($course[$term->value])){
                        $coursesSum+=$course[$term->value]['score_total'];
                    }
                }
                $data['sumCourse'][$ksid][$term->value]=$coursesSum;
                $data['sumTerms'][$ksid][$term->value]=$coursesSum;

                if(isset($data['klassHeads'][$ksid][$term->value])){
                    $data['sumKlassHeads'][$ksid][$term->value]=$data['klassHeads'][$ksid][$term->value]['score_total']*$this->grade->behaviour_scheme['KLASS_HEAD'];
                    $data['sumTerms'][$ksid][$term->value]+=$data['klassHeads'][$ksid][$term->value]['score_total']*$this->grade->behaviour_scheme['KLASS_HEAD'];
                }
                
                if(isset($data['director'][$ksid][$term->value])){
                    $data['sumDirector'][$ksid][$term->value]=$data['director'][$ksid][$term->value]['score']*$this->grade->behaviour_scheme['DIRECTOR'];
                    $data['sumTerms'][$ksid][$term->value]+=$data['director'][$ksid][$term->value]['score']*$this->grade->behaviour_scheme['DIRECTOR'];
                }
                if(isset($data['adjust'][$ksid][$term->value])){
                    $data['sumAdjust'][$ksid][$term->value]=$data['adjust'][$ksid][$term->value]['score']*$this->grade->behaviour_scheme['ADJUST'];
                    $data['sumTerms'][$ksid][$term->value]+=$data['adjust'][$ksid][$term->value]['score']*$this->grade->behaviour_scheme['ADJUST'];
                }
             
            }
            
        }
        
        return $data;
        /*
        foreach($students as $student){
            foreach($terms as $term){
                $termSum[$term->value]=0;
                $coursesSum=0;
                //dd($termSum);
                
                foreach($student->courseTeachers as $course){
                    if(isset($course[$term->value])){
                        $coursesSum+=$course[$term->value]['score_total'];
                    }
                }
                $termSum[$term->value]=$coursesSum*$this->grade->behaviour_scheme['SUBJECT'];

                if(isset($student->klassHeads[$term->value])){
                    $termSum[$term->value]+=$student->klassHeads[$term->value]['score_total']*$this->grade->behaviour_scheme['KLASS_HEAD'];
                }
                if(isset($student->director[$term->value])){
                    $termSum[$term->value]+=$student->director[$term->value]['score']*$this->grade->behaviour_scheme['DIRECTOR'];
                }
                if(isset($student->adjust[$term->value])){
                    $termSum[$term->value]+=$student->adjust[$term->value]['score']*$this->grade->behaviour_scheme['ADJUST'];
                }
            }
            $student->sumTerms=$termSum;
        }

        dd($data);
        return $students;
        */
    }
    public function promoteTo(){
        return $this->belongsToMany(Student::class,'klass_student','promote_to','student_id')->withPivot(['id as pivot_klass_student_id','student_number','stream','state','promote','promote_to','id as pivot_klass_id']);
    }
    public function courses(){
        return $this->hasMany(Course::class)->with('scoreColumns');
    }
    public function info(){
        return (object)["head"=>"123","subject_head"=>"567"];
    }

    public function coursesStudents(){
        return $this->hasMany(Course::class)->with('students');
    }
    public function coursesScores(){
        return $this->hasMany(Course::class)->with('allScores');
    }
    public function transcriptCoursesScores(){
        return $this->hasMany(Course::class)->where('in_transcript',1)->with('allScores');
        // return $this->hasMany(Course::class)->with('scores')->with('students');
    }
    public function transcripts(){
        $students=$this->students;
        $yearTerms=Config::item('year_terms');
        $data=[];
        $data['courses']=$this->courses;
        //dd($data['courses']);
        // $coursesScores=$this->coursesScores;
        // foreach($yearTerms as $term){
        //     foreach($coursesScores as $course){
        //         $data['courses'][$course->id]=array_column($course->scoreColumns->where('for_transcript',true)->toArray(),null,'id');
        //     }
        // }
        //dd($this->transcriptCoursesScores[0]['allScores'][0]);
        foreach($students as $student){
            $data['students'][$student->pivot->klass_student_id]=$student;
            foreach($this->courses as $course){
                $courseStudentId=$course->students->where('id',$student->id)->first()->pivot->course_student_id;
                foreach($course->scoreColumns as $column){
                    $score=$course->allScores->where('course_student_id',$courseStudentId)->where('score_column_id',$column->id)->first();
                    $data['scores'][$student->pivot->klass_student_id][$course->id][$column->id]=$score;
                }
            }
        }
        // dd($data['scores'][316][153][1051]);
        $data['behaviours']=$this->behaviourSummary()['sumTerms'];
        return $data;
     return [
        'students'=>$this->students,
        'behaviours'=>$this->behaviourSummary(),
        'courses'=>$this->courses,
        'scores'=>$this->coursesScores
    ];
     return $this->students;   
    }
    // public function outcomes(){
    //     return $this->hasManyThrough(Outcome::class, KlassStudent::class,'klass_id', 'klass_student_id')->with('student');
    // }
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
    public function finalScores(){
        //passing score with reference_code "passing" in transcript_templates
        $passing=$this->grade->passingScore();
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
        $data=[];
        $transcripts = [];
        $scoreColumns = [];
        foreach ($students as $student) {
            $data['students'][$student->pivot->klass_student_id]=$student;
            // $tmp = [
            //     'student_id' => $student->id,
            //     'student_name' => $student->name_zh,
            //     'klass_student_id' => $student->pivot->klass_student_id,
            //     'fail_units'=>0,
            // ];
            foreach ($courses as $course) {
                $scoreColumn = $course->scoreColumns->where('term_id', 9)->first();
                //$transcript[]['scores'][$scoreColumnId]=$tmpScores[$student->id][$course->id][$scoreColumnId];
                if (isset($tmpScores[$student->id][$course->id])) {
                    //$tmp['scores'][$scoreColumn->id] = $tmpScores[$student->id][$course->id][$scoreColumn->id];
                    $data['scores'][$student->pivot->klass_student_id][$scoreColumn->id]['score']=$tmpScores[$student->id][$course->id][$scoreColumn->id];
                    //count number of failed units
                    $data['scores'][$student->pivot->klass_student_id][$scoreColumn->id]['fail_units']=0;
                    if($tmpScores[$student->id][$course->id][$scoreColumn->id]<=$passing){
                        //$tmp['fail_units']++;
                        $data['scores'][$student->pivot->klass_student_id][$scoreColumn->id]['fail_units']++;
                    }
                } else { //if the student is not in the course
                    //$tmp['scores'][$scoreColumn->id] = '--';
                    $data['scores'][$student->pivot->klass_student_id][$scoreColumn->id]['score'] = '--';
                }
                $data['scores'][$student->pivot->klass_student_id][$scoreColumn->id]['makeups']=$course->studentsMakeups();
                $scoreColumn['course_code'] = $course->code;
                $scoreColumn['course_title'] = $course->title_zh;
                $scoreColumn['course_unit'] = $course->unit;
                $scoreColumn['makeups']=$course->studentsMakeups();
                // $scoreColumns[$scoreColumn->id] = $scoreColumn;
                $data['score_columns'][$scoreColumn->id]=$scoreColumn;
            }
            //$data['scores'][$student->pivot->klass_student_id]=$tmp['scores'];
            //$data['fail_units'][$student->pivot->klass_student_id]=$tmp['fail_units'];
            //$transcripts['students'][] = $tmp;
        }
        //$transcripts['score_columns']=$scoreColumns;
        
        return $data;
    }

    public function additives($category=null,$termId=null){
        $students=$this->students;
        if($category==null){
            $templates=AdditiveTemplate::all();
        }else{
            $templates=AdditiveTemplate::where('category',$category)->get();
        }
        
        $data=[];
        foreach($students as $student){
            $data['students'][$student->pivot->klass_student_id]['name_zh']=$student->name_zh;
            $data['students'][$student->pivot->klass_student_id]['klass_student_id']=$student->pivot->klass_student_id;
            foreach($templates as $template){
                $data['additives'][$student->pivot->klass_student_id][$template->reference_code]=null;
            }
            $additives=Additive::where('klass_student_id',$student->pivot->klass_student_id)
                                ->whereIn('reference_code',array_keys($data['additives'][$student->pivot->klass_student_id]))
                                ->get();
            $data['records'][$student->pivot->klass_student_id]=$additives;
            foreach($templates as $template){
                $data['additives'][$student->pivot->klass_student_id][$template->reference_code]=null;
            }
            foreach($additives as $additive){
                    //$data['students'][$student->pivot->klass_student_id]['additives'][$additive->reference_code]+=$additive->value;
                    $data['additives'][$student->pivot->klass_student_id][$additive->reference_code]+=$additive->value;
            }
        };
        //$templates=AdditiveTemplate::all()->toArray();
        $data['templates']=array_column($templates->toArray(),null,'reference_code'); 
        return $data;
    }
}