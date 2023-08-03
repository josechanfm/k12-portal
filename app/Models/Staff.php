<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Staff extends Model
{
    use HasFactory;
    protected $appends=['username'];
    protected $table='staffs';
    
    public function getUsernameAttribute(){
        return User::find($this->user_id)->username??'';
    }
    public function user(){
        return $this->belongsto(User::class);
    }

    public function courses(){
        return $this->belongsToMany(Course::class)->with('klass');
    }

    public static function teachers(){
        return Staff::where('is_teacher', true)->get();
    }

}
