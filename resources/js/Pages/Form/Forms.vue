<template>

    <WebLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                {{$t('forms')}}
            </h2>
        </template>

        <div class="max-w-6xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow sm:rounded-lg ">
                <a-table :dataSource="forms" :columns="columns">
                    <template #bodyCell="{column, text, record, index}">
                        <template v-if="column.dataIndex=='operation'">
                            <inertia-link :href="route('form.show',{t:record.uuid})">填寫</inertia-link>
                        </template>
                        <template v-else-if="column.type=='yesno'">
                            <span v-if="record[column.dataIndex]==1">
                                ✔
                            </span>
                            <span v-else>
                                --
                            </span>
                        </template>
                        <template v-else>
                            {{record[column.dataIndex]}}
                        </template>
                    </template>
                </a-table>
            </div>
        </div>

    </WebLayout>

</template>

<script>
import WebLayout from '@/Layouts/WebLayout.vue';

export default {
    components: {
        WebLayout,
    },
    props: ['forms'],
    data() {
        return {
            currentStep:1,
            items:[
                {
                    title: 'Login',
                    status: 'finish',
                },
                {
                    title: 'Verification',
                    status: 'finish',
                },
                {
                    title: 'Pay',
                    status: 'process',
                },
                {
                    title: 'Done',
                    status: 'wait',
                },
            ],
            columns:[
                {
                    title: '名稱',
                    dataIndex: 'title',
                },{
                    title: '需要登入',
                    dataIndex: 'require_login',
                    type:'yesno'
                },{
                    title: '只供會員',
                    dataIndex: 'for_member',
                    type:'yesno'
                },{
                    title: '操作',
                    dataIndex: 'operation',
                    key: 'operation',
                },
            ],
            rules:{
                field:{required:true},
                label:{required:true},
            },
            validateMessages:{
                required: '${label} is required!',
                types: {
                    email: '${label} is not a valid email!',
                    number: '${label} is not a valid number!',
                },
                number: {
                    range: '${label} must be between ${min} and ${max}',
                },
            },
            labelCol: {
                style: {
                width: '150px',
                },
            },
        }
    },
    created(){
    },
    methods: {
    },
}
</script>


<style>
.fade-in-out {
  opacity: 0;
  animation: fade-in 1s ease-in forwards, fade-out 4s 1s ease-out forwards;
}
</style>