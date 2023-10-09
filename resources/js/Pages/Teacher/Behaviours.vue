<template>
    <AdminLayout title="Dashboard">
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
                <p>{{course.klass.tag}}</p>
                <p>{{course.code}}-{{course.title_zh}}</p>
            </div>
            <div v-else-if="klass">
                <p>{{klass.tag}}</p>
            </div>
            <BehaviourTable :yearTerms="yearTerms" :currentTerm="currentTerm" :behaviours="behaviours"/>
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
    props: ['yearTerms','currentTerm','staff','course','klass','behaviours'],
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
        }

    },
}
</script>

