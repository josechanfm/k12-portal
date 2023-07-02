<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                {{ klass.tag }}
            </h2>
        </template>
    <div>
        <table class="dataTable">
            <tr>
                <th>Student Name</th>
                <th v-for="column in transcript.score_columns">{{ column.course_code }}{{ column.course_title }}</th>
            </tr>
            <template v-for="student in transcript.students">
                <tr>
                    <td>{{ student.student_name }}</td>
                    <td v-for="score in student.scores" class="text-center">
                        <span :class="score <= 50?'text-red-500 font-bold':''">
                            {{ score }}

                        </span>
                    </td>
                </tr>
            </template>
        </table>
    </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['klass','transcriptTemplate', 'transcript'],
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
    }
}
</script>

<style>
.dataTable, .dataTable td, .dataTable th {
  border: 1px solid;
}

.dataTable {
  width: 100%;
  border-collapse: collapse;
}
.dataTable input{
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
            }
</style>