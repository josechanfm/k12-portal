<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Medicnote extends Model
{
    use HasFactory;
    protected $fillable=['student_id','hospital','health_state','vaccinated','last_vaccine','vaccine_count','covid_19','illness','trauma','trauma_treatment','food_allergy','medicine_allergy'];

    public function student()
    {
        return $this->belongsTo(Student::class);
    }   
}
