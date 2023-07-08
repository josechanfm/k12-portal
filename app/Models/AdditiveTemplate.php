<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AdditiveTemplate extends Model
{
    use HasFactory;

    public function procedure(){
        return $this->belongsTo(Procedure::class);
    }
}
