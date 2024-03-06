<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class Archive extends Model
{
    use HasFactory;
    protected $fillable=['archivable_id','archivable_type','file_type','year_id','term_id','original_name','file_name','file_path','full_path'];

    public function archivable(){
        return $this->morphTo();
    }
}
