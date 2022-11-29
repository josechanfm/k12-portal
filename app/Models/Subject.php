<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Subject extends Model
{
    use HasFactory;
    protected $fillable = [
        'abbr', 'title_zh', 'title_en','type','description', 'active',
    ];

    public function klasses(){
        return $this->belongsTo(Klass::class);
    }
}
