<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                學年級別學科列表
            </h2>
        </template>
        <a-typography-title :level="3">年級: {{ klass.tag }}</a-typography-title>
        <a-typography-title :level="3">年級全稱: {{ klass.title_zh }}</a-typography-title>
        
            <a-switch v-model:checked="toAssignTeachers" :checkedValue="1" :uncheckedValue="0"/>
                
            <a-table :dataSource="courses" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='students'">
                        <inertia-link :href="route('admin.course.students',record.id)" class="ant-btn">Students</inertia-link>
                    </template>
                    <template v-else-if="column.dataIndex=='subject_heads'">
                        <div v-if="toAssignTeachers">
                            <a-select v-model:value="record.subject_head_ids" placeholder="請選擇..." 
                                style="width:200px" :options="teachers" mode="multiple"
                                :field-names="{ label: 'name_zh', value: 'id' }" @change="record.subject_head_changed=true"></a-select>
                            <a-button @click="updateSubjectHead(record)" v-show="record.subject_head_changed">Save</a-button>
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
                                :field-names="{ label: 'name_zh', value: 'id' }" @change="record.course_teacher_changed=true"></a-select>
                            <a-button @click="updateCourseTeachers(record)" v-show="record.course_teacher_changed">Save</a-button>
                        </div>
                        <div v-else>
                            <ol>
                                <li v-for="teacher in record.teachers">{{ teacher.name_zh }}</li>
                            </ol>
                        </div>
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
import ButtonLink from '@/Components/ButtonLink.vue';
import {CheckSquareOutlined, StopOutlined} from '@ant-design/icons-vue';

export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined
    },
    props: ['klass','courses','subjects','teachers'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Subjects',
                data:{}
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
                    title: '評操行',
                    dataIndex: 'behaviours',
                },{
                    title: '學生',
                    dataIndex: 'students',
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

    },
    methods: {
        updateSubjectHead(record){
            //this.$inertia.post(route('admin.course.updateSubjectHeads',record.id), record, {
            this.$inertia.put(route('admin.course.updateSubjectHeads',record.id), record, {
                    onSuccess: (page) => {
                        console.log(page);
                    },
                    onError: (err) => {
                        console.log(err);
                    }
                });

            //record.subject_head_changed=false;
            console.log(record);
        },
        updateCourseTeachers(record){
            console.log(record);
        }
    },
}
</script>