<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CourseScore extends Model
{
    use HasFactory;

    public function children(){
        return $this->hasMany(CourseScore::class,'parent_id','id')->select('id','parent_id','title','mark')->with('children');
    }
    public function parent()
    {
        return $this->belongsTo(CourseScore::class,'parent_id')->where('parent_id',0);
    }
    public static function tree($courseId){
        $allData=CourseScore::where('course_id',$courseId)->get();
        $rootData=$allData->whereNull('parent_id');
        self::formatTree($rootData, $allData);
        return $rootData;

    }
    public static function formatTree($root, $all){
        foreach($root as $r){
            $r->key=$r->id.'-'.$r->parent_id;
            $r->children=$all->where('parent_id',$r->id);
            if($r->children->isNotEmpty()){
                self::formatTree($r->children,$all);
            }
        }
    }
}
