<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphOne;
use App\Models\AdditiveTemplate;

class Additive extends Model
{
    use HasFactory;
    protected $fillable=['klass_student_id','reference_code','value','remark'];

    public function template(){
        return AdditiveTemplate::where('reference_code',$this->reference_code)->first();
    }
    public function klassStudent(){
        return $this->belongsTo(KlassStudent::class);
    }

    public function workflow(): MorphOne{
        return $this->morphOne(Workflow::class,'workflowable')->with('tasks');
    }

    public function approved($data=null){

    }
    public function reject($data=null){
        
    }
    public function rework($data=null){
        
    }
}
