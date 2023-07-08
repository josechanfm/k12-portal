<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class Workflow extends Model
{
    use HasFactory;
    protected $fillable=['processes'];

    public function workflowable() : MorphTo {
        return $this->morphTo();
    }

    public function tasks(){
        return $this->hasMany(Task::class);
    }
}
