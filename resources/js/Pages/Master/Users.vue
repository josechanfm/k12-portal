<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Uers
            </h2>
        </template>
        <button @click="createRecord()" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">
            Create User
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
                :model="modal.data"
                name="Roles"
                ref="modalRef"
                :rules="rules"
                :validate-messages="validateMessages"
            >
                <a-form-item label="用戶名稱" name="name">
                    <a-input v-model:value="modal.data.name" />
                </a-form-item>

                <a-form-item label="用戶名稱" name="roles">
                    <a-checkbox-group v-model:value="modal.data.newRoles" name="checkboxgroup" :options="roles.map(
                        role=>({ value:role.id, label:role.name })
                    )" />
                </a-form-item>
                
                {{ modal.data }}
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
import { UserSwitchOutlined } from '@ant-design/icons-vue';

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
            this.modal.isOpen=false;
            this.modal.mode='CLOSE';

        },
        storeRecord(record){
            this.modal.isOpen=false;
            this.modal.mode='CLOSE';

        },
        modalCancel(){
            this.modal.isOpen=false;
            this.modal.mode='CLOSE';
        }
    },
}
</script>