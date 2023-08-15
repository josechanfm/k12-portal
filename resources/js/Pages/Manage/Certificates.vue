<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                課外活動
            </h2>
        </template>
        <br>
            <template v-for="grade in grades">
                <a-button :value="grade.id" type="primary" class="mr-3 w-15" @click="selectedGrade = grade.id">
                    {{ grade.tag}}
                </a-button>
            </template>
            <p>&nbsp;</p>
            <template v-for="klass in klasses">
                <a-button v-if="klass.grade_id == selectedGrade" :value="klass.id" type="primary" class="mr-3 w-15"
                    @click="getStudentsByKlass(klass)">{{ klass.tag }}</a-button>
            </template>
            <p>&nbsp;</p>
            <template v-for="certificate in certificates">
                <a-button :value="certificate.value" type="primary" class="mr-3 w-15"
                    @click="getStudentsByKlass(klass)">{{ certificate.label }}</a-button>
            </template>

        <a-table :dataSource="students" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <inertia-link :href="route('manage.activity.students',record.id)" class="ant-btn">學生名單</inertia-link>
                    <inertia-link :href="route('manage.activity.students.scores',record.id)" class="ant-btn">Scores</inertia-link>
                    <a-button>Report</a-button>
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
    props: ['certificates','terms', 'grades', 'klasses'],
    data() {
        return {
            dateFormat: 'YYYY-MM-DD',
            selectedGrade: 4,
            students:[],
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
