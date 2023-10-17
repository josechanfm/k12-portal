<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                學習主題
            </h2>
        </template>
        <a-typography-title :level="3">年級: {{ klass.tag }}</a-typography-title>
        
        <button @click="onClickCreate()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">新增主題</button>
        <a-table :dataSource="themes" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='operation'">
                    <a-button @click="onClickEdit(record)" :style="'Edit'">修改</a-button>
                    <a-button @click="onClickDelete(record)" :style="'Delete'">刪除</a-button>
                </template>
                <template v-else>
                    {{record[column.dataIndex]}}
                </template>
            </template>
        </a-table>

        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="ant-table-thead">
                        <tr>
                            <th class="ant-table-cell">基力</th>
                            <th class="ant-table-cell">細分</th>
                        </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <tr v-for="topic in topicTemplates">
                                <td>{{ topic.section }}</td>
                                <td>{{ topic.title }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" >
            <a-form
                :model="modal.data"
                name="Staff"
                ref="modalRef"
                :rules="rules"
                :validate-messages="validateMessages"
                :label-col="{ span: 4 }"
                :wrapper-col="{ span: 20 }"
            >
                <a-form-item label="學段" name="term_id">
                    <a-select v-model:value=modal.data.term_id :options="yearTerms"/>
                </a-form-item>
                <a-form-item label="主題名稱" name="title">
                    <a-input v-model:value="modal.data.title" />
                </a-form-item>
            </a-form>         
            <template #footer>
                <a-button key="back" @click="modalCancel()">Return</a-button>
                <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
                <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary" @click="storeRecord()">Create</a-button>
            </template>
   
        </a-modal>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['yearTerms','klass','themes','topicTemplates'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Staffs',
                data:{}
            },
            columns:[
                {
                    title: '學段',
                    dataIndex: 'term_id',
                },{
                    title: '主題名稱',
                    dataIndex: 'title',
                },{
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ],
            rules:{
                term_id:{
                    required:true,
                },
                title:{
                    required:true,
                }
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

        }
    },
    methods: {
        onClickCreate(){
            this.modal.data={}
            this.modal.data.klass_id=this.klass.id
            this.modal.title="新增"
            this.modal.mode='CREATE'
            this.modal.isOpen=true
        },

        onClickEdit(theme){
            this.modal.data={...theme}
            this.modal.isOpen=true
            this.modal.mode='EDIT'
            this.modal.title="修改"
        },
        updateRecord(){
            console.log('update')
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.put(route('admin.klass.themes.update',[this.modal.data.klass_id,this.modal.data.id]), this.modal.data,{
                    onSuccess:(page)=>{
                        this.modal.data={}
                        this.modal.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });

        },
        storeRecord(){
            console.log('save')
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.post(route('admin.klass.themes.store',this.modal.data.klass_id), this.modal.data,{
                    onSuccess:(page)=>{
                        this.modal.data={}
                        this.modal.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });

        },
        onClickDelete(){

        },
        modalCancel(){
            this.modal.isOpen=false
        }


    },
}
</script>