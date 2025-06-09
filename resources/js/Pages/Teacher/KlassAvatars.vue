<template>
    <AdminLayout title="學生名單" :breadcrumb="breadcrumb">
     
        <div class="font-black text-lg bg-white p-4 rounded-lg shadow-2xl ">
            <div class="flex">
                <div class="flex-1 font-black text-zinc-400 text-2xl ">班別 {{ klass.tag }}</div>
                <a-button  size="small" type="info"  as="link" :href="route('teacher.avatars.index')" >批量學生上載</a-button>
            </div>
            <div class="flex gap-4 flex-wrap ">
                <div  :key="student"  v-for="student in students">
                    <UploadAvatars :avatar="student"></UploadAvatars>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { UserOutlined } from '@ant-design/icons-vue';
import UploadAvatars from "../../Components/UploadAvatars.vue";


export default {
    components: {
        AdminLayout,UploadAvatars,
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