<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Student;
use App\Models\Guardian;

class messageseeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        for ($i = 1; $i <= 10; $i++) {
            $student=Student::find($i);
            $student->messages()->create([
                'notice_id'=>1,
                'category'=>'INFO',
                'title'=>'Information S'.$i,
                'content'=>'Content of Information S'.$i,
            ]);
        }

        for ($i = 1; $i <= 10; $i++) {
            $guardian=Guardian::find($i);
            $guardian->messages()->create([
                'notice_id'=>2,
                'category'=>'INFO',
                'title'=>'Information G'.$i,
                'content'=>'Content of Information G'.$i,
            ]);
        }

    }
}
