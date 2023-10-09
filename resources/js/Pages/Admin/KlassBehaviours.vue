<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別學生列表
            </h2>
        </template>
        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="ant-table-thead">
                            <tr>
                                <th>選科</th>
                                <th>學生姓名</th>
                                <th>ss</th>
                            </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <tr v-for="student in behaviourResponsibles">
                                <td>
                                    {{student.name_zh}}
                                </td>
                                <td>
                                    <ol>
                                        <li v-for="responsible in student.behaviourResponsibles">
                                            <p>Staff Name: {{responsible.staff.name_zh}}</p>
                                            <p>Weight: {{responsible.weight}}</p>
                                            <p>Term_id: {{responsible.term_id}}</p>
                                            <p>Remark: {{responsible.remark}}</p>
                                        </li>
                                    </ol>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Modal Start-->
        <!--
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="60%" @update="updateRecord()" @onCancel="closeModal()">
            <ol>
                <li v-for="course in klass.courses">
                    <a-checkbox v-model:checked="course.selected">
                        {{ course.code }} - {{ course.title_zh }} {{ course.stream}}
                    </a-checkbox>
                </li>
            </ol>
            <template #footer>
                <a-button key="back" @click="modalCancel">返回</a-button>
                <a-button type="primary" @click="updateRecord()">更新</a-button>
            </template>
        </a-modal>    
        -->
        <!-- Modal End-->
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import { CheckSquareOutlined, StopOutlined } from '@ant-design/icons-vue';
import SyncCourseStudents from '@/Components/SyncCourseStudents.vue';

export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined,
        SyncCourseStudents
    },
    props: ['dataTable', 'dataColumns', 'klass', 'students','behaviourResponsibles'],
    data() {
        return {
            selectedStudent: {},
        }
    },
    created() {
        // this.subjects.map(subject=>{
        //     this.courses.map(course=>{
        //         if(course.code==subject.code){
        //             subject.selected=true;
        //         }
        //     })
        // })

    },
    methods: {
        selectedCourses(studentId) {
            var student=this.students.find(s=>s.id==studentId)
            this.klass.courses.forEach((course1, index) => {
                course1.selected = false;
                student.courses.forEach((course2, index) => {
                    if (course1.id == course2.id) {
                        course1.selected = true;
                    }
                })
            })
            this.selectedStudent = { ...student };
        },
    },
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