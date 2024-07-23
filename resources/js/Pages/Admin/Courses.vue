<template>
    <AdminLayout title="Dashboard" :breadcrumb="breadcrumb">
            <a-typography-title :level="3">班級: {{ klass.tag }} - {{ klass.title_zh }}</a-typography-title>
            <a-typography-title :level="3">
                班主任: <span v-for="teacher in klass.klass_heads">{{ teacher.name_zh }}, </span>
            </a-typography-title>
            <div>
                <a-switch v-model:checked="toAssignTeachers" :checkedValue="1" :uncheckedValue="0"/>&nbsp;調整老師
            </div>
            
            <a-table :dataSource="courses" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <a-button @click="changeTeachers(record)">修改</a-button>
                        <inertia-link :href="route('admin.select.students.index',{type:'course',id:record.id})" class="ant-btn">學生名單</inertia-link>
                        <br>
                        <template v-for="term in yearTerms">
                            <a-button 
                                @click="onClickSelectedTermLock(record.id, term.value)" 
                                :type="record.current_term==term.value?'secondary':''"
                                :disabled="klass.course_locked"
                            >{{term.label}}
                            </a-button>
                        </template>
                        <a-button 
                            @click="onClickSelectedTermLock(record.id,0)" 
                            :type="record.current_term==0?'secondary':''"
                            :disabled="klass.course_locked"
                            >鎖定</a-button>
                    </template>
                    <template v-else-if="column.dataIndex=='subject_heads'">
                        <div v-if="toAssignTeachers">
                            <a-select v-model:value="record.subject_head_ids" placeholder="請選擇..." 
                                style="width:200px" :options="teachers" mode="multiple"
                                :field-names="{ label: 'name_zh', value: 'id' }" 
                                @change="updateCourseTeachers(record)"
                            />
                            <!-- <a-button @click="updateSubjectHead(record)" v-show="record.subject_head_changed">Save</a-button> -->
                        </div>
                        <div v-else>
                            <ol>
                                <li v-for="head in record.subject_heads">{{ head.name_zh }}</li>
                            </ol>
                        </div>
                    </template>
                    <template v-else-if="column.dataIndex=='course_teachers'">
                        <div v-if="toAssignTeachers">
                            <a-select v-model:value="record.teacher_ids" placeholder="請選擇..." 
                                style="width:200px" :options="teachers" mode="multiple"
                                :field-names="{ label: 'name_zh', value: 'id' }" 
                                @change="updateCourseTeachers(record)"
                            />
                            <!-- <a-button @click="updateCourseTeachers(record)" v-show="record.course_teacher_changed">Save</a-button> -->
                        </div>
                        <div v-else>
                            <ol>
                                <li v-for="teacher in record.staffs">
                                    {{ teacher.name_zh }}
                                    <eye-outlined v-if="teacher.pivot.behaviour==true"/>
                                </li>
                            </ol>
                        </div>
                    </template>                    
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="60%" @update="updateRecord()" @onCancel="closeModal()">
            <a-form
                :model="modal.data"
                name="modalCourse"
                ref="modalRef"
                :rules="rules"
                :validate-messages="validateMessages"
            >
                <a-form-item label="科目代號" name="code">
                    {{ modal.data.code }}
                </a-form-item>
                <a-form-item label="科目名稱 (中文)" name="title_zh">
                    <a-input v-bind:value="modal.data.title_zh" />
                </a-form-item>
                <a-form-item label="科目名稱 (英文)" name="title_en">
                    <a-input v-bind:value="modal.data.title_en" />
                </a-form-item>
                <a-form-item label="專業方向" name="stream">
                    <a-radio-group v-bind:value="modal.data.stream" button-style="solid">
                        <template v-for="item in streams">
                            <a-radio-button :value="item.value">{{ item.label }}</a-radio-button>    
                        </template>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="必修/選修" name="elective">
                    <a-radio-group v-bind:value="modal.data.elective" button-style="solid">
                        <template v-for="item in subjectTypes">
                            <a-radio-button :value="item.value">{{ item.label }}</a-radio-button>    
                        </template>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="有效" name="active">
                    <a-switch v-bind:checked="modal.data.active" :checkedValue="1" :uncheckedValue="0"/>
                </a-form-item>
                <a-form-item label="科組長" name="subject_head_ids">
                    <a-select v-model:value="modal.data.subject_head_ids" :options="teachers" :fieldNames="{value:'id',label:'name_zh'}"  mode="multiple"/>
                </a-form-item>
                <a-form-item label="科任老師" name="teachers_ids">
                    <a-select v-model:value="modal.data.teacher_ids" :options="teachers" :fieldNames="{value:'id',label:'name_zh'}"  mode="multiple"/>
                </a-form-item>
                <a-form-item label="評操行.." name="behaviour">
                    <a-checkbox-group name="canGiveBehaviours" v-model:value="modal.data.canGiveBehaviours">
                        <template v-for="teacherId in modal.data.teacher_ids">
                            <a-checkbox :value="teacherId" >
                                {{teachers.find(t=>t.id==teacherId).name_zh}}
                            </a-checkbox>
                        </template>
                    </a-checkbox-group>
                </a-form-item>
            </a-form>
        <template #footer>
            <a-button key="back" @click="modalCancel">Return</a-button>
            <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary" @click="updateTeachers()">Update</a-button>
        </template>
    </a-modal>    
    <!-- Modal End-->

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import {CheckSquareOutlined, ConsoleSqlOutlined, StopOutlined} from '@ant-design/icons-vue';
import { EyeOutlined } from '@ant-design/icons-vue';
import axios from 'axios';

