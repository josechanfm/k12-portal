<template>
    <AdminLayout title="Uers">
       
        <button @click="createRecord()" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">
            新增用戶
        </button>
        <a-table :dataSource="users" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='operation'">
                    <a-button @click="editRecord(record)">Edit</a-button>
                    <a-button @click="deleteRecord(record.id)">Delete</a-button>
                </template>
                <template v-else-if="column.dataIndex=='roles'">
                    <ul>
                        <li v-for="role in record.roles">{{ role.name }}</li>
                    </ul>
                </template>
                <template v-else-if="column.dataIndex=='guard'">
                    <ul>
                        <li v-for="role in record.roles">{{ role.guard_name }}</li>
                    </ul>
                </template>
                <template v-else-if="column.dataIndex=='permissions'">
                    <ul>
                        <li v-for="permission in record.permissions">{{ permission.name }}</li>
                    </ul>
                </template>
                <template v-else>
                    {{record[column.dataIndex]}}
                </template>
            </template>
        </a-table>
        <ul>
            <li v-for="role in roles">{{ role.name }}</li>
        </ul>
        <ul>
            <li v-for="permission in permissions">{{ permission.name }}</li>
        </ul>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="60%">
            <a-form
            :labelCol=" { span: 4 }"
                :model="modal.data"
                name="Roles"
                ref="modalRef"
                :rules="rules"
                :validate-messages="validateMessages"
            >
                <a-form-item label="用戶名稱" name="name">
                    <a-input v-model:value="modal.data.name" />
                </a-form-item>
                <a-form-item label="帳戶">
                   <div class="font-black">{{ modal.data.email }}</div>
                </a-form-item>
                <a-form-item label="權限" name="roles">
                    <a-checkbox-group v-model:value="modal.data.newRoles" name="checkboxgroup" :options="roles.map(
                        role=>({ value:role.id, label:role.name })
                    )" />
                </a-form-item>
                <a-button   v-if="!modal.data.restPasswordStatus" 
                    class="!rounded-lg !text-blue-800 !bg-blue-50 !font-black" 
                    @click="addFieldRestPassword">重設密碼
                </a-button>
                <div v-if="modal.data.restPasswordStatus" 
                    class="flex flex-col gap-3 px-2 p-1 rounded-lg border border-1 border-gray-300">
                    <div class="flex">
                            <div class="flex-1">
                            </div>
                            <a-button 
                                class="!rounded-lg !text-red-800 !bg-red-50 !font-black"
                                v-if="modal.data.restPasswordStatus"  @click="dropFieldRestPassword">取消重設密碼
                            </a-button>
                    </div>
                    <template v-if="modal.data.restPasswordStatus">
                        <a-form-item  label="重設密碼" name="newPassowrd">
                            <a-input type="password" v-model:value="modal.data.newPassword" />
                        </a-form-item>
                        <a-form-item label="確認重設密碼" name="confirmPassword">
                            <a-input type="password" v-model:value="modal.data.confirmPassword" />
                        </a-form-item>
                    </template>
                </div>
            </a-form>
        <template #footer>
            <a-button key="back" @click="modalCancel">取消</a-button>
            <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary" @click="updateRecord( modal.data )">更改</a-button>
            <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary" @click="storeRecord()">新增</a-button>
        </template>
        </a-modal>    
        <!-- Modal End-->

        </AdminLayout>

</template>

<script>
import { message } from 'ant-design-vue';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { UserSwitchOutlined } from '@ant-design/icons-vue';
import { Inertia } from '@inertiajs/inertia';

export default {
    components: {
        AdminLayout,
    },
    props: ['users','roles','permissions'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'用戶',
                data:{}
            },
            columns:[
                {
                    title: 'Name',
                    dataIndex: 'name',
                },{
                    title: 'Roles',
                    dataIndex: 'roles',
                },{
                    title: 'Guard',
                    dataIndex: 'guard',
                },{
                    title: 'Permissions',
                    dataIndex: 'permissions',
                },{
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ],
            rules:{
                name:{
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
        }
    },
    mounted() {
    },
    methods: {
        editRecord(record){
            this.modal.isOpen=true;
            this.modal.mode='EDIT';
            console.log('edit record ');
            console.log(record);
            this.modal.data=record
            this.modal.data.newRoles=record.roles.map(role=>role.id);
        },
        createRecord(){
            this.modal.isOpen=true;
            this.modal.mode='ADD';
            console.log('create record');
        },
        deleteRecord(recordid){
            console.log('delte record '+recordId);
        },
        updateRecord(record){
            if( record.restPasswordStatus){
                if(record.newPassword!=record.confirmPassword){
                    message.info('密碼不一致');
                    return false
                }
            }
            let data=JSON.parse(JSON.stringify(record))
            data._method='PUT'
            Inertia.post(route('master.users.update',record.id),data,{
                onSuccess:()=>{
                    this.modal.isOpen=false;
                    this.modal.mode='CLOSE';
                    message.success('更改成功');
                },
                onError:(e)=>{
                    message.error(e.newPassword);

                }
            })

        },
        storeRecord(record){
            this.modal.isOpen=false;
            this.modal.mode='CLOSE';

        },
        modalCancel(){
            this.modal.isOpen=false;
            this.modal.mode='CLOSE';
        },
        addFieldRestPassword(){
            this.modal.data.restPasswordStatus=true
            this.modal.data.newPassword=''
            this.modal.data.confirmPassword=''
        },
        dropFieldRestPassword(){
           delete  this.modal.data.restPasswordStatus
           delete this.modal.data.newPassword
           delete this.modal.data.confirmPassword

        },
    },
}
</script>