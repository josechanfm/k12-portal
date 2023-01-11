<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Teacher
            </h2>
        </template>
        <div>
            <a-typography-title :level="3">{{ teacher.name_zh }} ({{ teacher.staff_code }})</a-typography-title>
            <a-table :dataSource="teacher.courses" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='operation'">
                    <Link :href="'score?kid='+record.klass_id + '&cid='+record.id" method="get" as="button" type="button">Score</Link>
                </template>
                <template v-else>
                    {{record[column.dataIndex]}}
                </template>
            </template>
        </a-table>


        </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link } from '@inertiajs/inertia-vue3';

export default {
    components: {
        AdminLayout, Link
    },
    props: ['teacher'],
    data() {
        return {
            columns:[
                {
                    title: 'Abbr',
                    dataIndex: 'abbr',
                },{
                    title: 'Title',
                    dataIndex: 'title_zh',
                },{
                    title: 'Type',
                    dataIndex: 'type',
                },{
                    title: 'Stream',
                    dataIndex: 'stream',
                },{
                    title: 'Elective',
                    dataIndex: 'elective',
                },{
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ]
        }
    },
    methods: {
    },
}
</script>

