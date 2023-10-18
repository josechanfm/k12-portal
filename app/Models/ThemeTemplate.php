<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ThemeTemplate extends Model
{
    use HasFactory;
    protected $fillable=['grade_id','grade_year','term_id','sequence','title'];

    public function topicTemplates(){
        return $this->hasMany(TopicTemplate::class);
    }
}
