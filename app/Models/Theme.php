<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Theme extends Model
{
    use HasFactory;
    protected $appends= ['topic_count'];
    
    public function getTopicCountAttribute(){
        return Topic::where('theme_id',$this->id)->count();
    }
    
    public function grade(){
        return $this->belongsTo(Garde::class);
    }

    public function topics(){
        return $this->hasMany(Topic::class);
    }
}
