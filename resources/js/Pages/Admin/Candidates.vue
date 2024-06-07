<template>
    <AdminLayout title="入學報名">
        <button @click="onClickCreate()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">新增報名</button>
            <a-table :dataSource="candidates.data" :columns="columns" :pagination="pagination" @change="onPaginationChange" ref="dataTable">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <ButtonLink @click="onClickEdit(record)" :style="'Edit'">修改</ButtonLink>
                        <ButtonLink @click="onClickDelete(record)" :style="'Delete'">刪除</ButtonLink>
                        <ButtonLink @click="onClickEnroll(record)" :style="'Default'">Enroll</ButtonLink>
                        <inertia-link :href="route('admin.registrations.create',{candidate_id:record.id})">registration</inertia-link>
                    </template>
                    <template v-else-if="column.dataIndex=='start_grade'">
                        {{ gradesKlasses.find(g=>g.id==text).tag }}
                    </template>
                    <template v-else-if="column.dataIndex=='username'">
                        <span v-if="record.user">
                            {{ record.user.username }}
                        </span>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                        
                </template>
            </a-table>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import {CheckSquareOutlined, ConsoleSqlOutlined, StopOutlined} from '@ant-design/icons-vue';
import { extractIdentifiers } from '@vue/compiler-core';
import { Inertia } from '@inertiajs/inertia';

export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined
    },
    props: ['gradesKlasses','candidates'],
    data() {
        return {
            pagination:{
                total: this.candidates.total,
                current:this.candidates.current_page,
                pageSize:this.candidates.per_page,
            },
            columns:[
                {
                    title: '姓名(中文)',
                    dataIndex: 'name_zh',
                },{
                    title: '姓名(外文)',
                    dataIndex: 'name_fn',
                },{
                    title: '性別',
                    dataIndex: 'gender',
                },{
                    title: '入讀年級',
                    dataIndex: 'start_grade',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],
        }
    },
    created(){
       
    },
    methods: {
        onPaginationChange(page, filters, sorter){
            this.$inertia.get(route('admin.candidates.index'),{
                page:page.current,
                per_page:page.pageSize,
                //filter:filters,
                //sorter:sorter
            },{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        },
        onClickCreate(record){
            this.$inertia.get(route('admin.candidates.create'),{
                onSuccess:(page)=>{
                    console.log(page.data)
                },
                onError: (error)=>{
                    console.log(error)
                }
            });
        },
        onClickEdit(record){
            this.$inertia.get(route('admin.candidates.edit',record.id),{
                onSuccess:(page)=>{
                    console.log(page.data)
                },
                onError: (error)=>{
                    console.log(error)
                }
            });
        },
        onClickDelete(record){
            if (!confirm('是否確定刪除?')) return;
            this.$inertia.delete('/admin/---/' + record.id,{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        },
        onClickEnroll(record){
            console.log(record);
            record.enroll_confirm=true;
            this.$inertia.put(route('admin.candidate.enroll',record.id), record,{
                onSuccess:(page)=>{
                    console.log(page)
                    record.enroll_confirm=false
                },
                onError:(error)=>{
                    record.enroll_confirm=false
                    console.log(error);
                }
            });

        },

    },
}
</script>