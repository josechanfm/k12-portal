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
        <a-table :dataSource="grades" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='operation'">
                    <a-button @click="editRecord(record)">Edit</a-button>
                    <a-button @click="deleteRecord(record.id)">Delete</a-button>
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

export default {
    components: {
        AdminLayout,
    },
    props: ['grades','errors'],
    data() {
        return {
            columns:[
                {
                    title: 'Level',
                    dataIndex: 'level',
                },{
                    title: 'Initial',
                    dataIndex: 'initial',
                },{
                    title: 'Tag',
                    dataIndex: 'tag',
                },{
                    title: 'Title Zh',
                    dataIndex: 'title_zh',
                },{
                    title: 'Version',
                    dataIndex: 'version',
                },{
                    title: 'Active',
                    dataIndex: 'version',
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