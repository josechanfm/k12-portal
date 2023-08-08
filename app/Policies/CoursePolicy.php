<?php

namespace App\Policies;

use App\Models\Course;
use App\Models\User;
use App\Models\Staff;
use Illuminate\Auth\Access\HandlesAuthorization;

class CoursePolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any models.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Auth\Access\Response|bool
     */
    public function viewAny(User $user)
    {
        //
    }

    /**
     * Determine whether the user can view the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Course  $course
     * @return \Illuminate\Auth\Access\Response|bool
     */
    public function view(User $user, Course $course)
    {
        if(auth()->user()->hasRole('master') || auth()->user()->hasRole('admin')){
            return true;
        }
        dd($course->staffs);
    }

    /**
     * Determine whether the user can create models.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Auth\Access\Response|bool
     */
    public function create(User $user)
    {
        //
    }

    /**
     * Determine whether the user can update the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Course  $course
     * @return \Illuminate\Auth\Access\Response|bool
     */
    public function update(User $user, Course $course)
    {
        //
    }

    /**
     * Determine whether the user can delete the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Course  $course
     * @return \Illuminate\Auth\Access\Response|bool
     */
    public function delete(User $user, Course $course)
    {
        //
    }

    /**
     * Determine whether the user can restore the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Course  $course
     * @return \Illuminate\Auth\Access\Response|bool
     */
    public function restore(User $user, Course $course)
    {
        //
    }

    /**
     * Determine whether the user can permanently delete the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\Course  $course
     * @return \Illuminate\Auth\Access\Response|bool
     */
    public function forceDelete(User $user, Course $course)
    {
        //
    }

    public function scores(User $user, Course $course)
    {
        if(auth()->user()->hasRole('master') || auth()->user()->hasRole('admin')){
            return true;
        }
        $staffId=auth()->user()->staff()->id;
        if(in_array($staffId,$course->subject_head_ids)){
            return true;
        }
        if(in_array($staffId,$course->staffs->pluck('id')->toArray())){
            return true;
        }
        if(in_array($staffId,$course->klass->klass_head_ids)){
            return true;
        }
        return false;
    }

}
