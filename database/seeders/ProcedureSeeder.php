<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProcedureSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('procedures')->insert([
            'title_zh'=>'Attendance',
            'processes'=>'
                [{
                    "user_role": "DIRECTOR",
                    "user_id": null,
                    "period": null,
                    "approved_count": 1
                }, {
                    "user_role": "SUBJECT_HEAD",
                    "user_id": null,
                    "period": null,
                    "approved_count": 1
                }]'
        ]);

    }
}
