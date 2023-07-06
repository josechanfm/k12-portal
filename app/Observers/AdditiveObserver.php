<?php

namespace App\Observers;

use App\Models\Additive;
use App\Models\Procedure;
use App\Models\Workflow;
use App\Models\Task;

class AdditiveObserver
{
    /**
     * Handle the Additive "created" event.
     *
     * @param  \App\Models\Additive  $additive
     * @return void
     */
    public function created(Additive $additive)
    {
        $template=$additive->template();
        if($template->procedure_id !=null){
            $procedure=Procedure::find($template->procedure_id);
            $tasks=json_decode($procedure->tasks,false);
            $workflow=Workflow::create([
                    'model'=>class_basename($additive),
                    'model_id'=>$additive->id
                ]);
            foreach($tasks as $task){
                Task::create([
                    'workflow_id'=>$workflow->id,
                    'start_date'=>$additive->submit_at,
                    'due_date'=>null,
                    'user_role'=>$task->user_role,
                    'user_id'=>$task->user_id,
                ]);
            }
        }
        
    }

    /**
     * Handle the Additive "updated" event.
     *
     * @param  \App\Models\Additive  $additive
     * @return void
     */
    public function updated(Additive $additive)
    {
        //
    }

    /**
     * Handle the Additive "deleted" event.
     *
     * @param  \App\Models\Additive  $additive
     * @return void
     */
    public function deleted(Additive $additive)
    {
        //
    }

    /**
     * Handle the Additive "restored" event.
     *
     * @param  \App\Models\Additive  $additive
     * @return void
     */
    public function restored(Additive $additive)
    {
        //
    }

    /**
     * Handle the Additive "force deleted" event.
     *
     * @param  \App\Models\Additive  $additive
     * @return void
     */
    public function forceDeleted(Additive $additive)
    {
        //
    }
}
