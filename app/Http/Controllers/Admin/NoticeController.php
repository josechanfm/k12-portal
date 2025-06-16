<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Notice;
use App\Models\Config;

use App\Models\User;
use App\Notifications\UserActionNotification;

class NoticeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // $user = User::find(1); // Replace $userId with the actual user ID
        // // Send the notification
        // $user->notify(new UserActionNotification('User created a new post'));
        //$user->notify(new UserActionNotification('User created a new post', ['mail', 'sms']));
        return Inertia::render('Admin/Notices',[
            'notices'=>Notice::orderBy('created_at','desc')->paginate(),
            'categories'=>Config::item('notice_categories')
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(Notice $notice)
    {
        return Inertia::render('Admin/NoticeDistribution', [
            'notice' => $notice,
            'klasses'=>Config::item('year_klasses'),
            'categories'=>Config::item('notice_categories')
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }

    public function distribute(Request $request){
        dd($request->all(), in_array('ALL_GUARDIAN',$request->recipients), in_array('ALL_STUDENT',$request->recipients), in_array('ALL_STUDENT_GUARDIAN',$request->recipients));
        dd($request->all());
    }
}
