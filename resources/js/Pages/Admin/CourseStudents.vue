<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別學生列表
            </h2>
        </template>

        <a-typography-title :level="3">學科代號: {{ course.code }}</a-typography-title>
        <a-typography-title :level="3">學科名稱: {{ course.title_zh }}</a-typography-title>
        <a-table :dataSource="students" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='subject'">
                    <a-button @click="selectedCourses(record)">選科</a-button>
                </template>
                <template v-else>
                    {{record[column.dataIndex]}}
                </template>
            </template>
        </a-table>
        <SyncCourseStudents :courses="courses" :student="selectedStudent"/>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import {CheckSquareOutlined, StopOutlined} from '@ant-design/icons-vue';
import SyncCourseStudents from '@/Components/SyncCourseStudents.vue';

export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined,
        SyncCourseStudents
    },
    props: ['list','klass','course','courses','klass','students'],
    data() {
        return {
            selectedStudent:{},
            columns:[
            {
                    title: '姓名(中文)',
                    dataIndex: 'name_zh',
                },{
                    title: '姓名(外文)',
                    dataIndex: 'name_fn',
                },{
                    title: '性別',
                    dataIndex: 'gender',
                },{
                    title: '有效',
                    dataIndex: 'active',
                },{
                    title: '選科',
                    dataIndex: 'subject',
                }
            ],
        }
    },
    created(){
    },
    methods: {
        selectedCourses(student){
            this.courses.forEach((course1,index)=>{
                course1.selected=false;
                student.courses.forEach((course2,index)=>{
                  if(course1.id==course2.id){
                    course1.selected=true;
                  }
                })
            })
            this.selectedStudent={...student};
        },
    },
}
</script>