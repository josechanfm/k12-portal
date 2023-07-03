<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Klass;
use App\Models\Grade;
use App\Models\Year;
use App\Models\KlassStudent;

class KlassStudentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $year=Year::currentYear();
        $studentId=1;
        $grades=Grade::where('year_id',$year->id)->get();
        foreach ($grades as $grade) {
            // echo json_encode($grade);
            $klasses=Klass::where('grade_id',$grade->id)->get();
            // echo json_encode($klasses);
            foreach ($klasses as $klass) {
                for($i=1;$i<=21;$i++){
                    DB::table('klass_student')->insert([
                        'klass_id' => $klass->id,
                        'student_id' => $studentId++,
                        'student_number'=>$i
                    ]);
                }
            }
        }
    }
}
