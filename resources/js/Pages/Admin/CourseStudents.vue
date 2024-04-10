<template>
    <AdminLayout title="科目學生名單" :breadcrumb="breadcrumb">
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
    props: ['list','course','courses','students'],
    data() {
        return {
            breadcrumb:[
                {label:"行政管理" ,url:route('admin.dashboard')},
                {label:"年級" ,url:route('admin.year.grades.index',this.course.klass.grade.year_id)},
                {label:"班別" ,url:route('admin.grade.klasses.index',this.course.klass.grade.id)},
                {label:"科目" ,url:route('admin.klass.courses.index',this.course.klass.id)},
                {label:"學生名單" ,url:null},
            ],
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