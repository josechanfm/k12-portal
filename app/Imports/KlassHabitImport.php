<?php

namespace App\Imports;

use App\Models\Habit;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithStartRow;
class KlassHabitImport implements ToModel, WithStartRow 
{
    protected $klass;

    function __construct($klass)
    {
        $this->klass = $klass;
    }
        /**
     * @return int
     */
    public function startRow(): int
    {
        return 2;
    }
    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function model(array $row)
    {
        $habit=Habit::find(intval($row[0]));
        if($habit){
            //$habit->klass_student_id=$row[0];
            //$habit->term_id=$row[1];
            // $habit->student_number=$row[2];
            // $habit->student_name=$row[3];
            $habit->health_1=$row[4];
            $habit->health_2=$row[5];
            $habit->health_3=$row[6];
            $habit->health_4=$row[7];
            $habit->health_5=$row[8];
            $habit->behaviour_1=$row[9];
            $habit->behaviour_2=$row[10];
            $habit->behaviour_3=$row[11];
            $habit->behaviour_4=$row[12];
            $habit->behaviour_5=$row[13];
            $habit->behaviour_6=$row[14];
            $habit->social_1=$row[15];
            $habit->social_2=$row[16];
            $habit->social_3=$row[17];
            $habit->social_4=$row[18];
            $habit->social_5=$row[19];
            $habit->save();
            return $habit;
        }else{
            return null;
        };

    }
}
