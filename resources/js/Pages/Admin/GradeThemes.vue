<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                學習主題
            </h2>
        </template>
        <a-typography-title :level="3">年級: {{ grade.tag }}</a-typography-title>
        <a-typography-title :level="3">年級全稱: {{ grade.title_zh }}</a-typography-title>
        <a-table :dataSource="topics" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='theme'">
                    {{ record.theme.title_zh }}
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
    props: ['grade','topics'],
    data() {
        return {
            columns:[
                {
                    title: '項目',
                    dataIndex: 'theme',
                },{
                    title: '範疇',
                    dataIndex: 'title_zh',
                },
            ],

        }
    },
    methods: {
    },
}
</script>