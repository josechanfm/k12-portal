<template>

        <!-- Modal Start-->
        <a-modal v-model:visible="selectedStudent.id" :title="modal.title" width="60%" @update="updateRecord()" @onCancel="closeModal()">
            {{ selectedStudent.id }}
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
    props: ['course','courses','student','selectedStudent'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'學生選課',
                data:{}
            },
            selectAll:false,
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
        modalCancel(){
            console.log(this.selectedStudent);
            this.selectedStudent.id='';
        },
        updateRecord(){
            var selectedCourse=this.courses.filter(course=>{
                return course.selected;
            }).map(c=>(c.id));
            console.log(selectedCourse);
                this.$inertia.post('/admin/student/sync_courses', {
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
        }
    },
}
</script>