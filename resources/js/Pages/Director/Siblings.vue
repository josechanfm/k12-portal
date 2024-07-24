<template>
    <AdminLayout title="學人個人檔案">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Students
            </h2>
        </template>
        {{ student.name_zh }}
        {{ student.sibling_uuid }}
        <ol>
            <li v-for="klass in student.klasses">
                {{ klass.school_year }}-{{ klass.tag }}
            </li>
        </ol>


        <a-form
            ref="formRef"
            name="advanced_search"
            class="ant-advanced-search-form"
            :model="search"
        >
            <a-space direction="horizontal">
                <a-form-item label="" >
                <a-select v-model:value="search.column" :options="searchColumns"/>
                </a-form-item>
                <a-form-item label="" >
                    <a-input v-model:value="search.content" />
                </a-form-item>

            </a-space>
            <a-button @click="onSearch">搜尋</a-button>
        </a-form>


        <div>

            <a-table :dataSource="foundStudents" :columns="columns">
                <template #bodyCell="{ column, text, record, index }">
                    <template v-if="column.dataIndex == 'operation'">
                        <a-button @click="clickLinkSibling(record)">進行連結</a-button>
                    </template>
                    <template v-else-if="column.dataIndex == 'guardians'">
                        <ol>
                            <li v-for="guardian in record.guardians">{{ guardian.name_zh }}</li>
                        </ol>
                    </template>
                    <template v-else-if="column.dataIndex == 'klasses'">
                        <ol>
                            <li v-for="klass in record.klasses">{{ klass.school_year }} - {{ klass.tag }}</li>
                        </ol>
                    </template>
                    <template v-else>
                        {{ record[column.dataIndex] }}
                    </template>
                </template>
            </a-table>


            <a-table :dataSource="siblings" :columns="columns">
                <template #bodyCell="{ column, text, record, index }">
                    <template v-if="column.dataIndex == 'guardians'">
                        <ol>
                            <li v-for="guardian in record.guardians">{{ guardian.name_zh }}</li>
                        </ol>
                    </template>
                    <template v-else-if="column.dataIndex == 'klasses'">
                        <ol>
                            <li v-for="klass in record.klasses">{{ klass.school_year }} - {{ klass.tag }}</li>
                        </ol>
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
import { Link } from '@inertiajs/vue3';
import axios from 'axios';

export default {
    components: {
        AdminLayout, Link
    },
    props: ['student', 'siblings'],
    data() {
        return {
            foundStudents: [],
            search: {
                column: 'name_zh',
                content: ''
            },
            searchColumns: [
                { value: 'name_zh', label: '中文姓名' },
                { value: 'name_fn', label: '外文姓名' },
                { value: 'id_num', label: '證件編號' }
            ],
            columns: [
                {
                    title: '中文姓名',
                    dataIndex: 'name_zh',
                }, {
                    title: '外文姓名',
                    dataIndex: 'name_fn',
                }, {
                    title: '性別',
                    dataIndex: 'gender',
                }, {
                    title: '家長/監護人',
                    dataIndex: 'guardians',
                }, {
                    title: '兄弟姊妹',
                    dataIndex: 'sibling_uuid',
                }, {
                    title: '就讀班別',
                    dataIndex: 'klasses',
                }, {
                    title: '操作',
                    dataIndex: 'operation',
                }
            ]
        }
    },
    methods: {
        onSearch() {
            if (this.search.content == '') {
                return false;
            }
            axios.post(route('director.student.search'), this.search)
            .then(resp => {
                console.log(resp.data)
                this.foundStudents = resp.data

            })
        },
        clickLinkSibling(sibling){
            this.$inertia.patch(route('director.student.joinSibling',this.student.id), sibling, {
                onSuccess: (page) => {
                    console.log(page)
                },
                onError: (error) => {
                    console.log(error);
                }
            })

            console.log(this.student.sibling_uuid);
        }

    },
}
</script>
