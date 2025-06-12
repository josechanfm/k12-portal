<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Guardian;
use App\Models\Student;

class GuardianSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $sid=1;
        for ($i = 15; $i <= 25; $i++) {
            $guardian=Guardian::factory()->create([
                'user_id' => $i, 
            ]);
            $student=Student::find($sid++);
            $guardian->students()->attach($student,['relationship'=>'guardian']);

        }

    }
}
