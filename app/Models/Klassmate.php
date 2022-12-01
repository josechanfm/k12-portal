<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Klassmate extends Model
{
    use HasFactory;
    //protected $table = 'klassmates';
    protected $fillable = ['klass_student_id','point'];

    public function scores(){
        return $this->hasMany(Score::class);
    }
    public function students(){
        
    }
}
