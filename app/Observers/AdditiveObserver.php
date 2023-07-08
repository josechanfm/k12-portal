<?php

namespace App\Observers;

use App\Models\Additive;
use App\Models\Procedure;
use App\Models\Workflow;
use App\Models\Task;
use App\Models\User;
use App\Models\Klass;

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
        // dd(json_encode($template->procedure->processes));
        // $additive->workflow()->create([
        //     'processes'=>json_encode($template->procedure->processes)
        // ]);
        $workflow=new Workflow();
        $workflow->workflowable()->associate($additive);
        $workflow->processes=json_encode($template->procedure->processes);
        $workflow->save();
        
        if($template->procedure_id !=null){
            $procedure=Procedure::find($template->procedure_id);
            $processes=$procedure->processes;
            foreach($processes as $process){
                switch($process->user_role){
                    case 'DIRECTOR':
                        $users=User::role('director')->get();
                        break;
                    case 'KLASS_HEAD':
                        $klass=Klass::where('id',$additive->klassStudent->klass_id)->first();
                        $users=$klass->klass_heads;
                        break;
                    case 'SUBJECT_HEAD':
                        $klass=Klass::where('id',$additive->klassStudent->klass_id)->first();
                        $heads=$klass->courses->whereNotNull('subject_head_ids')->pluck('subject_heads');
                        $users=collect(); 
                        foreach($heads as $head){
                            $users=$users->concat($head);
                        }
                        break;
                }
                foreach($users as $user){
                    Task::create([
                        'workflow_id'=>$workflow->id,
                        'start_date'=>$additive->submit_at,
                        'due_date'=>null,
                        'user_role'=>null,
                        'user_id'=>$user->id,
                    ]);
                }
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
