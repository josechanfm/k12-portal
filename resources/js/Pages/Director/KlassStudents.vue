<template>
    <AdminLayout title="學生名單" :breadcrumb="breadcrumb">

        <div class="py-5">
            <KlassSelector routePath="director.klass.students.index" :currentKlass="klass"/>
        </div>

        <a-button as="link" :href="route('director.klass.avatars',klass.id)" class="ant-btn ant-btn-default float-right">學生照片</a-button>
        <a-typography-title :level="3">班別: {{ klass.tag }}</a-typography-title>
        <a-table :dataSource="students" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex == 'action'">
                    <a-button as="link" :href="route('director.klass.student.transcript',record.pivot.klass_student_id)" class="ant-btn">Gen成績表</a-button>
                    <a :href="route('director.students.show',record.pivot.klass_student_id)" class="ant-btn" target="_blank">學生檔案</a>
                </template>
                <template v-else-if="column.dataIndex=='avatar'">
                    <a-image v-if="record.avatar" width="100px" :src="record.avatar.preview_url"/>
                </template>
                <template v-else>
                    {{record[column.dataIndex]}}
                </template>
            </template>
        </a-table>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KlassSelector from '@/Components/KlassSelector.vue';

export default {
    components: {
        AdminLayout,
        KlassSelector
    },
    props: ['klass','students'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('director.dashboard')},
                {label:"年級班別", url:route('director.grades.index',{'type':'secondary'})},
                {label:this.klass.tag+'年級' ,url:route('director.klasses.show', this.klass.id)},
                {label:'學生名單' ,url:null}
            ],
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
                },{
                    title: 'Avatar',
                    dataIndex: 'avatar',
                },{
                    title:'操作',
                    dataIndex: 'action'
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