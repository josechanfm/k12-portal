<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;
use Spatie\MediaLibrary\MediaCollections\Models\Media;
use Spatie\Image\Manipulations;
use Illuminate\Support\Str;
use Illuminate\Database\Eloquent\Relations\MorphMany;

class Student extends Model implements HasMedia
{
    use HasFactory;
    use InteractsWithMedia;
    protected $hidden = ['created_at','updated_at'];
    protected $fillable=['suid','name_zh','name_fn','name_display','gender','dob','pob','pob_other','nationality','native','religion',
    'sid','id_num','id_type','id_type_other','id_issue','id_expired','hrc_num','hrc_issue','hrc_expired','dsedj_num','ssm_num',
    'entry_date','previour_school','previour_grade','start_klass',
    'phone','phone_sms','phone_home'
    ];

    public static function boot(){
        parent::boot();
        self::creating(function($model){
            $model->suid=Str::uuid();
        });
        static::created(function($model){
            $num=substr('00000'.$model->id,-5);
            $model->suid=Config::item('suid_prefix').$num.'-'.$model->checkDigit($num);
            $model->save();
        });
    }
    private function checkDigit($num){
        $odd=(($num[0]+9)+($num[2]+8)+($num[4]+7)) % 11;
        $even=(($num[1]+6)*($num[3]+5)*($odd+4)) % 11;
        return ($odd+$even) % 10;
    }

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
                'klass_student_id'=>$ks->id,
                'avatar'=>$ks->getMedia('avatar')->first(),
            ];
        }
        return $avatars;
    }

    public function user(){
        return $this->belongsTo(User::class);
    }

    public function messages(): MorphMany{
        return $this->morphMany(Message::class, 'messageable');
    }
    public function guardians(){
        return $this->belongsToMany(Guardian::class);
    }
    public function courses(){
        return $this->hasMany(Course::class);
    }

}
