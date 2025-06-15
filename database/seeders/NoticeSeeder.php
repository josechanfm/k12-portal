<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Notice;

class NoticeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Notice::create([
            'category'=>'INFO',
            'title'=>'Information S1',
            'content'=>'Content of Information S1',
        ]);
        Notice::create([
            'category'=>'INFO',
            'title'=>'Information G1',
            'content'=>'Content of Information G1',
        ]);
    }
}
