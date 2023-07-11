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
        $klassStudent=$additive->klassStudent;
        //dd($klassStudent->klass->tag.", ".$klassStudent->student->name_zh."(".$klassStudent->student_number.")");
        $template=$additive->template();
        
        // dd(json_encode($template->procedure->processes));
        // $additive->workflow()->create([
        //     'processes'=>json_encode($template->procedure->processes)
        // ]);
        $workflow=new Workflow();
        $workflow->workflowable()->associate($additive);
        $workflow->processes=$template->procedure->processes;
        $workflow->title_zh=$template->title_zh;
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
                        'description'=>$klassStudent->klass->tag.", ".$klassStudent->student->name_zh."(".$klassStudent->student_number.")",
                        'start_date'=>$additive->submit_at,
                        'due_date'=>null,
                        'user_role'=>$process->user_role,
                        'user_id'=>$user->id,
                        'state'=>0,
                        'actions'=>$template->procedure->actions
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
