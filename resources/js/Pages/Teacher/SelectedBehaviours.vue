<template>
    <AdminLayout title="班別操行" :breadcrumb="breadcrumb">
        <div>
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
            <BehaviourTable :yearTerms="yearTerms" :currentTermId="this.klass.course_locked?0:this.klass.current_term" :behaviours="behaviours"/>
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
    props: ['staff','yearTerms','course','klass','behaviours'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('director.dashboard')},
                {label:"年級班別", url:route('director.grades.index',{'type':'secondary'})},
                {label:this.klass.tag+'年級' ,url:route('director.klasses.show', this.klass.id)},
                {label:'操行' ,url:null}
            ],
        }
    },
    mounted() {
    },
    methods: {
        showCurrentTerm(){
            if(this.klass.course_locked || this.klass.current_term==0){
                return '已上鎖';
            }else{
                return this.yearTerms.find(t=>t.value==this.klass.current_term).label;
            }
        }

    },
}
</script>

