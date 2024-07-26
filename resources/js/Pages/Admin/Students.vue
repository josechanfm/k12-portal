<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                學年級別學科列表
            </h2>
        </template>
        <div>List all students</div>
        <div>Might need to add search and filter features</div>
        <a-button @click="onClickCreate()">新增學生</a-button>
            <a-table :dataSource="students.data" :columns="columns" :pagination="pagination" @change="onPaginationChange" ref="dataTable">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <a-button :href="route('director.students.show',record.id)" class="ant-btn" target="_blank">學生檔案</a-button>
                        <a-button @click="onClickEdit(record)" :style="'Edit'">修改</a-button>
                        <a-button @click="onClickDelete(record)" :style="'Delete'">刪除</a-button>
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
        <a-modal v-model:open="modal.isOpen" :title="modal.title" >
            <a-form
                :model="modal.data"
                name="Staff"
                ref="modalRef"
                :rules="rules"
                :validate-messages="validateMessages"
                :label-col="{ span: 4 }"
                :wrapper-col="{ span: 20 }"
            >
                <a-form-item label="登入名稱" name="username">
                    <a-input v-model:value="modal.data.username" />
                </a-form-item>
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
                <a-form-item label="聯繋電話" name="mobile">
                    <a-input v-model:value="modal.data.mobile" />
                </a-form-item>
                <a-form-item label="校部" name="sector">
                    <a-input v-model:value="modal.data.sector" />
                </a-form-item>
                <a-form-item label="教師" name="is_teacher">
                    <a-switch v-model:checked="modal.data.is_teacher" :checkedValue="1" :uncheckedValue="0"/>
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
import {CheckSquareOutlined, StopOutlined} from '@ant-design/icons-vue';
import { extractIdentifiers } from '@vue/compiler-core';

export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined
    },
    props: ['students'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Student',
                data:{}
            },
            pagination:{
                total: this.students.total,
                current:this.students.current_page,
                pageSize:this.students.per_page,
            },
            columns:[
                {
                    title: '登入名稱',
                    dataIndex: 'username',
                },{
                    title: '姓名(中文)',
                    dataIndex: 'name_zh',
                },{
                    title: '姓名(外文)',
                    dataIndex: 'name_fn',
                },{
                    title: '性別',
                    dataIndex: 'gender',
                },{
                    title: '教師',
                    dataIndex: 'is_teacher',
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
            this.$inertia.get(route('admin.students.index'),{
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
        onClickDelete(recordId){
            if (!confirm('是否確定刪除?')) return;
            this.$inertia.delete('/admin/---/' + recordId,{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        updateRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.put(route('admin.students.update',this.modal.data.id), this.modal.data,{
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
                this.$inertia.post(route('admin.students.store'), this.modal.data,{
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