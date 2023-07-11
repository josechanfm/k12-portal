<?php

namespace App\Observers;

use App\Models\Task;

class TaskObserver
{
    /**
     * Handle the Task "created" event.
     *
     * @param  \App\Models\Task  $task
     * @return void
     */
    public function created(Task $task)
    {
        //
    }

    /**
     * Handle the Task "updated" event.
     *
     * @param  \App\Models\Task  $task
     * @return void
     */
    public function updated(Task $task)
    {
        $processes=$task->workflow->processes;

        foreach($processes as $process){
            $taskCount=Task::where('workflow_id',$task->workflow_id)->where('user_role',$process['user_role'])->whereNotNull('status')->get()->count();
            if($taskCount>=$process['approved_count']){
                $task->workflow->state=9;
                Task::where('workflow_id',$task->workflow_id)->where('user_role',$process['user_role'])->update(['state'=>9]);
            }
        }
    }

    /**
     * Handle the Task "deleted" event.
     *
     * @param  \App\Models\Task  $task
     * @return void
     */
    public function deleted(Task $task)
    {
        //
    }

    /**
     * Handle the Task "restored" event.
     *
     * @param  \App\Models\Task  $task
     * @return void
     */
    public function restored(Task $task)
    {
        //
    }

    /**
     * Handle the Task "force deleted" event.
     *
     * @param  \App\Models\Task  $task
     * @return void
     */
    public function forceDeleted(Task $task)
    {
        //
    }
}
