<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別學生列表
            </h2>
        </template>
        <a-typography-title :level="3">課程代號: {{ course.code }}</a-typography-title>
        <a-typography-title :level="3">課程名稱: {{ course.title_zh }}</a-typography-title>
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
        <!-- Modal Start-->
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
        <!-- Modal End-->

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import {CheckSquareOutlined, StopOutlined} from '@ant-design/icons-vue';

export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined
    },
    props: ['course','klass','students'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'學生選課',
                data:{}
            },
            selectedSubjects:[],
            selectAll:false,
            dataSource:[],
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
            rules:{
                code:{
                    required:true,
                },
                title_zh:{
                    required:true,
                },
                title_en:{
                    required:true,
                },
                stream:{
                    required:true,
                },
                eletive:{
                    required:true,
                },
            },
            validateMessages:{
                required: '${label} is required!',
                types: {
                    email: '${label} is not a valid email!',
                    number: '${label} is not a valid number!',
                },
                number: {
                    range: '${label} must be between ${min} and ${max}',
                },
            },
            labelCol: {
                style: {
                width: '150px',
                },
            },
        }
    },
    created(){
        // this.subjects.map(subject=>{
        //     this.courses.map(course=>{
        //         if(course.code==subject.code){
        //             subject.selected=true;
        //         }
        //     })
        // })

    },
    methods: {
        selectedCourses(student){
            console.log(this.klass);
            exit();
            this.modal.data={...student};
            this.klass.courses.forEach((course1,index)=>{
                course1.selected=false;
                student.courses.forEach((course2,index)=>{
                  if(course1.id==course2.id){
                    course1.selected=true;
                  }
                })
            })
            this.modal.isOpen=true;
        },
        modalCancel(){
            console.log('modal cancel');
        },
        updateRecord(){
            var selectedCourse=this.klass.courses.filter(course=>{
                return course.selected;
            }).map(c=>(c.id));
            console.log(selectedCourse);
            // this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.post('/admin/student/add_courses', {
                    student_id:this.modal.data.id, //student id
                    courses:selectedCourse
                },{
                    onSuccess:(page)=>{
                        this.modal.isOpen=false;
                        console.log(page);
                    },
                    onError:(err)=>{
                        console.log(err);
                    }
                });
            // }).catch(err => {
            //     console.log(err);
            // });
        }
    },
}
</script>