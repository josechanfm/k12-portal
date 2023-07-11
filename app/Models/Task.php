<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphTo;

use App\Models\User;
use App\Models\Workflow;

class Task extends Model
{
    use HasFactory;
    protected $fillable=['workflow_id','description','start_date','due_date','user_role','user_id','actions','comments','status','state'];
    protected $casts=['actions'=>'object'];

    public function user(){
        return $this->belongsTo(User::class);
    }
    public function workflow(){
        return $this->belongsTo(Workflow::class);
    }
}
