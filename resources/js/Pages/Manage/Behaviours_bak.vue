<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Teacher Dashboard
            </h2>
        </template>
        <a-button @click="year=null">clear</a-button>
        <div>
            <a-table :dataSource="year.klasses" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex == 'operation'">
                        <inertia-link class="ant-btn">操行</inertia-link>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>

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
    props: ['yearTerms','currentTerm','year'],
    data() {
        return {
            tempBehaviour:null,
            columns: [
                {
                    title: '學期',
                    dataIndex: 'tag',
                }, {
                    title: '學期',
                    dataIndex: 'student_count',
                }, {
                    title: '學期',
                    dataIndex: 'promoted_count',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ],

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

