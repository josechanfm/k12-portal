<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Students
            </h2>
        </template>
        <div>
            <a-table :dataSource="students.data" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='operation'">
                    <Link :href="'student/'+record.id " method="get" as="button" type="button">Profile</Link>
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
    props: ['students'],
    data() {
        return {
            columns:[
                {
                    title: 'Name zh',
                    dataIndex: 'name_zh',
                },{
                    title: 'Name fn',
                    dataIndex: 'name_fn',
                },{
                    title: 'Gender',
                    dataIndex: 'gender',
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

