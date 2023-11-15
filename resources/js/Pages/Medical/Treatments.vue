<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Medial Treatment
            </h2>
        </template>
        <inertia-link :href="route('medical.treatments.create')" type="primary" class="ant-btn">Create</inertia-link>
        <a-table :dataSource="treatments" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <inertia-link :href="route('manage.activity.students',record.id)" class="ant-btn">學生名單</inertia-link>
                    <inertia-link :href="route('manage.activity.students.scores',record.id)" class="ant-btn">Scores</inertia-link>
                    <a-button>Report</a-button>
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
