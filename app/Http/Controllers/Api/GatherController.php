<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Config;
use App\Models\Year;
use App\Models\Klass;
use App\Models\Student;

class GatherController extends Controller
{
    public function gradesKlasses(Request $request){
        $year=Year::find(Year::currentYear()->id);
        $year->grades;
        $year->klasses;
        $year->yearTerms=Config::item('year_terms');
        $grade=$year->grades->where('grade_year',4)->first();
        $grade->klasses->first();
        return response()->json(['current_year'=>$year,'default_grade'=>$grade]);
    }

    public function klassStudents(Klass $klass){
        $klass->students;
        return response()->json($klass);
    }

    public function studentMedicalRecords(Student $student){
        $student->treatments;
        $student->healthcare;
        return response()->json($student);
    }
}
