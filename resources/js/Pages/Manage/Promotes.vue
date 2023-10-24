<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                升班操作
            </h2>
        </template>
        <hr/>
            <a-table :dataSource="grades" :columns="columns">
                <template #bodyCell="{ column, text, record, index }">
                    <template v-if="column.dataIndex == 'operation'">
                        <template v-for="klass in record.klasses">
                            <inertia-link :href="route('manage.klass.promotes.index',klass.id)" class="ant-btn">
                                {{klass.tag}}
                            </inertia-link>
                        </template>
                    </template>
                    <template v-else>
                        {{ record[column.dataIndex] }}
                    </template>
                </template>
            </a-table>

        <ul>
            <li v-for="grade in grades">
                {{ grade }}
                <hr>
            </li>
        </ul>
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

