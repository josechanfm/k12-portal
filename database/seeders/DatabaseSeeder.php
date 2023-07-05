<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Subject;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call([
            ConfigSeeder::class,
            YearSeeder::class,
            ThemeSeeder::class,
            StudentSeeder::class,
            SubjectSeeder::class,
            StudySeeder::class,
            //SubjectTemplateSeeder::class,
            CategorySeeder::class,
            KlassSeeder::class,
            //KlassStudentSeeder::class,
            //CourseSeeder::class,
            StaffSeeder::class,
            TeacherSeeder::class,
            LocationSeeder::class,
            SupplierSeeder::class,
            UserSeeder::class,
            TranscriptTemplateSeeder::class,
            //TranscriptSeeder::class,
            ScoreColumnSeeder::class,
            //ScoreSeeder::class,
        ]);
        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }
}
