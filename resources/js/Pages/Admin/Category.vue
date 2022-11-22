<template>
    <a-button type="primary" @click="createRecord()">Add</a-button>
    <a-table :dataSource="dataSource.data" :columns="columns">
        <template #bodyCell="{column, text, record, index}">
            <template v-if="column.dataIndex!='operation'">
                {{record[column.dataIndex]}}
            </template>
            <template v-else>
                <a-button @click="editRecord(index)">Edit</a-button>
                <a-button @click="deleteRecord(record.id)">Delete</a-button>
            </template>
        </template>
    </a-table>


    <a-modal v-model:visible="modalVisible" :title="modalTitle" width="60%" @update="updateRecord(modalForm)" @onCancel="closeModal()">
        <a-form
            ref="modalRef"
            :model="modalForm"
            name="supplier"
            :label-col="{ span: 8 }"
            :wrapper-col="{ span: 16 }"
            autocomplete="off"
            :rules="rules"
            :validate-messages="validateMessages"
            @validate="handleValidate"
            @finish="onFinish"
            @onFinishFailed="onFinishFailed"
        >
            <a-input type="hidden" v-model:value="modalForm.id"/>
            <a-form-item 
                label="Name Zh"
                name="name_zh"
            >
                <a-input v-model:value="modalForm.name_zh" />
            </a-form-item>

            <a-form-item
                label="Name En"
                name="name_en"
            >
                <a-input v-model:value="modalForm.name_en" />
            </a-form-item>

            <a-form-item
                label="Email"
                name="email"
            >
                <a-input v-model:value="modalForm.email" />
            </a-form-item>

            <a-form-item
                label="Phone"
                name="phone"
            >
                <a-input v-model:value="modalForm.phone" />
            </a-form-item>

            <a-form-item
                label="Address"
                name="address"
            >
                <a-textarea
                    v-model:value="modalForm.address"
                    placeholder="Please input address location of the company"
                    :auto-size="{ minRows: 2, maxRows: 5 }"
                />
            </a-form-item>

            <a-form-item
                label="Category"
                name="category"
            >
                <a-select
                    v-model:value="modalForm.category"
                    mode="multiple"
                    style="width: 100%"
                    placeholder="Select Item..."
                    max-tag-count="responsive"
                    :options="categoryOptions"
                ></a-select>


            </a-form-item>

            <a-form-item
                label="Registed Date"
                name="registed_date"
            >
                <a-date-picker v-model:value="modalForm.registed_date" value-format="YYYY-MM-DD" />
            </a-form-item>
            
            <a-form-item
                label="Disproved Date"
                name="disproved_date"
            >
                <a-date-picker v-model:value="modalForm.disproved_date" value-format="YYYY-MM-DD" />
            </a-form-item>

            <a-form-item
                label="Remark"
                name="remark"
            >
                <a-textarea
                    v-model:value="modalForm.remark"
                    placeholder="Remark"
                    :auto-size="{ minRows: 2, maxRows: 5 }"
                />
            </a-form-item>


            <a-form-item
                label="Active"
                name="active"
            >
                <a-switch v-model:checked="modalForm.active" checked-children="开" un-checked-children="关" />
            </a-form-item>
            <!-- <a-form-item :wrapper-col="{ offset: 8, span: 16 }">
            </a-form-item> -->
        </a-form>
        <template #footer>
            <a-button v-if="modalMode=='Edit'" key="Update" type="primary" :loading="loading" @click="updateRecord(modalForm)">Update</a-button>
            <a-button v-if="modalMode=='Create'"  key="Store" type="primary" :loading="loading" @click="storeRecord(modalForm)">Add</a-button>
        </template>
    </a-modal>    
</template>

<script>
import { Form } from 'ant-design-vue';
//import { useForm } from "@inertiajs/inertia-vue3";
import {ref,reactive} from 'vue';

