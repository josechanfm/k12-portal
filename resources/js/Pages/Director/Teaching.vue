<template>
    <AdminLayout title="任教科目" :breadcrumb="breadcrumb">
        <div>
            <a-typography-title :level="3">{{ teacher.name_zh }} ({{ teacher.staff_code }})</a-typography-title>
            <a-table :dataSource="teacher.courses" :columns="columns">
                <template #bodyCell="{ column, text, record, index }">
                    <template v-if="column.dataIndex == 'operation'">
                        <a-button as="link" :href="route('director.course.scores.index', record.id)"
                            class="ant-btn">學分</a-button>
                    </template>
                    <template v-else>
                        {{ record[column.dataIndex] }}
                    </template>
                </template>
            </a-table>
        </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link } from '@inertiajs/vue3';

export default {
    components: {
        AdminLayout, Link
    },
    props: ['teacher'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('director.dashboard')},
                {label:'老師' ,url:route('director.teachers.index')},
                {label:'任教科目' ,url:null}
            ],
            columns: [
                {
                    title: 'Code',
                    dataIndex: 'code',
                }, {
                    title: 'Title',
                    dataIndex: 'title_zh',
                }, {
                    title: 'Type',
                    dataIndex: 'type',
                }, {
                    title: 'Stream',
                    dataIndex: 'stream',
                }, {
                    title: 'Elective',
                    dataIndex: 'elective',
                }, {
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
