<template>
    <AdminLayout title="學生名單" :breadcrumb="breadcrumb">
        <a-button as="link" :href="route('teacher.avatars.index')" class="ant-btn ant-btn-default float-right">學生上載</a-button>
        <a-typography-title :level="3">班別: {{ klass.tag }}</a-typography-title>
        <a-row>
            <a-col :span="4" v-for="student in students">
                <p class="height-100">
                    <div v-if="student.avatar">
                        <a-image  width="100px" :src="student.avatar.preview_url"/>
                    </div>
                    <div v-else>
                        <a-avatar shape="square" :size="128">
                            <template #icon><UserOutlined /></template>
                        </a-avatar>                            
                    </div>
                    <div class="text-lg">
                        {{ student.pivot.student_number }} | 
                        {{ student.name_zh }}
                    </div>
                </p>
            </a-col>
        </a-row>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { UserOutlined } from '@ant-design/icons-vue';

export default {
    components: {
        AdminLayout,
        UserOutlined
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