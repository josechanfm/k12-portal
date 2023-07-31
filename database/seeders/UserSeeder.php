<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use App\Models\User;
use App\Models\Team;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $masterRole=Role::create(['name'=>'master']);
        $adminRole=Role::create(['name'=>'admin']);
        $directoRole=Role::create(['name'=>'director']);
        $klassHeadRole=Role::create(['name'=>'klass_head']);
        $subjectHeadRole=Role::create(['name'=>'subject_head']);
        $teacherRole=Role::create(['name'=>'teacher']);
        $assistantRole=Role::create(['name'=>'assistant']);

        $user=User::create([
            'username'=>'master',
            'name' => 'Master',
            'email' => 'master@example.com',
            'password' => Hash::make('password'),
        ]);
        $user->assignRole('master');
        $user->ownedTeams()->save(Team::forceCreate([
            'user_id' => $user->id,
            'name' => explode(' ', $user->name, 2)[0]."'s Team",
            'personal_team' => true,
        ]));

        $user=User::create([
            'username'=>'admin',
            'name' => 'Admin',
            'email' => 'admin@example.com',
            'password' => Hash::make('password'),
        ]);
        $user->assignRole('admin');
        $user->ownedTeams()->save(Team::forceCreate([
            'user_id' => $user->id,
            'name' => explode(' ', $user->name, 2)[0]."'s Team",
            'personal_team' => true,
        ]));

        $user=User::create([
            'username' => 'teacher',
            'name' => 'Teacher',
            'email' => 'teacher@example.com',
            'password' => Hash::make('password'),
        ]);
        $user->assignRole('teacher');
        $user->ownedTeams()->save(Team::forceCreate([
            'user_id' => $user->id,
            'name' => explode(' ', $user->name, 2)[0]."'s Team",
            'personal_team' => true,
        ]));

        User::factory()->count(100)->create();

        User::whereNull('username')->update(['username'=>DB::raw("concat('user',id)")]);

    }
}
