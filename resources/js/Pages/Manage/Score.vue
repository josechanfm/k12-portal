<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Score
            </h2>
        </template>
        <a-button type="primary" @click="scoreModal">Score</a-button>
        <a-modal v-model:visible="modal.isOpen" title="Basic Modal" @ok="handleOk">
            <p>Some contents...</p>
            <p>Some contents...</p>
            <p>Some contents...</p>
        </a-modal>
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-table :dataSource="score_columns" :columns="columns">
                        <template #bodyCell="{ column, text, record, index }">
                            <template v-if="column.dataIndex == 'operation'">
                                <a-button @click="editRecord(record)">Edit</a-button>
                                <a-button @click="deleteRecord(record.id)">Delete</a-button>
                            </template>
                            <template v-else>
                                {{ record[column.dataIndex]}}
                            </template>
                        </template>
                    </a-table>
                </div>
            </div>
        </div>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <table id="scoreTable">
                        <tr>
                            <th>Name</th>
                            <td v-for="column in score_columns">{{ column.name }}</td>
                        </tr>
                        <tr v-for="(score, key) in scores">
                            <td>{{ score.student_name }}</td>
                            <td v-for="column in score_columns">
                                <a-input  v-model:value="score['score_'+key+'_'+column.id]" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        {{ scores }}

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['score_columns', 'klass', 'students_scores'],
    data() {
        return {
            modal: {
                isOpen: false,
            },
            scores:{},
            columns: [
                {
                    title: 'Term',
                    dataIndex: 'term_id',
                },{
                    title: 'Name',
                    dataIndex: 'name',
                }, {
                    title: 'Type',
                    dataIndex: 'type',
                }, {
                    title: 'Schema',
                    dataIndex: 'schema',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ]

        }
    },
    created(){
        this.students_scores.forEach(student => {
            var score={};
            score['student_name']=student.name_zh
            this.score_columns.forEach(column => {
                score['score_'+student.pivot.klass_student_id+"_"+column.id]=''
            })
            this.scores[student.pivot.klass_student_id]=score;
        })
        this.students_scores.forEach(student => {
            student.scores.forEach(score => {
                this.scores[student.pivot.klass_student_id]['score_'+score.klass_student_id+'_'+score.score_column_id]=score.point;
            })
        })
        //console.log(this.scores)
    },
    methods: {
        scoreModal() {
            this.modal.isOpen = true;
        },
        handleOk() {
            console.log("modal ok");
        }
    },
}
</script>

<style>
#scoreTable, #scoreTable td, #scoreTable th {
  border: 1px solid;
}

#scoreTable {
  width: 100%;
  border-collapse: collapse;
}
</style>