export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined,
        EyeOutlined
    },
    props: ['yearTerms','klass','courses','subjects','teachers'],
    data() {
        return {
            breadcrumb:[
                {label:"行政管理" ,url:route('admin.dashboard')},
                {label:"年級" ,url:route('admin.year.grades.index',this.klass.grade.year_id)},
                {label:"班別" ,url:route('admin.grade.klasses.index',this.klass.grade.id)},
                {label:"科目" ,url:null},
            ],
            streams:[],
            subjectTypes:[],
            testCheckbox:[],
            modal: {
                mode:null,
                isOpen: false,
                title:'Subjects',
                data:{
                    canGiveBehaviours:[]
                }
            },
            selectedSubjects:[],
            selectAll:false,
            dataSource:[],
            toAssignTeachers:false,
            columns:[
                {
                    title: '學科代號',
                    dataIndex: 'code',
                },{
                    title: '中文名稱',
                    dataIndex: 'title_zh',
                },{
                    title: '專業方向',
                    dataIndex: 'stream',
                },{
                    title: '選修/必修',
                    dataIndex: 'elective',
                },{
                    title: '有效',
                    dataIndex: 'active',
                },{
                    title: '科組長',
                    dataIndex: 'subject_heads',
                },{
                    title: '老師',
                    dataIndex: 'course_teachers',
                },{
                    title: '操作',
                    dataIndex: 'operation',
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
    created(){
        // this.subjects.map(subject=>{
        //     this.courses.map(course=>{
        //         if(course.code==subject.code){
        //             subject.selected=true;
        //         }
        //     })
        // })

        axios.get(route('api.config.item',{key:'study_streams'}))
            .then(res=>{
                this.streams=res.data
                
            })
            .catch(err=>{
                console.log(err);
            })

            axios.get(route('api.config.item',{key:'subject_types'}))
            .then(res=>{
                this.subjectTypes=res.data
            })
            .catch(err=>{
                console.log(err);
            })

    },
    methods: {
        modalCancel(){
            this.modal.isOpen=false;
        },
        updateCourseTeachers(record){
            this.$inertia.put(route('admin.course.updateCourseTeachers',record.id), record, {
                    onSuccess: (page) => {
                        this.modal.data.isOpen=false
                        console.log(page);
                    },
                    onError: (err) => {
                        console.log(err);
                    }
                });
        },
        changeTeachers(record){
            this.modal.data={...record}
            this.modal.isOpen=true
            this.modal.mode='EDIT'
            this.modal.data.canGiveBehaviours=this.modal.data.teaching.filter(
                t=>(t.pivot.behaviour==true)
            ).map(t=>t.id);
        },
        updateTeachers(){
            
            this.modal.data.syncCourseTeachers={}
            this.modal.data.teacher_ids.forEach(t=>{
                this.modal.data.syncCourseTeachers[t]={
                    "behaviour":this.modal.data.canGiveBehaviours?this.modal.data.canGiveBehaviours.includes(t):false}
            })
            console.log(this.modal.data);
            this.$inertia.put(route('admin.course.updateCourseTeachers',this.modal.data.id), this.modal.data, {
                    onSuccess: (page) => {
                        // console.log(page)
                        this.modal.isOpen=false
                    },
                    onError: (err) => {
                        console.log(err);
                    }
                });
        },
        onClickSelectedTermLock(courseId,termId){
            this.$inertia.post(route('admin.lock.course',{courseId:courseId,termId:termId}),{},{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError:(err)=>{
                    alert(err.message)                        
                }
            })
        }
    
    },
}
</script>