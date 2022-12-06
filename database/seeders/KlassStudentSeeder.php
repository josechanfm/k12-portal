<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Klass;
use App\Models\Grade;

class KlassStudentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $yearId=1;
        $studentId=1;
        $grades=Grade::where('year_id',$yearId)->get();
        foreach ($grades as $grade) {
            $klasses=Klass::where('grade_id',$grade->id)->get();
            foreach ($klasses as $klass) {
                for($i=1;$i<=21;$i++){
                    DB::table('klass_students')->insert([
                        'klass_id' => $klass->id,
                        'student_id' => $studentId++,
                        'student_number'=>$i
                    ]);
                }
            }
        }
    }
}
