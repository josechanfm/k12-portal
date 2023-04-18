<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別學生列表
            </h2>
        </template>
        <a-typography-title :level="3">班別: {{ klass.tag }}</a-typography-title>
        <a-table :dataSource="students" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                    {{record[column.dataIndex]}}
            </template>
        </a-table>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['klass','students'],
    data() {
        return {
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
            this.klass.courses.forEach((course1,index)=>{
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