<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Roles
            </h2>
        </template>
        <a-table :dataSource="roles" :columns="columns">
        </a-table>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['roles'],
    data() {
        return {
            modal: {
                mode: null,
                isOpen: false,
                title: 'Configs',
                data: {}
            },
            columns:[
                {
                    title: 'Name',
                    dataIndex: 'name',
                },{
                    title: 'Guard',
                    dataIndex: 'guard_name',
                }
            ]
        }
    },
    mounted() {
    },
    methods: {
    },
}
</script>