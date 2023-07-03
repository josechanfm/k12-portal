<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                {{ klass.tag }}
                {{ klass.transcript_migrated }}
            </h2>
        </template>
        <a-button @click="migrateTranscripts" :disabled="klass.transcript_migrated==1">Migrate transcripts</a-button>
        <div>
            <div class="ant-table">
                <div class="ant-table-container">
                    <div class="ant-table-content">
                        <table class="table-layout: auto;">
                            <thead class="ant-table-thead">
                                <tr>
                                    <th>Student Name</th>
                                    <th v-for="column in finalScores.score_columns">{{
                                        transcriptTemplates[column.course_code].title_zh }}</th>
                                    <th>不合格單位數</th>
                                </tr>

                            </thead>
                            <tbody class="ant-table-tbody">
                                <template v-for="student in finalScores.students">
                                    <tr class="ant-table-row ant-table-row-level-0">
                                        <td>{{ student.student_name }}</td>
                                        <td v-for="score in student.scores" class="ant-table-cell text-center">
                                            <span :class="isPass(score) ? '' : 'text-red-500 font-bold'">
                                                {{ score }}
                                            </span>
                                        </td>
                                        <td class="text-center">{{ student.fail_units }}</td>
                                    </tr>
                                </template>

                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['klass', 'transcriptTemplates', 'finalScores'],
    data() {
        return {
        }
    },
    created() {

    },
    mounted() {
        // this.fields=this.transcriptTemplate.map((t)=>(
        //     {[t.field_name]:t.title_zh}
        // ));
    },
    methods: {
        isPass(score) {
            return score >= parseInt(this.transcriptTemplates['passing'].value)
        },
        migrateTranscripts(){
            if(confirm('Are you sure!?')){
                console.log('migrate: mange.klass.migrateTranscripts');
            }
        }
    }
}
</script>

<style>
.dataTable,
.dataTable td,
.dataTable th {
    border: 1px solid;
}

.dataTable {
    width: 100%;
    border-collapse: collapse;
}

.dataTable input {
    text-align: center;
}

/*定义要拖拽元素的样式*/
table.itxst {
    color: #333333;
    border: #ddd solid 1px;
    border-collapse: collapse;
}

table.itxst th {
    border: #ddd solid 1px;
    padding: 8px;
    background-color: #fafafa;
}

table.itxst td {
    border: #ddd solid 1px;
    padding: 8px;
    background-color: #ffffff;
}

table.itxst tr {
    cursor: pointer;
}

table.itxst td.move:hover {
    cursor: move;
}</style>