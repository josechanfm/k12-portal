<template>
    <AdminLayout title="學年" :breadcrumb="breadcrumb">
        <button @click="createRecord()" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">
            創建新學年
        </button>
            <a-table :dataSource="years" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <inertia-link :href="route('admin.year.grades.index',record.id)" class="ant-btn">年級</inertia-link>
                        <a-button @click="editRecord(record)">修改</a-button>
                        <a-button @click="deleteRecord(record)">刪除</a-button>
                        <a-button @click="lockTranscript(record)">鎖定成積表</a-button>
                    </template>
                    <template v-else-if="column.dataIndex=='grade_group'">
                        <a-tag v-for="item in record[column.dataIndex]" 
                            :color="item.initial=='P'?'blue':item.initial=='S'?'green':'cyan'">{{item.initial}}:{{item.count}}</a-tag>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="60%" @update="updateRecord(modalForm)" @onCancel="closeModal()">
            <a-form
            ref="modalRef"
            :model="modal.data"
            name="year"
            :label-col="{ span: 8 }"
            :wrapper-col="{ span: 16 }"
            autocomplete="off"
            :rules="rules"
            :validate-messages="validateMessages"
            @validate="handleValidate"
            @finish="onFinish"
            @onFinishFailed="onFinishFailed"
        >
            <a-form-item label="學年編號" name="code">
                <a-input v-model:value="modal.data.code" style="width: 100px"/>
            </a-form-item>
            <a-form-item label="學年標題" name="title">
                <a-input v-model:value="modal.data.title" />
            </a-form-item>
            <a-form-item label="時期" name="period">
                <a-range-picker v-model:value="modal.data.period" />
            </a-form-item>
            <a-form-item label="開始學段" name="current_term">
                <a-radio-group v-model:value="modal.data.current_term">
                    <template v-for="term in yearTerms">
                        <a-radio-button :value="term.value">{{term.label}}</a-radio-button>
                    </template>
                </a-radio-group>
            </a-form-item>
            <div v-if="modal.mode=='CREATE'">
                <a-form-item label="簡介" name="description">
                    <a-textarea v-model:value="modal.data.description" />
                </a-form-item>

                <a-divider orientation="left">幼雅園</a-divider>
                <a-row>
                    <a-col :span="8"></a-col>
                    <a-col :span="8">
                        <a-form-item label="年級數" name="kgrade">
                            <a-select
                            v-model:value="modal.data.kgrade"
                            :options="kgradeOptions"
                            style="width: 80px"
                            disabled 
                            />
                        </a-form-item>
                    </a-col>
                    <a-col :span="8">
                        <a-form-item label="班級數" name="kklass">
                            <a-select
                            v-model:value="modal.data.kklass"
                            :options="kklassOptions"
                            style="width: 80px"
                            />
                        </a-form-item>
                    </a-col>
                </a-row>
                <a-divider orientation="left">小學</a-divider>
                <a-row>
                    <a-col :span="8"></a-col>
                    <a-col :span="8">
                        <a-form-item label="年級數" name="pgrade">
                            <a-select
                            v-model:value="modal.data.pgrade"
                            :options="pgradeOptions"
                            style="width: 80px"
                            disabled 
                            />
                        </a-form-item>
                    </a-col>
                    <a-col :span="8">
                        <a-form-item label="班級數" name="pklass">
                            <a-select
                            v-model:value="modal.data.pklass"
                            :options="pklassOptions"
                            style="width: 80px"
                            />
                        </a-form-item>
                    </a-col>
                </a-row>
                <a-divider orientation="left">中學</a-divider>
                <a-row>
                    <a-col :span="8"></a-col>
                    <a-col :span="8">
                        <a-form-item label="年級數" name="sgrade">
                            <a-select
                            v-model:value="modal.data.sgrade"
                            :options="sgradeOptions"
                            style="width: 80px"
                            disabled 
                            />
                        </a-form-item>
                    </a-col>
                    <a-col :span="8">
                        <a-form-item label="班級數" name="sklass">
                            <a-select
                            v-model:value="modal.data.sklass"
                            :options="sklassOptions"
                            style="width: 80px"
                            />
                        </a-form-item>
                    </a-col>
                </a-row>
            </div>
        


        </a-form>
        <template #footer>
            <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary"  @click="updateRecord(modalForm)">Update</a-button>
            <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary"  @click="storeRecord(modalForm)">Add</a-button>
        </template>
    </a-modal>    
    <!-- Modal End-->
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Modal } from 'ant-design-vue';
import { ExclamationCircleOutlined } from '@ant-design/icons-vue';
import { ref, createVNode } from 'vue';
import dayjs from 'dayjs';

