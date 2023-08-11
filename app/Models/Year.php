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
    public static function nextYear($yearId){
        $year=Year::find($yearId);
        return Year::where('start','>',$year->start)->orderBy('start','ASC')->first();
    }
    public static function currentYear(){
        return Year::where('active',1)->orderBy('start','DESC')->first();
    }
    public function courses(){
        return $this->hasManyThrough(Course::class, Klass::class);
    }
    public function students(){
        return $this->hasManyDeepFromRelations($this->klasses(),(new Klass())->students());
    }

    
}
