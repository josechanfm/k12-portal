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
            <a-form-item label="" >
                <a-select v-model:value="search.column" :options="searchColumns"/>
            </a-form-item>
            <a-form-item label="" >
                <a-input v-model:value="search.content" />
            </a-form-item>
            <a-button @click="onSearch">Search</a-button>
        </a-form>


        <div>

            <a-table :dataSource="foundStudents" :columns="columns">
                <template #bodyCell="{ column, text, record, index }">
                    <template v-if="column.dataIndex == 'operation'">
                        <a-button @click="clickLinkSibling(record)">Link Sibling</a-button>
                    </template>
                    <template v-else>
                        {{ record[column.dataIndex] }}
                    </template>
                </template>
            </a-table>

            <div class="ant-table ant-table-empty"><!---->
                <div class="ant-table-container">
                    <div class="ant-table-content">
                        <table style="table-layout: auto;">
                            <thead class="ant-table-thead">
                                <tr>
                                    <th class="ant-table-cell" colstart="0" colend="0"><!---->中文姓名<!----></th>
                                    <th class="ant-table-cell" colstart="1" colend="1"><!---->外文姓名<!----></th>
                                    <th class="ant-table-cell" colstart="2" colend="2"><!---->性別<!----></th>
                                    <th class="ant-table-cell" colstart="4" colend="4"><!---->兄弟姊要<!----></th>
                                    <th class="ant-table-cell" colstart="3" colend="3"><!---->家長/監護人<!----></th>
                                    <th class="ant-table-cell" colstart="5" colend="5"><!---->就讀班別<!----></th>
                                    <th class="ant-table-cell" colstart="6" colend="6"><!---->操作<!----></th>
                                </tr>
                            </thead>
                            <tbody class="ant-table-tbody"><!---->
                                <tr class="ant-table" v-for="sibling in siblings">
                                    <td class="ant-table-cell">{{ sibling.name_zh }}</td>
                                    <td class="ant-table-cell">{{ sibling.name_fn }}</td>
                                    <td class="ant-table-cell">{{ sibling.gender }}</td>
                                    <td class="ant-table-cell">{{ sibling.siblings }}</td>
                                    <td class="ant-table-cell">
                                        <ol>
                                            <li v-for="guardian in sibling.guardians">
                                                {{ guardian.name_zh }}
                                            </li>
                                        </ol>
                                    </td>
                                    <td class="ant-table-cell">
                                        <ol>
                                            <li v-for="klass in sibling.klasses">
                                                {{ klass.school_year }}-{{ klass.tag }}
                                            </li>
                                        </ol>
                                    </td>
                                    <td class="ant-table-cell">operation</td>
                                </tr>
                            </tbody><!---->
                        </table>
                    </div>
                </div><!---->
            </div>



        </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link } from '@inertiajs/inertia-vue3';
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
                    title: '兄弟姊要',
                    dataIndex: 'relatives',
                }, {
                    title: '就讀班別',
                    dataIndex: 'klass',
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
            this.$inertia.post(route('director.student.linkSiblings'),{
                student:this.student,
                sibling:sibling,
            },
            onSuccess: (page) => {
                    this.init()                    
                },
            onError: (error) => {
                console.log(error);
            }
)           })

            console.log(this.student.sibling_uuid);
        }

    },
}
</script>
