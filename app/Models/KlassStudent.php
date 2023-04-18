<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KlassStudent extends Model
{
    use HasFactory;
    protected $table='klass_student';
    protected $fillable=['promote_to'];

    public function student(){
        return $this->belongsTo(Student::class);
    }

    public function behaviours(){
        return $this->hasMany(Behaviour::class);
    }
    public function klass(){
        return $this->belongsTo(Klass::class);
    }
   

}
