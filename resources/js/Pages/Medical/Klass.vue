<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                健康記錄
            </h2>
        </template>
        <div class="py-5">
            <KlassSelector routePath="medical.klass" :param="[]" :currentKlass="klass" />
        </div>

        {{klass.tag}}
        <p>Physicals</p>
        <a-button class="ant-btn ant-btn-primary">Create </a-button>
        <a-table :dataSource="klass.physicals" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <a-button @click="editRecord(record)">修改</a-button>
                    <inertia-link :href="route('medical.physicals.show',record.id)">Link</inertia-link>
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
import dayjs from 'dayjs';
import KlassSelector from '@/Components/KlassSelector.vue';

export default {
    components: {
        AdminLayout,
        dayjs,
        KlassSelector
    },
    props: ['klass'],
    data() {
        return {
            dateFormat: 'YYYY-MM-DD',
            columns: [
                {
                    title: '分類',
                    dataIndex: 'category',
                }, {
                    title: '標題',
                    dataIndex: 'title',
                }, {
                    title: '日期',
                    dataIndex: 'date',
                }, {
                    title: '負責人',
                    dataIndex: 'responsible',
                }, {
                    title: '資料欄',
                    dataIndex: 'data_fields',
                }, {
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],

        }
    },
    created() {
    },
    mounted(){
    },
    methods: {
    },
}
</script>
