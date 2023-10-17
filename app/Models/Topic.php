<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Topic extends Model
{
    use HasFactory;
    protected $fillable=['theme_id','sequence','category_code','section_code','section','abbr','title','description'];

    public function theme(){
        return $this->belongsTo(Theme::class);
    }
}
