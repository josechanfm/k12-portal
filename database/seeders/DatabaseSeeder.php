<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Extracurricular;
use App\Models\Manual;
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
            UserSeeder::class,
            StudentSeeder::class,
            GuardianSeeder::class,
            NoticeSeeder::class,
            CourseSeeder::class,
        ]);

    }
}
