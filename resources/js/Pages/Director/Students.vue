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
            <a-space direction="horizontal">
                <a-form-item label="" >
                    <a-select v-model:value="search.column" :options="searchColumns"/>
                </a-form-item>
                <a-form-item label="" >
                    <a-input v-model:value="search.content" />
                </a-form-item>
            </a-space>
            <a-button @click="onSearch">Search</a-button>
        </a-form>
        <div>
            <a-table :dataSource="students" :columns="columns">
                <template #bodyCell="{ column, text, record, index }">
                    <template v-if="column.dataIndex == 'operation'">
                        <inertia-link :href="route('director.students.show',record.id)" class="ant-btn">學生檔案</inertia-link>
                    </template>
                    <template v-if="column.dataIndex=='name_zh'">
                        <a :href="route('director.students.show',record.id)" target="_blank">{{record.name_zh}}</a>
                    </template>
                    <template v-else-if="column.dataIndex=='guardians'">
                        <ol>
                            <li v-for="guardian in record.guardians_with_relatives">
                                {{guardian.name_zh}}
                                ({{guardian.pivot.relationship}})
                            </li>
                        </ol>
                    </template>
                    <template v-else-if="column.dataIndex=='relatives'">
                        <ol>
                            <li v-for="guardian in record.guardians_with_relatives">
                                <ol v-if="guardian.students">
                                    <li v-for="std in guardian.students">
                                        <a :href="route('director.students.show',std.id)" target="_blank">{{std.name_zh}}</a>
                                    </li>
                                </ol>
                            </li>
                        </ol>
                    </template>
                    <template v-else-if="column.dataIndex=='klass'">
                        <ol>
                            <li v-for="klass in record.klasses">
                                {{klass.tag}}
                            </li>
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


export default {
    components: {
        AdminLayout
    },
    props: [],
    data() {
        return {
            students:[],
            search:{
                column:'name_zh',
                content:''
            },
            searchColumns:[
                {value:'name_zh',label:'中文姓名'},
                {value:'name_fn',label:'外文姓名'},
                {value:'id_num',label:'證件編號'}
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
        onSearch(){
            if(this.search.content==''){
                return false;
            }
            axios.post(route('director.student.search'), this.search)
            .then(resp => {
                console.log(resp.data)
                this.students=resp.data
                
            })


        }
    },
}
</script>

