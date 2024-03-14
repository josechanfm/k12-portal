<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TopicTemplate extends Model
{
    use HasFactory;
    protected $fillable=['theme_template_id','sequence','section_code','section','abbr','title','description'];
    protected $appends=['section_code_label'];

    public function getSectionCodeLabelAttribute(){
        $sections=array_column(Config::item('topic_sections'),'label','value');
        return $sections[$this->section_code]??null;
    }
    public function themeTemplate(){
        return $this->belongsTo(ThemeTemplate::class);
    }

}
