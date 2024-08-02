<template>
    <AdminLayout :title="course?'科目操行':'班別操行'">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Teacher Dashboard
            </h2>
        </template>
        <div>
            <p>The collection of route "teacher" is for the general operation management such as serach and preview, which
                not included setup of year, class or subject etc.</p>
            <a-typography-title :level="4">{{ staff.name_zh }}</a-typography-title>
            <div v-if="course">
                <div>學段狀態: {{ showCurrentTerm() }}</div>
                <p>{{course.klass.tag}}</p>
                <p>{{course.code}}-{{course.title_zh}}</p>
                <BehaviourTable :yearTerms="yearTerms" :currentTermId="course.current_term" :behaviours="behaviours"/>
            </div>
            <div v-else-if="klass">
                <div>學段狀態: {{ showCurrentTerm() }}</div>
                <p>{{klass.tag}}</p>
                <BehaviourTable :yearTerms="yearTerms" :currentTermId="klass.current_term" :behaviours="behaviours"/>
            </div>
            
        </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import BehaviourTable from '@/Components/BehaviourTable.vue';

export default {
    components: {
        AdminLayout,
        BehaviourTable
    },
    props: ['yearTerms','staff','course','klass','behaviours'],
    data() {
        return {
            tempBehaviour:null,
        }
    },
    mounted() {
    },
    methods: {
        onFocusInput(behaviour){
            this.tempBehaviour={...behaviour}
        },
        onBlurScoreInput(behaviour){
            console.log(behaviour);
            if(this.tempBehaviour.score===behaviour.score){
                console.log('same')
                return false;
            }else{
                console.log(behaviour)
                axios.post(route('teacher.course.behaviours.store',behaviour.reference_id),behaviour)
                .then(resp=> 
                    console.log(resp.data)
                );
            }
        },
        getBehaviourScore(behaviours, termId){
            //var behaviour=behaviours.find(b=>b.term_id==termId)
            var behaviour=behaviours[termId]
            if(behaviour){
                return behaviour.score
            }else{
                return null
            }
        },
        showCurrentTerm(){
            if(this.course){
                var currentTerm=this.course.current_term
            }else{
                var currentTerm=this.klass.current_term
            }

            if(currentTerm==0){
                return '已上鎖';
            }else{
                return this.yearTerms.find(t=>t.value==currentTerm).label;
            }
        }


    },
}
</script>

