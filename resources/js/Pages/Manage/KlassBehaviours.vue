<template>
    <AdminLayout title="班別操行" :breadcrumb="breadcrumb">
        <div>
            <div class="py-5">
            <KlassSelector routePath="manage.klass.behaviours.index" :param="[]" :currentKlass="klass" />
            </div>
            <a-typography-title :level="4">老師名稱：{{ staff.name_zh }}</a-typography-title>
            <div v-if="course">
                <p>科目操行</p>
                <p>{{course.klass.tag}}</p>
                <p>{{course.code}}-{{course.title_zh}}</p>
            </div>
            <div v-else-if="klass">
                <p>學段狀態:{{ showCurrentTerm() }}</p>
                <p>{{klass.tag}}</p>
            </div>
            <BehaviourTable :yearTerms="yearTerms" :currentTermId="this.klass.lock_courses?0:this.klass.current_term" :behaviours="behaviours"/>
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
    props: ['yearTerms','course','staff','klass','behaviours'],
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
        showCurrentTerm(){
            if(this.klass.lock_courses || this.klass.current_term==0){
                return '已上鎖';
            }else{
                return this.yearTerms.find(t=>t.value==this.klass.current_term).label;
            }
        }

    },
}
</script>

