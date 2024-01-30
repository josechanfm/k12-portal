<?php

namespace App\Imports;

use App\Models\Ability;
use Maatwebsite\Excel\Concerns\ToModel;

class KlassAbilityImport implements ToModel
{
    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function model(array $row)
    {
        return new Ability([
            //
        ]);
    }
}
