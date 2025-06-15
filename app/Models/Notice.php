<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class Notice extends Model
{
    use HasFactory;

    public function messages(){
        return $this->hasMany(Message::class);
    }
}
