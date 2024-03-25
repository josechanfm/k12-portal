<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Students
            </h2>
        </template>
        <div>
            <a-table :dataSource="tasks" :columns="columns">
                <template #bodyCell="{ column, text, record, index }">
                    <template v-if="column.dataIndex == 'action'">
                        <a-radio-group v-model:value="record.response" @change="onChangeTaskAction(record)">
                            <a-radio-button v-for="action in record.actions"
                                :value="action.response">{{ responseActionlabel(action) }}</a-radio-button>
                        </a-radio-group>
                    </template>
                    <template v-if="column.dataIndex == 'title_zh'">
                        {{ record.workflow.title_zh }}
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
import { Link } from '@inertiajs/inertia-vue3';

export default {
    components: {
        AdminLayout, Link
    },
    props: ['tasks'],
    data() {
        return {
            columns: [
                {
                    title: 'Title',
                    dataIndex: 'title_zh',
                }, {
                    title: 'Description',
                    dataIndex: 'description',
                }, {
                    title: 'Start Date',
                    dataIndex: 'start_date',
                }, {
                    title: 'Due Date',
                    dataIndex: 'due_date',
                }, {
                    title: 'Status',
                    dataIndex: 'status',
                }, {
                    title: 'Action',
                    dataIndex: 'action',
                }
            ]
        }
    },
    methods: {
        onChangeTaskAction(record) {
            console.log(record);
            this.$inertia.put(route("director.tasks.update", record), record, {
                onSuccess: (page) => {
                    console.log(page);
                },
                onError: (error) => {
                    console.log(error);
                }
            })
        },
        responseActionlabel(action) {
            if(action.label==null){
                if(action.response=='responsed') return '批准'
                if(action.response=='rejected') return '不批准'
                if(action.response=='reworked') return '退回'
            }
            return action.label;
        }
    },
}
</script>