export default {
    components: {
        AdminLayout, Modal, createVNode, ExclamationCircleOutlined
    },
    props: ['years','param','yearTerms'],
    data() {
        return {
            breadcrumb:[
                {label:"Admin" ,url:route('admin')},
                {label:"Years" ,url:null},
            ],
            kgrade:0,
            kklass:0,
            dataSource:[],
            dateFormat:'YYYY-MM-DD',
            modal:{
                mode:null,
                isOpen:false,
                data:{},
                title:'Years'
            },
            columns:[
                {
                    title: 'Code',
                    dataIndex: 'code',
                    key: 'code',
                },{
                    title: 'Title',
                    dataIndex: 'title',
                    key: 'title',
                },{
                    title: 'Start',
                    dataIndex: 'start',
                    key: 'start',
                },{
                    title: 'End',
                    dataIndex: 'end',
                    key: 'end',
                },{
                    title: 'Grade Group',
                    dataIndex: 'grade_group',
                    key: 'grade_group',
                },{
                    title: 'Current Term',
                    dataIndex: 'current_term',
                    key: 'active',
                },{
                    title: 'Current Year',
                    dataIndex: 'active',
                    key: 'active',
                },{
                    title: 'Operation',
                    dataIndex: 'operation',
                    key: 'operation',
                },
            ],
            rules:{
                code:{required:true},
                title:{required:true},
                period:{required:true},
                current_term:{required:true},
                kgrade:{required:true},
                kklass:{required:true},
                pgrade:{required:true},
                pklass:{required:true},
                sgrade:{required:true},
                sklass:{required:true},
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
            layout2col: {
                labelCol: {
                    span: 8,
                },
                wrapperCol: {
                    span: 20,
                },
            }

        }
    },
    mounted() {
        this.kgradeOptions=Array(this.param.kgrade+1).fill().map((_, i) => {return {value:i, label:i++}});
        this.kklassOptions=Array(this.param.kklass+1).fill().map((_, i) => {return {value:i, label:i++}});
        this.pgradeOptions=Array(this.param.pgrade+1).fill().map((_, i) => {return {value:i, label:i++}});
        this.pklassOptions=Array(this.param.pklass+1).fill().map((_, i) => {return {value:i, label:i++}});
        this.sgradeOptions=Array(this.param.sgrade+1).fill().map((_, i) => {return {value:i, label:i++}});
        this.sklassOptions=Array(this.param.sklass+1).fill().map((_, i) => {return {value:i, label:i++}});
    },
    methods: {
        createRecord(){
            this.modalForm={};
            this.modal.data.period=[dayjs('2022/09/01', this.dateFormat), dayjs('2023/07/01', this.dateFormat)];
            this.modal.data.current_term=1;
            this.modal.data.kklass=this.param.kklassDefault;
            this.modal.data.kgrade=this.param.kgradeDefault;
            this.modal.data.pklass=this.param.pklassDefault;
            this.modal.data.pgrade=this.param.pgradeDefault;
            this.modal.data.sklass=this.param.sklassDefault;
            this.modal.data.sgrade=this.param.sgradeDefault;
            this.modal.mode="CREATE";
            this.modal.isOpen=true
            this.modal.title="創建學年"
        },
        editRecord(record){
            this.modal.data={...record}
            this.modal.data.period=[dayjs(this.modal.data.start, this.dateFormat), dayjs(this.modal.data.end, this.dateFormat)]
            this.modal.mode="EDIT";
            this.modal.isOpen=true
            this.modal.title="修改學年"
        },
        storeRecord(record){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.post((route('admin.years.store')), this.modal.data,{
                    onSuccess:(page)=>{
                        console.log(page);
                    },
                    onError:(err)=>{
                        //console.log(err);
                        Modal.error({
                            title: '數據一致性出錯',
                            content: '學年編號重複使用!',
                            okText: '了解',
                        });
                    }
                })
            }).catch(err => {
                console.log(err);
            });
        },
        updateRecord(data){
            console.log(this.modal.data);
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.put('/admin/years/' + this.modal.data.id, this.modal.data,{
                    onSuccess:(page)=>{
                        this.modalVisible=false;
                        //this.ChangeModalMode('Close');
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
                //this.loading=false;                
            }).catch(err => {
                console.log("error", err);
            });
           
        },
        deleteRecord(record){
            Modal.confirm({
                title: '是否確定',
                content: '刪除所選之主題?',
                okText: '確定',
                cancelText: '取消',
                onOk: () => {
                    this.$inertia.delete(route('admin.years.destroy', record.id), {
                        onSuccess: (page) => {
                            console.log(record.id+"deleted.");
                        },
                        onError: (error) => {
                            Modal.error({
                                title: '數據一致性出錯',
                                content: error.message,
                                okText: '了解',
                            });
                        }
                    });
                }
            })
        },
        handleValidate(field){
            console.log("handleValidate: "+field);
        },
        onFinish(value){
            console.log("onFinish"+value);
        },
        onFinishFailed(errorInfo){
            console.log('errorInfo: '+errorInfo);
        },
        lockTranscript(record){
            if(!confirm('鎖定成積表分數轉換功能，是不確定？')) return;
            this.$inertia.get(route('admin.lockTranscripts'),{scope:'year',id:record.id},{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        }

    },
}
</script>