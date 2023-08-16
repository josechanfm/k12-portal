<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Certificate extends Model
{
    use HasFactory;
    protected $casts=['certificate_meta'=>'json'];

    public function student(){
        return $this->belongsTo(Student::class);
    }
}
