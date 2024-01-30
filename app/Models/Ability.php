<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ability extends Model
{
    use \Znck\Eloquent\Traits\BelongsToThrough;
    use HasFactory;
    protected $fillable=['klass_student_id','term_id','topic_id','credit','remark'];

    public function student(){
        return $this->hasOneThrough(Student::class, KlassStudent::class,'id','id');
    }

    public function topic(){
        return $this->belongsTo(Topic::class);
    }

    public function klass(){
        return $this->belongsToThrough(
            Klass::class,
            KlassStudent::class
        );
    }

}
