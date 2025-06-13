<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Form;
use App\Models\Entry;
use Illuminate\Support\Str;

class FormSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $form=Form::create([
            'uuid'=>Str::uuid(),
            'name'=>'first form',
            'title'=>'First form of title',
            'for_whom'=>'["public"]'
        ]);
        $form->fields()->create([
            'sequence'=>1,
            'field_name'=>'username',
            'field_label'=>'Username',
            'type'=>'input'
        ]);
        $form->fields()->create([
            'sequence'=>2,
            'field_name'=>'gender',
            'field_label'=>'Gender',
            'type'=>'radio',
            'options'=>json_decode('[{"value":"M","label":"Male"},{"value":"F","label":"Female"}]')
        ]);
        $form->fields()->create([
            'sequence'=>3,
            'field_name'=>'dob',
            'field_label'=>'DOB',
            'type'=>'date',
        ]);
        $form->fields()->create([
            'sequence'=>4,
            'field_name'=>'education',
            'field_label'=>'Education',
            'type'=>'select',
            'options'=>json_decode('[{"value":"B","label":"Bachalor"},{"value":"M","label":"Master"},{"value":"D","label":"PhD."}]')
        ]);
        $form->fields()->create([
            'sequence'=>5,
            'field_name'=>'email',
            'field_label'=>'Email',
            'type'=>'email'
        ]);
        $form->fields()->create([
            'sequence'=>6,
            'field_name'=>'remark',
            'field_label'=>'Remark',
            'type'=>'textarea'
        ]);


        $form=Form::create([
            'uuid'=>Str::uuid(),
            'name'=>'second form',
            'title'=>'Second form of title',
            'published'=>true,
            'for_whom'=>'["student"]'
        ]);

        $form->fields()->create([
            'sequence'=>1,
            'field_name'=>'username',
            'field_label'=>'Username',
            'type'=>'input',
        ]);

        $form=Form::create([
            'uuid'=>Str::uuid(),
            'name'=>'（活動報名）慶祝六一兒童節填色比賽',
            'title'=>'（活動報名）慶祝六一兒童節填色比賽',
            'description'=>'<p><span style="color: rgb(5, 5, 5);">澳門公務人員聯合總會青年委員會及行政公職局聯合舉辦『慶祝六一兒童節填色比賽』。優勝者將有豐富的獎賞及獎狀。每位參賽者交稿時可獲紀念品一份，歡迎本澳公務人員就讀幼稚園/小學之子女參加。</span></p>',
            'published'=>true,
            'for_whom'=>'["guardian"]'
        ]);

        $form->fields()->create([
            'sequence'=>1,
            'field_name'=>'姓名',
            'field_label'=>'姓名',
            'options'=>NULL,
            'direction'=>'V',
            'in_column'=>'1',
            'type'=>'input',
        ]);
        $form->fields()->create([
            'sequence'=>2,
            'field_name'=>'性別',
            'field_label'=>'性別',
            'options'=>json_decode('[{"value":"M","label":"\u7537"},{"value":"F","label":"\u5973"}]'),
            'direction'=>'V',
            'in_column'=>'1',
            'type'=>'radio',
        ]);
        $form->fields()->create([
            'sequence'=>3,
            'field_name'=>'聯繫電話',
            'field_label'=>'聯繫電話',
            'options'=>NULL,
            'direction'=>'V',
            'in_column'=>'1',
            'type'=>'input',
        ]);
        $form->fields()->create([
            'sequence'=>4,
            'field_name'=>'屬會',
            'field_label'=>'屬會',
            'options'=>NULL,
            'direction'=>'V',
            'in_column'=>'0',
            'type'=>'input',
        ]);

        $entry=Entry::create([
            'form_id'=>$form->id,
            'user_id'=>4
        ]);
        foreach($form->fields as $field){
            $entry->records()->create([
                'form_field_id'=>$field->id,
                'field_value'=>'**'.$field->field_label.'**',
            ]);
    
        }

    }
}
