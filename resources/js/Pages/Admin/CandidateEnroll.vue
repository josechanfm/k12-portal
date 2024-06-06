<template>
    <AdminLayout title="入學報名">
            {{candidate}}

            <a-form
                :model="candidate"
                name="Candidate"
                ref="modalRef"
                :rules="rules"
                :validate-messages="validateMessages"
                :label-col="{ span: 4 }"
                :wrapper-col="{ span: 20 }"
                @finish="onFinish"
            >
                <a-form-item label="中文姓名" name="name_zh">
                    <a-input v-model:value="candidate.name_zh" />
                </a-form-item>
                <a-form-item label="外文姓名" name="name_fn">
                    <a-input v-model:value="candidate.name_fn" />
                </a-form-item>
                <a-form-item label="性別" name="gender">
                    <a-radio-group v-model:value="candidate.gender" button-style="solid">
                        <a-radio-button value="M">男</a-radio-button>
                        <a-radio-button value="F">女</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="出生日期" name="dob">
                    <a-date-picker v-model:value="candidate.dob" :format="dateFormat" :valueFormat="dateFormat" />
                </a-form-item>
                <a-form-item label="入讀年級" name="start_grades">
                    <a-select v-model:value="candidate.start_grade" :options="gradesKlasses" :fieldNames="{value:'id',label:'tag'}" @change="onChangeGrade"/>
                </a-form-item>
                <a-form-item label="入讀班別" name="start_klass">
                    <a-select v-model:value="candidate.start_klass" :options="klassOptions" :fieldNames="{value:'id',label:'tag'}"/>
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button key="back" @click="modalCancel">Return</a-button>
                <a-button key="Store" type="primary" @click="storeRecord()">確認入讀班別</a-button>
            </template>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import {CheckSquareOutlined, ConsoleSqlOutlined, StopOutlined} from '@ant-design/icons-vue';
import { extractIdentifiers } from '@vue/compiler-core';

export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined
    },
    props: ['gradesKlasses','candidate'],
    data() {
        return {
            dateFormat:'YYYY-MM-DD',
            klassOptions:[],
            rules:{
                name_zh:{
                    required:true,
                },
                gender:{
                    required:true,
                },
                mobile:{
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
    created(){
       this.klassOptions=this.gradesKlasses.find(g=>g.id==this.candidate.start_grade).klasses
    },
    methods: {
        onChangeGrade(){
            this.klassOptions=this.gradesKlasses.find(g=>g.id==this.candidate.start_grade).klasses
            console.log(this.candidate.start_grade)
        },
        onFinish(){
            this.$inertia.post(route('admin.candidates.enrollConfirm'), this.modal.data,{
                onSuccess:(page)=>{
                    this.modal.data={}
                    this.modal.isOpen=false;
                },
                onError:(error)=>{
                    console.log(error);
                }
            });
        }

    },
}
</script>