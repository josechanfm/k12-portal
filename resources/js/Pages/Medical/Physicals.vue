<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                健康記錄
            </h2>
        </template>
        <p>Klass: {{physical.klass.tag}}</p>
        <p>Title: {{physical.title}}</p>
        <p>Data: {{physical.date}}</p>
        <ol>
            <li v-for="record in physical.strengths">{{record.klass_student_id}}/{{record.field_name}}:{{record.value}}</li>
        </ol>
        <a-table :dataSource="physical.strengths" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <a-button @click="editRecord(record)">修改</a-button>
                    <inertia-link :href="route('medical.physicals.index')">Link</inertia-link>
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
    props: ['physical'],
    data() {
        return {
            dateFormat: 'YYYY-MM-DD',
            columns: [
                {
                    title: 'Klass student id',
                    dataIndex: 'klass_student_id',
                }, {
                    title: 'Field Name',
                    dataIndex: 'field_name',
                }, {
                    title: 'Value',
                    dataIndex: 'value',
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
