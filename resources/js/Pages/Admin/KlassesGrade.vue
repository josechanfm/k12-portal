<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                學年階段之班別
            </h2>
        </template>
        
        <a-typography-title :level="4">學年:{{ grade.year.code }}</a-typography-title>
        <a-typography-title :level="4">年級:{{ grade.tag }}</a-typography-title>
        <ButtonLink v-for="g in grades" :href="'/admin/klasses/grade/'+g.id" :style="'Add'" :type="'Link'">{{ g.tag }}</ButtonLink>
            <button @click="createRecord()"
                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">新增班別</button>
            <a-table :dataSource="klasses" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <ButtonLink :href="'/admin/courses/klass/'+record.id" :type="'Link'">科目</ButtonLink>
                        <ButtonLink @click="editRecord(record)" :style="'Edit'">修改</ButtonLink>
                    </template>
                    <template v-else-if="column.dataIndex=='stream'">
                            {{ getStream(text) }}
                    </template>
                    <template v-else-if="column.dataIndex=='study_id'">
                        <span v-if="text!=''">
                            {{ getStudyPlan(text) }}
                        </span>
                    </template>
                    <template v-else-if="column.dataIndex=='courses'">
                        <a-popover :title="'Courses for '+record.tag">
                            <template #content>
                                <span v-for="course in record.courses">
                                    <p  v-if="course!=undefined && course.type=='SUB'">
                                        {{ course.code }}-{{ course.title_zh }}
                                    </p>
                                </span>
                            </template>
                            <a>{{record.courses.length}}</a>
                        </a-popover>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" 
            :title="modal.title" width="60%" 
        >
        <a-form
            ref="modalRef"
            :model="modal.data"
            name="klasses"
            :label-col="{ span: 8 }"
            :wrapper-col="{ span: 16 }"
            autocomplete="off"
            :rules="rules"
            :validate-messages="validateMessages"
        >
            <a-form-item label="年級代號" name="grade" >
                {{ grade.tag }}
            </a-form-item>
            <a-form-item label="班別號" name="letter">
                <a-select
                    v-model:value="modal.data.letter"
                    style="width: 100%"
                    placeholder="請選擇..."
                    max-tag-count="responsive"
                    :options="klassLetters"
                ></a-select>
            </a-form-item>
            <a-form-item label="專業方向" name="stream">
                <a-radio-group v-model:value="modal.data.stream" button-style="solid">
                    <a-radio-button v-for="ss in studyStreams" :value="ss.value">{{ ss.label }}</a-radio-button>
                </a-radio-group>
            </a-form-item>
            <a-form-item label="教室編號" name="room">
                <a-input v-model:value="modal.data.room" />
            </a-form-item>
        </a-form>
        <template #footer>
            <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
            <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary"  @click="storeRecord()">Add</a-button>
        </template>
    </a-modal>    
    <!-- Modal End-->
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';

export default {
    components: {
        AdminLayout,
        ButtonLink,
    },
    props: ['grades','grade','klasses','klassLetters','studyStreams'],
    data() {
        return {
            gradeSelected:1,
            modal: {
                mode:null,
                isOpen: false,
                title:'Klasses',
                data:{}
            },
            dataSource:[],
            columns:[
                {
                    title: '班別代號',
                    dataIndex: 'tag',
                },{
                    title: '專業方向',
                    dataIndex: 'stream',
                },{
                    title: '教室編號',
                    dataIndex: 'room',
                },{
                    title: '科目數目',
                    dataIndex: 'courses',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                },
            ],
            rules:{
                letter:{
                    required:true,
                },
                stream:{
                    required:true,
                },
                study_id:{
                    required:true,
                }
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
            layout2col: {
                labelCol: {
                    span: 8,
                },
                wrapperCol: {
                    span: 20,
                },
            }

        }
    },
    methods: {
        closeModal() {
            this.isOpen = false;
            this.reset();
            this.editMode = false;
        },
        storeRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.post('/admin/klasses/', this.modal.data,{
                    onSuccess:(page)=>{
                        this.modal.isOpen=false;
                        console.log(page);
                    },
                    onError:(err)=>{
                        console.log(err);
                    }
                });
            }).catch(err => {
                console.log(err);
            });
        },
        updateRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.put('/admin/klasses/' + this.modal.data.id, this.modal.data,{
                    onSuccess:(page)=>{
                        this.modal.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });
           
        },
        editRecord(record){
            this.modal.data={...record};
            this.modal.mode='EDIT';
            this.modal.title="Edit klasses ";
            this.modal.isOpen = true;
        },
        createRecord(){
            this.modal.data={};
            this.modal.data.grade_id=this.grade.id;
            this.modal.mode='CREATE';
            this.modal.title="Create klasses";
            this.modal.isOpen = true;
            this.klasses.forEach(klass=>{
                this.klassLetters.forEach((kl,idx)=>{
                    if(klass.letter==kl.value){
                        this.klassLetters[idx].disabled=true;
                    }
                })
            })
        },
        onChangeGradeSelect(){
            console.log(this.gradeSelected);
            //this.$inertia.get('klasses?gid='+this.gradeSelected);
        },
        getStream(text){
            if(text){
                return this.studyStreams.find(stream=>stream.value==text).label;
            };
        },
        getStudyPlan(text){
            const study=this.studyPlans.find(study=>study.id==text)
            return text;
            //return study.title_zh + " (v."+study.version+")"
        }
    },
}
</script>
