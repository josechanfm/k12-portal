<?php

namespace App\Exports;

use App\Models\Habit;
use Maatwebsite\Excel\Concerns\FromCollection;

class KlassHabitExport implements FromCollection
{
    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        return Habit::all();
    }
}
