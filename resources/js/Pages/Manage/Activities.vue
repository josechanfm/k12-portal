<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                課外活動
            </h2>
        </template>
        <a-table :dataSource="activities" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <inertia-link :href="route('manage.activityStudents.index',record.id)" class="ant-btn">學生名單</inertia-link>
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
    props: ['terms', 'staffs', 'extracurriculars', 'activities', 'klasses', 'grades'],
    data() {
        return {
            dateFormat: 'YYYY-MM-DD',
            selectedGrade: 4,
            columns: [
                {
                    title: '學期',
                    dataIndex: 'term_id',
                }, {
                    title: '活動主題',
                    dataIndex: 'title_zh',
                }, {
                    title: '開始日期',
                    dataIndex: 'date_start',
                }, {
                    title: '結束日期',
                    dataIndex: 'date_end',
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
