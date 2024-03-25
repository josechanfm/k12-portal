<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Guardian extends Model
{
    use HasFactory;

    public function students()
    {
        return $this->belongsToMany(Student::class);
    }

    public function user(){
        $this->belongsTo(User::class);
    }

}
