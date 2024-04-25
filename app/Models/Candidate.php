<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Candidate extends Model
{
    use HasFactory;
    protected $fillable=[
        'name_zh',
        'name_fn',
        'name_display',
        'gender',
        'dob',
        'pob',
        'pob_other',
        'nationality',
        'native',
        'religion',
        'id_num',
        'id_type',
        'id_type_other',
        'id_issue',
        'id_expired',
        'hrc_num',
        'hrc_issue',
        'hrc_expired',
        'dsedj_num',
        'ssm_num',
        'previour_school',
        'previour_grade',
        'start_grade',
        'start_klass',
        'phone',
        'phone_home',
        'confirmed'
    ];

    

}
