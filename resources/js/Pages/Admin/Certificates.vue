<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                課外活動
            </h2>
        </template>
        <a-button @click="createRecord" type="primary">開設課外活動</a-button>
        <a-table :dataSource="certificates" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex == 'operation'">
                    <a-button @click="editRecord(record)">Edit</a-button>
                </template>
                <template v-else-if="column.dataIndex == 'title'">
                    {{ record.certificate_meta.label }}
                </template>
                <template v-else-if="column.dataIndex == 'year'">
                    {{ record.year_id }}
                </template>
                <template v-else-if="column.dataIndex == 'term'">
                    {{ record.term_id }}
                </template>
                <template v-else-if="column.dataIndex == 'klass'">
                    {{ record.klass_id }}
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
import dayjs from 'dayjs';

export default {
    components: {
        AdminLayout,
        dayjs,
    },
    props: ['certificates'],
    data() {
        return {
            dateFormat:'YYYY-MM-DD',
            modal: {
                mode: null,
                isOpen: false,
                title: '課外活動',
                data: {}
            },
            columns:[
                {
                    title: 'Certi title',
                    dataIndex: 'title',
                },{
                    title: 'Student name display',
                    dataIndex: 'name_display',
                },{
                    title: 'Year',
                    dataIndex: 'year',
                },{
                    title: 'Term',
                    dataIndex: 'term',
                },{
                    title: 'Klass',
                    dataIndex: 'klass',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],

        }
    },
    created(){
        dayjs.locale('en');
    },

    methods: {
        closeModal() {
            this.isOpen = false;
            this.reset();
            this.editMode = false;
        },
        createRecord() {
            this.modal.data = {};
            this.modal.mode = 'CREATE';
            this.modal.title = "開設課外活動";
            this.modal.isOpen = true;
        },
        editRecord(record) {
            this.modal.data = { ...record };
            this.modal.mode = 'EDIT';
            this.modal.title = "修改課外活動";
            this.modal.isOpen = true;
        },
        onFinish(values){
            if(this.modal.mode=='EDIT'){
                this.$inertia.put(route('admin.activities.update',this.modal.data.id),this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }
            if(this.modal.mode=='CREATE'){
                this.$inertia.post(route('admin.activities.store'),this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }
        },
    },
}
</script>
