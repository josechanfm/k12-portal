<template>
    <AdminLayout title="學人個人檔案">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Students
            </h2>
        </template>
        <a-form
            ref="formRef"
            name="advanced_search"
            class="ant-advanced-search-form"
            :model="search"
        >
            <a-form-item label="姓名" >
                <a-input v-model:value="search.content" />
            </a-form-item>
        </a-form>
        
        <div>
            <a-table :dataSource="students" :columns="columns">
                <template #bodyCell="{ column, text, record, index }">
                    <template v-if="column.dataIndex == 'operation'">
                        <Link :href="'student/' + record.id" method="get" as="button" type="button">Profile</Link>
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
    props: ['students'],
    data() {
        return {
            serach:{
                content:null
            },
            columns: [
                {
                    title: 'Name zh',
                    dataIndex: 'name_zh',
                }, {
                    title: 'Name fn',
                    dataIndex: 'name_fn',
                }, {
                    title: 'Gender',
                    dataIndex: 'gender',
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

