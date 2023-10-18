<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TopicTemplate extends Model
{
    use HasFactory;
    protected $fillable=['theme_template_id','sequence','category_code','section_code','section','abbr','title','description'];

    public function themeTemplate(){
        return $this->belongsTo(ThemeTemplate::class);
    }

}
