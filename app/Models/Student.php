<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;
use Spatie\MediaLibrary\MediaCollections\Models\Media;
use Spatie\Image\Manipulations;

class Student extends Model implements HasMedia
{
    use HasFactory;
    use InteractsWithMedia;
    
    protected $fillable=['name_zh','name_fn','name_display','gender','dob','pob','pob_other','nationality','native','religion',
    'sid','id_num','id_type','id_type_other','id_issue','id_expired','hrc_num','hrc_issue','hrc_expired','dsedj_num','ssm_num',
    'entry_date','previour_school','previour_grade','start_klass',
    'phone','phone_sms','phone_home'
    ];

    /*
    public static function boot(){
        parent::boot();
        self::created(function($model){
            $model->relatives->create([
                'relation'=>'1Father',
                'kinship'=>'Father',
            ]);
            $model->relatives->create([
                'relation'=>'0MONTHER',
                'kinship'=>'Mother',
            ]);
        });
    }
    */
    public function registerMediaConversions(Media $media = null): void
    {
        $this
            ->addMediaConversion('preview')
            ->fit(Manipulations::FIT_CROP, 300, 300)
            ->nonQueued();
    }
    public function registerMediaCollections(): void
    {
        $this->addMediaCollection('avatar')
            ->singleFile()
            ->useDisk('profile');
        $this->addMediaCollection('transcript')
            ->singleFile()
            ->useDisk('profile');
    }
    public function avatars(){
        $klassStudents=KlassStudent::where('student_id',$this->id)->orderBy('id','DESC')->get();
        $avatars=[];
        foreach($klassStudents as $i=>$ks){
            $avatars[]=[
                'full_tag'=>$ks->klass->tag.substr('00'.$ks->student_number,-2),
                'student_name'=>$ks->student->name_zh,
                'student_number'=>$ks->student_number,
                'image'=>$ks->getMedia('avatar')->first(),
            ];
        }
        return $avatars;
    }
    public function treatments(){
        return $this->hasMany(Treatment::class);
    }
    public function klasses(){
        return $this->belongsToMany(Klass::class)->withPivot('student_number')->orderBy('klass_student.created_at','DESC');
    }
    public function klassStudents(){
        return $this->hasMany(KlassStudent::class);
    }
    public function klassStudentWithAvatar(){
        $klassStudent=$this->hasOne(KlassStudent::class);
        dd($klassStudent->getMedia('avatar')->first());
        return $klassStudent->getMedia('avatar')->first();
    }
    public function courses(){
        return $this->belongsToMany(Course::class,'course_student');
    }
    public function coursesScores(){
        return $this->belongsToMany(Course::class,'course_students')->with('scores');
    }
    public function address(){
        return $this->morphOne(Address::class, 'addressable');
    }
    public function detail(){
        return $this->hasOne(Detail::class);
    }
    public function health(){
        return $this->hasOne(Health::class);
    }
    public function identity_documents(){
        $documents=$this->morphMany(IdentityDocument::class, 'identity_documentable')->get()->toArray();
        return array_column($documents,null,'document_type');
    }
    public function identity_document(){
        return $this->morphOne(IdentityDocument::class, 'identity_documentable')->latestOfMany();
    }
    public function bank(){
        return $this->morphOne(Bank::class, 'bankable');
    }
    public function parents()
    {
        return $this->hasMany(Relative::class)->whereIn('relation',['1FATHER','0MOTHER'])->orderBy('relation','DESC');
    }
    public function relatives(){
        return $this->hasMany(Relative::class)->orderBy('relation','DESC');
    }
    public function guardians()
    {
        return $this->belongsToMany(Guardian::class);
    }

    public function guardiansWithRelatives()
    {
        return $this->belongsToMany(Guardian::class)->with('students')->withPivot('relationship');
    }
    
    // public function guardian()
    // {
    //     return $this->hasOne(Guardian::class)->latestOfMany();
    // }
    public function medicnote(){
        return $this->hasOne(Medicnote::class);
    }
    public function abilities(){
        return $this->hasManyThrough(Ability::class, KlassStudent::class, 'student_id','klass_student_id')->with('topic');
    }
    public function archives(){
        $klassStudent=$this->hasOne(KlassStudent::class)->first();
        return $klassStudent->archives;
    }
    public function activities(){
        return $this->belongsToMany(Student::class);
    }
    public function klassStudent(){
        return $this->hasOne(KlassStudent::class)->latestOfMany();
    }
    public static function getBehaviours($klassStudentId, $staff, $terms, $referenceId,$actor='SUBJECT'){
        $behaviours=[];
        foreach($terms as $term){
            if($staff==null){ //if director
                $tmp=Behaviour::where('klass_student_id',$klassStudentId)
                ->where('term_id',$term->value)
                ->where('actor',$actor)->first();
                if(empty($tmp)){
                    // dd('is empty'.$klassStudentId.$term->value);
                    $tmp=Behaviour::make([
                        'klass_student_id'=>$klassStudentId,
                        'staff_id'=>null,
                        'term_id'=>$term->value,
                        'reference_id'=>$referenceId,
                        'actor'=>$actor,
                        'score'=>null
                    ]);
                }
            }else{ //include course teachers and klass head teachers
                $tmp=Behaviour::where('klass_student_id',$klassStudentId)
                ->where('staff_id',$staff->id)
                ->where('term_id',$term->value)
                ->where('actor',$actor)->first();
                if(empty($tmp)){
                    // dd('is empty'.$klassStudentId.$term->value);
                    $tmp=Behaviour::make([
                        'klass_student_id'=>$klassStudentId,
                        'staff_id'=>$staff->id,
                        'term_id'=>$term->value,
                        'reference_id'=>$referenceId,
                        'actor'=>$actor,
                        'score'=>null
                    ]);
                }
    
            }
            $behaviours[$term->value]=$tmp;
        }
        return $behaviours;
    }

    public function siblings(){
        if($this->sibling_uuid){
            return Student::where('sibling_uuid',$this->sibling_uuid)->with('guardians')->with('klasses')->get();
        }
        return null;
        
    }

    public function newStudents(){
        return $this->klasses->count();
    }
}
