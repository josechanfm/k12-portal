<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Extracurricular;
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
            ThemeTemplateSeeder::class,
            TopicTemplateSeeder::class,
            TranscriptTemplateSeeder::class,
            AdditiveTemplateSeeder::class,
            StudentSeeder::class,
            SubjectSeeder::class,
            StudySeeder::class,
            UserSeeder::class,
            StaffSeeder::class,
            TeacherSeeder::class,
            //SubjectTemplateSeeder::class,
            KlassSeeder::class,
            ThemeSeeder::class,
            //KlassStudentSeeder::class,
            //CourseSeeder::class,
            LocationSeeder::class,
            SupplierSeeder::class,
            //TranscriptSeeder::class,
            ScoreColumnSeeder::class,
            //ScoreSeeder::class,
            ProcedureSeeder::class,
            ExtracurricularSeeder::class,
        ]);
        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }
}
