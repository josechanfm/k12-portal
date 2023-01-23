<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Grades in the year
            </h2>
        </template>
        <button @click="createRecord()" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">
            Create grade in the year
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
        </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

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
                title:'Score Column',
                data:{}
            },
            columns:[
                {
                    title: 'Name',
                    dataIndex: 'name',
                },{
                    title: 'Gard',
                    dataIndex: 'gard',
                },{
                    title: 'Roles',
                    dataIndex: 'roles',
                },{
                    title: 'Permissions',
                    dataIndex: 'permissions',
                },{
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ]
        }
    },
    mounted() {
    },
    methods: {
        editRecord(record){
            console.log('edit record ');
            console.log(record);
        },
        createRecord(){
            console.log('create record');
        },
        deleteRecord(recordid){
            console.log('delte record '+recordId);
        }
    },
}
</script>