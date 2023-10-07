<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                操作
            </h2>
        </template>
        <div>
            <a-radio-group v-model:value="selectedGradeId" button-style="solid">
                <a-radio-button v-for="grade in year.grades" :value="grade.id">{{grade.tag}}</a-radio-button>
            </a-radio-group>
            <p></p>
            <a-radio-group v-model:value="selectedKlassId" button-style="solid">
                <template v-for="klass in year.klasses">
                    <a-radio-button v-if="klass.grade_id==selectedGradeId" :value="klass.id">
                        <inertia-link :href="route('manage.klass.behaviours.index',klass.id)">{{klass.tag}}</inertia-link>
                    </a-radio-button>
                </template>
            </a-radio-group>
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
    props: ['year','yearTerms','currentTerm','staff','course','klass','behaviours'],
    data() {
        return {
            tempBehaviour:null,
            selectedGradeId:0,
            selectedKlassId:0
        }
    },
    mounted() {
        this.selectedGradeId=this.klass.grade_id
        this.selectedKlassId=this.klass.id
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

