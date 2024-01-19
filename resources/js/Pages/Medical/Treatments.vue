<template>
    <AdminLayout title="就診記錄" :breadcrumb="breadcrumb">
        <inertia-link :href="route('medical.treatments.create')" class="ant-btn ant-btn-primary">Create</inertia-link>
        <a-table :dataSource="treatments" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <inertia-link :href="route('medical.treatments.edit',record.id)" class="ant-btn">edit</inertia-link>
                </template>
                <template v-else>
                    {{ record[column.dataIndex] }}
                </template>
            </template>
        </a-table>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { affixProps } from 'ant-design-vue/lib/affix';
import dayjs from 'dayjs';

export default {
    components: {
        AdminLayout,
        dayjs,
    },
    props: ['treatments'],
    data() {
        return {
            breadcrumb:[
                {label:"Medical" ,url:route('medical')},
                {label:"Treatments" ,url:null},
            ],
            dateFormat: 'YYYY-MM-DD',
            selectedGrade: 4,
            columns: [
                {
                    title: 'Student',
                    dataIndex: 'student_id',
                }, {
                    title: 'Category',
                    dataIndex: 'category',
                }, {
                    title: '日期',
                    dataIndex: 'date',
                }, {
                    title: 'Title',
                    dataIndex: 'title',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ],

        }
    },
    created() {
        // dayjs.locale('en');
    },
    mounted(){

    },
    methods: {
    },
}
</script>
