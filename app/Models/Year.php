<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Year extends Model
{
    use HasFactory;
    use \Staudenmeir\EloquentHasManyDeep\HasRelationships;

    protected $fillable=['abbr','title','description','meta','start','end'];
    protected $appends=['grade_group'];
    
    public function getGradeGroupAttribute(){
        return Grade::where('year_id',$this->id)->groupBy('initial')->select('initial',DB::raw("count(*) as count"))->get();
    }
    public function grades(){
        return $this->hasMany(Grade::class);
    }
    public function klasses(){
        return $this->hasManyThrough(Klass::class, Grade::class);
    }

    public function courses(){
        return $this->hasManyThrough(Course::class, Klass::class);
    }
    public function students(){
        return $this->hasManyThrough(Klassmate::class, Klass::class);
    }

    
}
