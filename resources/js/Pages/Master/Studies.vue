<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                年級學習計劃
            </h2>
        </template>
            <a-button @click="onClickCreate()" type="primary" >新增年級</a-button>
            <a-table :dataSource="studies" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <a-button as="link" :href="route('master.studySubjects.edit',record.id)" class="ant-btn">選擇學科</a-button>
                        <a-button @click="onClickEdit(record)">修改</a-button>
                        <a-button @click="onClickDelete(record)">刪除</a-button>
                    </template>
                    <template v-else-if="column.dataIndex=='courses'">
                        <ul>
                            <li v-for="klass in record['klasses']">Class: {{klass.acronym}}</li>
                        </ul>
                    </template>
                    <template v-else-if="column.dataIndex=='grade_year'">
                        {{ getLabel(gradeYears, text) }}
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>

        <!-- Modal Start-->
        <a-modal v-model:open="modal.isOpen" :title="modal.title" width="60%" >
            <a-form
                name="Study"
                ref="modalRef"
                :model="modal.data"
                :label-col="{ span: 6 }"
                :wrapper-col="{ span: 18 }"
                :rules="rules"
                :validate-messages="validateMessages"
            >
                <a-form-item label="學年階段.." name="grade_year">
                    <a-select
                        ref="select"
                        v-model:value="modal.data.grade_year"
                        :options="gradeYears"
                    />
                </a-form-item>
                <a-form-item label="版本" name="version">
                    <a-select
                        v-model:value="modal.data.version"
                        :options="versions"
                    />
                </a-form-item>
                <a-form-item label="名稱 (中文)" name="title_zh">
                    <a-input v-model:value="modal.data.title_zh" />
                </a-form-item>
                <a-form-item label="名稱 (英文)" name="title_en">
                    <a-input v-model:value="modal.data.title_en" />
                </a-form-item>
                <a-form-item label="專業方向" name="stream">
                    <a-radio-group v-model:value="modal.data.stream" button-style="solid">
                        <a-radio-button v-for="ss in studyStreams" :value="ss.value">{{ ss.label }}</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="簡介" name="description">
                    <a-textarea v-model:value="modal.data.description" placeholder="textarea with clear icon" allow-clear />
                </a-form-item>
                <!-- <a-form-item label="Klass Heads" name="subject_head_ids">
                    <a-select v-model:value="modal.data.klass_head_ids" :options="teachers" :fieldNames="{value:'id',label:'name_zh'}"/>
                </a-form-item>
 -->
                <a-form-item label="有效" name="active">
                    <a-switch v-model:checked="modal.data.active" :checkedValue="1" :uncheckedValue="0"/>
                </a-form-item>
            </a-form>
        <template #footer>
            <a-button key="back" @click="modalCancel">Return</a-button>
            <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
            <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary" @click="storeRecord()">Create</a-button>
        </template>
        </a-modal>    
        <!-- Modal End-->
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';
import { Modal } from 'ant-design-vue';
import { ExclamationCircleOutlined } from '@ant-design/icons-vue';
import { ref, createVNode } from 'vue';

export default {
    components: {
        AdminLayout, Modal, createVNode, ExclamationCircleOutlined
    },
    props: ['studies','studyStreams','gradeYears','versions'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Subjects',
                data:{}
            },
            columns:[
                {
                    title: '版本',
                    dataIndex: 'version',
                },{
                    title: '年級代號',
                    dataIndex: 'grade_year',
                },{
                    title: '年級名稱',
                    dataIndex: 'title_zh',
                },{
                    title: '專業方向',
                    dataIndex: 'stream',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                },
            ],
            rules:{
                code:{
                    required:true,
                },
                title_zh:{
                    required:true,
                },
                type:{
                    required:true,
                },
                stream:{
                    required:true,
                },
                eletive:{
                    required:true,
                },
                grade_year:{
                    required:true,
                },
                active:{
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
    methods: {
        onClickCreate(record){
            this.modal.data={active:0};
            this.modal.title="新增學科";
            this.modal.mode='CREATE';
            this.modal.isOpen = true;
        },
        onClickEdit(record){
            this.modal.data={...record};
            this.modal.title="修改學科";
            this.modal.mode='EDIT';
            this.modal.isOpen = true;
        },
        storeRecord(){
            console.log(this.modal.data);
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.post(route('master.studies.store'), this.modal.data,{
                    onSuccess:(page)=>{
                        console.log(page);
                        this.modal.isOpen=false;
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
            console.log(this.modal.data);
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.put(route('master.studies.update',this.modal.data.id), this.modal.data,{
                    onSuccess:(page)=>{
                        console.log(page);
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
        onClickDelete(record){
            Modal.confirm({
                title: '是否確定',
                content: '刪除所選之主題?',
                okText: '確定',
                cancelText: '取消',
                onOk: () => {
                    this.$inertia.delete(route('master.studies.destroy', record.id), {
                        onSuccess: (page) => {
                            console.log(record.id+"deleted.");
                        },
                        onError: (error) => {
                            console.log(error.message);
                            Modal.error({
                                title: '數據一致性出錯',
                                content: error.message,
                                okText: '了解',
                            });
                        }
                    });
                }
            })
        },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        onFinishFailed(errorInfo){
            console.log('errorInfo: '+errorInfo);
        },
        getLabel(arr, value){
            const item=arr.find(a=>a.value==value)
            return item?item.label: 'Null value for: '+value
        }

    },
}
</script>