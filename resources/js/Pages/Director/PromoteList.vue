<template>
    <AdminLayout title="升班預處理" :breadcrumb="breadcrumb">
        <a-table :dataSource="grades" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <template v-for="klass in record.klasses">
                        <inertia-link :href="route('director.klass.promotes.index',klass.id)" class="ant-btn">
                            {{klass.tag}}
                        </inertia-link>
                    </template>
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

export default {
    components: {
        AdminLayout
    },
    props: ['years','nextYear','grades','nextGrades'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台" ,url:route('director.dashboard')},
                {label:"升留班" ,url:null},
            ],
            columns: [
                {
                    title: 'Tag',
                    dataIndex: 'tag',
                }, {
                    title: 'Klass Num',
                    dataIndex: 'klass_num',
                }, {
                    title: 'Klass Heads',
                    dataIndex: 'klass_heads',
                }, {
                    title: 'Promoted count',
                    dataIndex: 'promoted_count',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ]

        }
    },
    methods: {
    }
}
</script>

