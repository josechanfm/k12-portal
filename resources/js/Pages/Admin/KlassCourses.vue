<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                學年級別學科列表
            </h2>
        </template>
        <a-typography-title :level="3">年級: {{ klass.tag }}</a-typography-title>
        <a-typography-title :level="3">年級全稱: {{ klass.title_zh }}</a-typography-title>
            <a-table :dataSource="courses" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='students'">
                        
                        <inertia-link :href="route('admin.course.students',record.id)" class="ant-btn">Students</inertia-link>
                    </template>
                    <template v-else-if="column.dataIndex=='subject_heads'">
                        {{ record.subject_heads.map(t=>t.name_zh).toString() }}
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
    props: ['klass','courses','subjects'],
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
    },
}
</script>