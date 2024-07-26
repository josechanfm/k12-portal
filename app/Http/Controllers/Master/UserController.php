<?php

namespace App\Http\Controllers\Master;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use App\Models\User;
use Illuminate\Support\Facades\Hash;


class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        $users=User::with('roles')->with('permissions')->get();
        $roles=Role::all();
        $permissions=Permission::all();
        return Inertia::render('Master/Users',[
            'users' => $users,
            'roles'=>$roles,
            'permissions'=>$permissions
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $userData=$request->validate(
            [
            'newRoles'=>'required|Array',
            'name'=>'required',
            'password'=>'required',
            'email'=>'required',

            ]
        );
        $newUser=[
          'email'=>  $userData['email'],
          'username'=>  $userData['email'],
          'name'=>  $userData['name'],
          'password'=>   Hash::make($userData['password'])

        ];
        $user= User::create( $newUser);
       $user->syncRoles($userData['newRoles']);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, User $id)
    {  
        $userData=$request->validate(
            ['id'=>'required',
            'newRoles'=>'required|Array',
            'name'=>'required',
            'newPassword'=>'sometimes|min:6',
            ]
        );
       $updateData=['name'=>$userData['name']];
       if(isset($updateData['newPassword'])){
            $updateData['password']=Hash::make($updateData['newPassword']);
       }
       $user=User::find($userData['id']);
       $user->update($updateData);
       $user->syncRoles($userData['newRoles']);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
   
}
