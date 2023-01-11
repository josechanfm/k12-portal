<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Teacher extends Model
{
    use HasFactory;
    protected $appends=['name_zh','name_fn','staff_code'];

    public function getNameZhAttribute(){
        return Staff::find($this->staff_id)->name_zh;
    }
    public function getNameFnAttribute(){
        return Staff::find($this->staff_id)->name_fn;
    }
    public function getStaffCodeAttribute(){
        return Staff::find($this->staff_id)->code;
    }
    public function staff(){
        return $this->belongsTo(Staff::class);
    }
    public function courses(){
        return $this->belongsToMany(Course::class);
    }
}
