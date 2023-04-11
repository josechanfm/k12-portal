<template>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="60%" @update="updateRecord()" @onCancel="closeModal()">
            <ol>
                <li v-for="course in courses">
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

</template>

<script>

export default {
    components: {
    },
    props: ['courses','student'],
    data() {
        return {
            modal: {
                // mode:null,
                isOpen: false,
                title:'學生選課',
                // data:{}
            },
            selectAll:false,
        }
    },
    created(){
    },
    methods: {
        modalCancel(){
            //this.selectedStudent.id=null;
            this.modal.isOpen=false;
        },
        updateRecord(){
            //collect selected courses
            var selectedCourse=this.courses.filter(course=>{
                return course.selected;
            }).map(c=>(c.id));

            this.$inertia.post('/admin/student/sync_courses', {
                student_id:this.student.id, //student id
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
        }
    },
    watch:{
        student(newStudent, oldStudent){
            this.modal.isOpen=(newStudent!='');
        }
    }
}
</script>