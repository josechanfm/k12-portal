<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphOne;
use App\Models\AdditiveTemplate;

class Additive extends Model
{
    use HasFactory;
    protected $fillable=['klass_student_id','reference_code','value','confirmed','user_id','remark'];
    protected $appends=['assign_user'];

    public function getAssignUserAttribute(){
        return User::find($this->user_id)->name;
    }
    public function template(){
        return AdditiveTemplate::where('reference_code',$this->reference_code)->first();
    }
    public function klassStudent(){
        return $this->belongsTo(KlassStudent::class,'klass_student_id')->with('student')->with('klass');
    }

    public function workflow(): MorphOne{
        return $this->morphOne(Workflow::class,'workflowable')->with('tasks');
    }

    public function approved($data=null){
        $this->approved=true;
        if(isset($data['remark'])){
            $this->remark=$data['remark'];
        }
        $this->save();
        return true;
    }
    public function rejected($data=null){
        $this->approved=false;
        if(isset($data['remark'])){
            $this->remark=$data['remark'];
        }
        $this->save();
        return true;
    }
    public function reworked($data=null){
        $this->approved=false;
        if(isset($data['remark'])){
            $this->remark=$data['remark'];
        }
        $this->save();
        return true;
    }
}
