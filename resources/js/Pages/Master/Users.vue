<template>
    <AdminLayout title="用戶權限及分配">
        <div class="bg-white p-2 rounded-lg">
        <button @click="createRecord()" class="border-none bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">
            新增用戶
        </button>
        <a-table :dataSource="users" :columns="columns" size="small"
            :pagination="false" :scroll="{ y: '60vh' }"
            class="rounded-lg border-gray-200  border p-2 "  bordered>
            <template #headerCell="{ column }">
                 <div class="text-center">   {{ $t(column.title) }}</div>
            </template>
            <template #bodyCell="{column, text, record, index}">
                <div v-if="column.dataIndex=='operation'" class="flex gap-1  justify-center">
                    <a-button @click="editRecord(record)" size="small" class=" !h-fit font-black text-lg text-white bg-amber-600 ">編輯</a-button>
                    <a-button @click="deleteRecord(record.id)" size="small" class="!h-fit font-black text-lg text-white bg-red-600">刪除</a-button>
                </div>
                <template v-else-if="column.dataIndex=='roles'">
                    <a-tag v-for="role in record.roles" color="green">{{ $t(role.name) }}</a-tag>
                </template>
                <template v-else-if="column.dataIndex=='index'">
                  {{ index+1 }}
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
     

        <!-- Modal Start-->
        <a-modal v-model:open="modal.isOpen" :title="modal.title" width="60%">
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
                   <a-input  v-if="modal.mode=='CREATE'" v-model:value="modal.data.email" />
                   <div  v-else class="font-black">{{ modal.data.email }}</div>
                </a-form-item>
                <a-form-item label="權限" name="roles">
                    <a-checkbox-group v-model:value="modal.data.newRoles" name="checkboxgroup" :options="roles.map(
                        role=>({ value:role.id, label:$t(role.name) })
                    )" />
                </a-form-item>
                <a-button   v-if="modal.mode=='EDIT' && !modal.data.restPasswordStatus" 
                    class="!rounded-lg !text-blue-800 !bg-blue-50 !font-black" 
                    @click="addFieldRestPassword">重設密碼
                </a-button>
                <!-- new account -->
                 <template  v-if="modal.mode=='CREATE'">
                    <a-form-item  label="密碼" name="passowrd">
                            <a-input type="password" v-model:value="modal.data.password" />
                    </a-form-item>
                    <a-form-item label="確認密碼" name="confirmPassword">
                        <a-input type="password" v-model:value="modal.data.confirmPassword" />
                    </a-form-item>
                </template>
                <!--  -->
                <div v-if="modal.data.restPasswordStatus" 
                    class="flex flex-col gap-3 px-2 p-1 rounded-lg  border-gray-500 border border-1">
                    <div class="flex">
                            <div class="flex-1 ">
                            </div>
                            <a-button  
                                class="!rounded-lg !text-red-800 !bg-red-50 !font-black"
                                v-if="modal.data.restPasswordStatus"  @click="dropFieldRestPassword">取消重設密碼
                            </a-button>
                    </div>
                    <template v-if=" modal.data.restPasswordStatus">
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
            <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary" @click="storeRecord(modal.data )">新增</a-button>
        </template>
        </a-modal>    
        <!-- Modal End-->
        </div>
        </AdminLayout>

</template>

<script>
import { message } from 'ant-design-vue';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { UserSwitchOutlined } from '@ant-design/icons-vue';
import { router } from '@inertiajs/vue3';

export default {
    components: {
        AdminLayout
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
                {   width:50,
                    align:'center',
                    title: '#',
                    dataIndex: 'index',
                },
                {   align:'center',
                    title: 'Name',
                    dataIndex: 'name',
                },{
                    title: 'Roles',
                    dataIndex: 'roles',
                },{
                    title: 'Permissions',
                    dataIndex: 'permissions',
                },{
                    align:'center',
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
            this.modal= {
                mode:null,
                isOpen: false,
                title:'用戶',
                data:{}
            },
            this.modal.isOpen=true;
            this.modal.mode='CREATE';
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
            router.post(route('master.users.update',record.id),data,{
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
            if(record.password!=record.confirmPassword){
                message.info('密碼不一致');
                return false
            }
            let data=JSON.parse(JSON.stringify(record))
            router.post(route('master.users.store'),data,{
                onSuccess:()=>{
                    this.modal.isOpen=false;
                    this.modal.mode='CLOSE';
                    message.success('新增成功');
                },
                onError:(e)=>{
                    message.error(e.password);

                }
            })

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