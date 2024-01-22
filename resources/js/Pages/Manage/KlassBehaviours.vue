<template>
    <AdminLayout title="操行" :breadcrumb="breadcrumb">
        <div>
            <div class="py-5">
            <KlassSelector routePath="manage.klass.behaviours.index" :param="[]" :currentKlass="klass" />
            </div>
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
import KlassSelector from '@/Components/KlassSelector.vue';

export default {
    components: {
        AdminLayout,
        BehaviourTable,
        KlassSelector
    },
    props: ['year','yearTerms','currentTerm','staff','course','klass','behaviours'],
    data() {
        return {
            breadcrumb:[
                {label:"Manage", url:route('manage')},
                {label:"年級班別", url:route('manage.grades.index',{'type':'secondary'})},
                {label:this.klass.tag+'年級' ,url:route('manage.klasses.show', this.klass.id)},
                {label:'操行' ,url:null}
            ],
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

    },
}
</script>

