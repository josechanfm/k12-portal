<template>
    <AdminLayout title="用戶權限及分配">
        <div class="flex flex-col bg-white p-2 rounded-lg gap-1">
            <div class="flex">
                <div class="flex-1"></div>
                <a-button @click="createRecord()" type="create" size="small">
                    新增用戶
                </a-button>
            </div>
            <!-- :pagination="false"               :scroll="{ y: '80vh' }"-->
        <a-table :dataSource="viewUsers" :columns="columns" size="small"

            class="rounded-lg border-gray-200  border p-2 "  bordered>
            <template #headerCell="{ column }">
                 <div class="text-center flex gap-1 w-fit text-nowrap items-center justify-center" v-if="column.title=='Name'">
                     <div>{{ $t(column.title) }}</div>
                    <a-input class="w-fit" placeholder="搜尋名字/帳戶" v-model="search"></a-input>
                </div>
                 <div class="text-center" v-else>   {{ $t(column.title) }}</div>
            </template>
            <template #bodyCell="{column, text, record, index}">
                <div v-if="column.dataIndex=='operation'" class="flex gap-1  justify-center">
                    <a-button @click="editRecord(record)" size="small" type="edit">編輯</a-button>
                    <a-button @click="deleteRecord(record.id)" size="small" type="delete">刪除</a-button>
                </div>
                <template v-else-if="column.dataIndex=='roles'">
                    <a-tag v-for="role in record.roles" :color="$page.props.roleConfig['color'][role.name]??'default' ">{{ $t(role.name) }}</a-tag>
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
                    class="flex flex-col gap-3 pr-4 pt-4 rounded-lg bg-slate-100">
                    <!-- <div class="flex">
                            <div class="flex-1 ">
                            </div>
                            <a-button  
                                class="!rounded-lg !text-red-800 !bg-red-50 !font-black"
                                v-if="modal.data.restPasswordStatus"  @click="dropFieldRestPassword">取消重設密碼
                            </a-button>
                    </div> -->
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
            <a-button  v-if="modal.mode=='EDIT' && !modal.data.restPasswordStatus" 
                class="!rounded-lg !text-blue-800 !bg-blue-50 !font-black mr-2" 
                @click="addFieldRestPassword">重設密碼
            </a-button>
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
            search:'',
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
                    width:150,
                },
                {   align:'center',
                    title: 'username',
                    dataIndex: 'username',
                },
                
                {
                    title: 'Roles',
                    dataIndex: 'roles',
                },
                // {
                //     title: 'Permissions',
                //     dataIndex: 'permissions',
                // },
                {
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
    computed:{
        viewUsers(){
            if(this.search.length==0){
                return this.users
            }
            return this.users.filter(x=> JSON.stringify(x).includes(this.search)) 
        }
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