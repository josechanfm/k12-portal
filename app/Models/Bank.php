<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphTo;

class Bank extends Model
{
    use HasFactory;
    protected $fillable=['bank_name','account_name','account_number','currency'];

    public function bankable(){
        return $this->morphTo();
    }
}