export default{
    data(){
        return{
            dataSource:[],
            currentId:0,
            modalRef:ref(),
            modalForm: ref(),
            modalVisible:false,
            modalTitle:'',
            modalMode:'',
            columns:[
                {
                    title: 'Name',
                    dataIndex: 'name_zh',
                    key: 'name',
                },
                {
                    title: 'Age',
                    dataIndex: 'phone',
                    key: 'age',
                },
                {
                    title: 'Address',
                    dataIndex: 'address',
                    key: 'address',
                },
                {
                    title: 'Operation',
                    dataIndex: 'operation',
                    key: 'operation',
                },
            ],
            categoryOptions:[
                {
                    value: 'c1',
                    label: 'Jack',
                }, {
                    value: 'c2',
                    label: 'Lucy',
                }, {
                    value: 'c3',
                    label: 'Disabled',
                }, {
                    value: 'c4',
                    label: 'Yiminghe',
                }
            ],
            loading:false,
            rules:{
                name_zh:{
                    required:true,
                },
                phone:[{
                    required:true,
                }],
                address:[{
                    required:true,
                }],
                registed_date:[{
                    required:true,
                }],
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
            }
        }
    },
    mounted(){
        this.fetchData();
    },
    methods:{
        reset(){
            this.formSate = {
                name_zh: null,
                name_en: null,
                email:null,
                phone:null,
                address:null,
                categories:null,
                register_date:null,
                disproved_date:null,
                remark:null,
                active:0,
            }
        },
        ChangeModalMode(mode){
            console.log("watch: "+mode);
            if(mode=='Create'){
                this.modalMode=mode;
                this.modalTitle='Create Record';
                this.modalVisible=true;
            }else if(mode=='Edit'){
                this.modalMode=mode;
                this.modalTitle='Edit Record';
                this.modalVisible=true;
            }else{
                this.modalMode='Close';
                this.modalTitle='Modal Mode undefined';
                this.modalVisible=false;
            }
            this.$refs.modalRef!==undefined?this.$refs.modalRef.resetFields():'';
        },
        closeModal(){
            console.log("cancel to close modal");
            this.ChangeModalMode('Close');
        },
        editRecord(index){
            this.modalForm={...this.dataSource.data[index]};
            this.currentId=index;
            this.ChangeModalMode('Edit');
        },
        deleteRecord(recordId){
            console.log(recordId);
            if (!confirm('Are you sure want to remove?')) return;
            this.$inertia.delete('/supplier/' + recordId,{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
            this.ChangeModalMode('Close');
        },
        createRecord(){
            this.modalForm={};
            this.ChangeModalMode('Create');
        },
        storeRecord(data){
            this.$refs.modalRef.validateFields().then(()=>{
                this.loading=true;
                this.$inertia.post('/supplier/', data,{
                    onSuccess:(page)=>{
                        this.ChangeModalMode('Close');
                    },
                    onError:(err)=>{
                        console.log(err);
                    }
                });
                this.loading=false;
            }).catch(err => {
                console.log(err);
            });
        },
        updateRecord(data){
            this.$refs.modalRef.validateFields().then(()=>{
                this.loading=true;
                data._method = 'PATCH';
                this.$inertia.post('/supplier/' + data.id, data,{
                    onSuccess:(page)=>{
                        this.modalVisible=false;
                        this.ChangeModalMode('Close');
                        this.fetchData();
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
                this.loading=false;                
            }).catch(err => {
                console.log("error", err);
            });
           
        },
        handleOk(e) {
            this.modalMode="close";
        },
        fetchData(){
            this.loading=true;
            axios.get("/supplier")
                .then(response=>{
                    this.dataSource=response.data;
                    console.log(response.data);
                }
            );
            this.loading=false;
        },
        //validate on field keychange
        handleValidate(field){
            console.log("handleValidate: "+field);
        },
        onFinish(value){
            console.log("onFinish"+value);
        },
        onFinishFailed(errorInfo){
            console.log('errorInfo: '+errorInfo);
        }
    },

}
</script>