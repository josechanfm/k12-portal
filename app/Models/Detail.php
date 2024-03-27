<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Detail extends Model
{
    use HasFactory;
    protected $fillable=['student_id','holy_name','baptized','first_communion','sibling','sibling_at_work
    ','previour_school','previour_grade','entry_date','entry_klass','stay_issue','stay_expire'];

    public function student()
    {
        return $this->belongsTo(Student::class);
    }
}
