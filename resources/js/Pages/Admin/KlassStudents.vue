<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別學生列表
            </h2>
        </template>
        <!--  -->
        <!--  -->
        <a-typography-title :level="3">班別: {{ klass.tag }}</a-typography-title>
        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="ant-table-thead">
                            <tr>
                                <th>選科</th>
                                <th>學生姓名</th>
                                <th v-for="column in dataColumns">{{ column.title }}</th>
                            </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <tr v-for="(student, studentId) in dataTable">
                                <td>
                                    <a-button @click="selectedCourses(studentId)">選科</a-button>
                                </td>
                                <td>{{ student.student_name }}</td>
                                <td v-for="(course, idx) in student.courses" class="text-center">
                                    <span v-if="course == 1" class="flex justify-center items-center">
                                        <svg width="20px" height="20px" viewBox="0 0 20 20"
                                            xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#76f254">
                                            <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                            <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round">
                                            </g>
                                            <g id="SVGRepo_iconCarrier">
                                                <path fill="#76f254" fill-rule="evenodd"
                                                    d="M3 10a7 7 0 019.307-6.611 1 1 0 00.658-1.889 9 9 0 105.98 7.501 1 1 0 00-1.988.22A7 7 0 113 10zm14.75-5.338a1 1 0 00-1.5-1.324l-6.435 7.28-3.183-2.593a1 1 0 00-1.264 1.55l3.929 3.2a1 1 0 001.38-.113l7.072-8z">
                                                </path>
                                            </g>
                                        </svg>
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Modal Start-->
        <!--
        <a-modal v-model:open="modal.isOpen" :title="modal.title" width="60%" @update="updateRecord()" @onCancel="closeModal()">
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
        <SyncCourseStudents :courses="klass.courses" :student="selectedStudent" />
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
    props: ['dataTable', 'dataColumns', 'klass', 'students'],
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