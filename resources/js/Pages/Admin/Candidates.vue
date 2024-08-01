<template>
    <AdminLayout title="入學報名列表">
        <a-button @click="onClickCreate()" type="primary">新增報名</a-button>
            <a-table :dataSource="candidates.data" :columns="columns" :pagination="pagination" @change="onPaginationChange" ref="dataTable">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <a-button @click="onClickEdit(record)">修改</a-button>
                        <a-button @click="onClickDelete(record)">刪除</a-button>
                        <a-button @click="onClickAccepted(record)">接收</a-button>
                        <a-button :href="route('admin.registrations.create',{candidate_id:record.id})" :disabled="!record.accepted">注冊</a-button>
                        <a-button :href="route('admin.enrollments.create',{student_id:record.student_id})" :disabled="record.student_id==null">分班</a-button>
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
import { router } from '@inertiajs/vue3';

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
                    title: '接收',
                    dataIndex: 'accepted',
                },{
                    title: '已注冊',
                    dataIndex: 'registered',
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
        onClickAccepted(record){
            record.accepted=true;
            this.$inertia.put(route('admin.candidate.accepted',record.id), record,{
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