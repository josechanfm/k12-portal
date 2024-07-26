<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Topic extends Model
{
    use HasFactory;
    protected $fillable=['theme_id','sequence','ability_code','ability','abbr','title','description'];

    public function theme(){
        return $this->belongsTo(Theme::class);
    }
    public function abilities(){
        return $this->hasMany(Ability::class);
    }
}
