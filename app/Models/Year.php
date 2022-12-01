<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Year extends Model
{
    use HasFactory;
    use \Staudenmeir\EloquentHasManyDeep\HasRelationships;
    protected $fillable=['abbr','title','description','meta','start','end'];


    public function courses(){
        return $this->hasManyThrough(Course::class, Klass::class);
    }
    public function students(){
        return $this->hasManyThrough(Klassmate::class, Klass::class);
    }

    
}
