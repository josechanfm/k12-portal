<template>
    <AdminLayout title="入學報名">
        <button @click="onClickCreate()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">新增報名</button>
            <a-table :dataSource="candidates.data" :columns="columns" :pagination="pagination" @change="onPaginationChange" ref="dataTable">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <ButtonLink @click="onClickEdit(record)" :style="'Edit'">修改</ButtonLink>
                        <ButtonLink @click="onClickDelete(record)" :style="'Delete'">刪除</ButtonLink>
                        <ButtonLink @click="onClickEnroll(record)" :style="'Default'">Enroll</ButtonLink>
                    </template>
                    <template v-if="column.dataIndex=='username'">
                        <span v-if="record.user">
                            {{ record.user.username }}
                        </span>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                        
                </template>
            </a-table>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" >
            <a-form
                :model="modal.data"
                name="Candidate"
                ref="modalRef"
                :rules="rules"
                :validate-messages="validateMessages"
                :label-col="{ span: 4 }"
                :wrapper-col="{ span: 20 }"
            >
                <a-form-item label="中文姓名" name="name_zh">
                    <a-input v-model:value="modal.data.name_zh" />
                </a-form-item>
                <a-form-item label="外文姓名" name="name_fn">
                    <a-input v-model:value="modal.data.name_fn" />
                </a-form-item>
                <a-form-item label="性別" name="gender">
                    <a-radio-group v-model:value="modal.data.gender" button-style="solid">
                        <a-radio-button value="M">男</a-radio-button>
                        <a-radio-button value="F">女</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="出生日期" name="dob">
                    <a-date-picker v-model:value="modal.data.dob" :format="dateFormat" :valueFormat="dateFormat" />
                </a-form-item>
                <a-form-item label="入讀年級" name="start_klass">
                    <a-select v-model:value="modal.data.start_klass" :options="grades" :fieldNames="{value:'id',label:'tag'}"/>
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button key="back" @click="modalCancel">Return</a-button>
                <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
                <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary" @click="storeRecord()">Create</a-button>
            </template>

        </a-modal>
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
    props: ['grades','candidates'],
    data() {
        return {
            dateFormat:'YYYY-MM-DD',
            modal: {
                mode:null,
                isOpen: false,
                title:'Candidates',
                data:{}
            },
            pagination:{
                total: this.candidates.total,
                current:this.candidates.current_page,
                pageSize:this.candidates.per_page,
            },
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
                    title: '入讀年級',
                    dataIndex: 'start_klass',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],
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
       
    },
    methods: {
        onPaginationChange(page, filters, sorter){
            this.$inertia.get(route('admin.candidates.index'),{
                page:page.current,
                per_page:page.pageSize,
                //filter:filters,
                //sorter:sorter
            },{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        },
        onClickCreate(record){
            this.modal.data={};
            this.modal.title="新增職員記錄";
            this.modal.mode='CREATE';
            this.modal.isOpen = true;
        },
        onClickEdit(record){
            this.modal.data={...record};
            this.modal.title="修改職員記錄";
            this.modal.mode='EDIT';
            this.modal.isOpen = true;
        },
        onClickDelete(record){
            if (!confirm('是否確定刪除?')) return;
            this.$inertia.delete('/admin/---/' + record.id,{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        },
        onClickEnroll(record){
            console.log(record);
            this.$inertia.post(route('admin.candidate.enroll',record.id),{
                onSuccess:(page)=>{
                    console.log(page.data)
                },
                onError: (error)=>{
                    console.log(error)
                }

            });
        },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        updateRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.put(route('admin.candidates.update',this.modal.data.id), this.modal.data,{
                    onSuccess:(page)=>{
                        this.modal.data={}
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
        storeRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.post(route('admin.candidates.store'), this.modal.data,{
                    onSuccess:(page)=>{
                        this.modal.data={}
                        this.modal.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });
        }

    },
}
</script>