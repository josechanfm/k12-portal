<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Address extends Model
{
    use HasFactory;
    protected $fillable=['road','building','zone'];

    public function addressable(){
        return $this->morphTo();
    }
}
