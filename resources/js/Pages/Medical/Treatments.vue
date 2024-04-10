<template>
    <AdminLayout title="就診記錄" :breadcrumb="breadcrumb">
        <inertia-link :href="route('medical.treatments.create')" class="ant-btn ant-btn-primary">新增</inertia-link>
        <a-table :dataSource="treatments" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <inertia-link :href="route('medical.treatments.edit',record.id)" class="ant-btn">修改</inertia-link>
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
                {label:"健康狀況" ,url:route('medical')},
                {label:"就診記錄" ,url:null},
            ],
            dateFormat: 'YYYY-MM-DD',
            selectedGrade: 4,
            columns: [
                {
                    title: '分類',
                    dataIndex: 'category',
                }, {
                    title: '學生',
                    dataIndex: 'student_id',
                }, {
                    title: '標題操作',
                    dataIndex: 'title',
                }, {
                    title: '日期',
                    dataIndex: 'date',
                }, {
                    title: '操作',
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
