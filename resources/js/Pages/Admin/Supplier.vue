<template>
    <a-button type="primary" @click="addRecord">Add</a-button>
    <a-table :dataSource="dataSource.dataSet" :columns="columns">
        <template #bodyCell="{column, text, record, index}">
            <template v-if="column.dataIndex!='operation'">
                {{record[column.dataIndex]}}
            </template>
            <template v-else>
                <a-button @click="editRecord(record)">Edit</a-button>
                <a-button @click="deleteRecord(index)">Delete</a-button>
            </template>
        </template>
    </a-table>


    <a-modal v-model:visible="modalVisible" :title="modalTitle" width="60%">
        <a-form
            :model="modalForm"
            name="basic"
            :label-col="{ span: 8 }"
            :wrapper-col="{ span: 16 }"
            autocomplete="off"

        >
            <a-input type="hidden" v-model:value="modalForm.id"/>
            <a-form-item 
                label="Name Zh"
                name="name_zh"
                :rules="[{ required: true, message: 'Please input Supplier name in Chinese' }]"
            >
                <a-input v-model:value="modalForm.name_zh" />
            </a-form-item>

            <a-form-item
                label="Name En"
                name="name_en"
                :rules="[{ required: true, message: 'Please input Supplier name in English!' }]"
            >
                <a-input v-model:value="modalForm.name_en" />
            </a-form-item>

            <a-form-item
                label="Email"
                name="email"
                :rules="[{ required: true, message: 'Please input Email' }]"
            >
                <a-input v-model:value="modalForm.email" />
            </a-form-item>

            <a-form-item
                label="Phone"
                name="phone"
                :rules="[{ required: true, message: 'Please input contact Phone number' }]"
            >
                <a-input v-model:value="modalForm.phone" />
            </a-form-item>

            <a-form-item
                label="Address"
                name="address"
                :rules="[{ required: true, message: 'Please input location address' }]"
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
                :rules="[{ required: true, message: 'Please input category' }]"
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
                label="Register Date"
                name="register_date"
                :rules="[{ required: true, message: 'Register date' }]"
            >
                <a-date-picker v-model:value="modalForm.register_date" value-format="YYYY-MM-DD" />
            </a-form-item>
            
            <a-form-item
                label="Disproved Date"
                name="disproved_date"
                :rules="[{ required: true, message: 'Disproved date' }]"
            >
                <a-date-picker v-model:value="modalForm.disproved_date" value-format="YYYY-MM-DD" />
            </a-form-item>

            <a-form-item
                label="Remark"
                name="remark"
                :rules="[{ required: true, message: 'Remark' }]"
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
                :rules="[{ required: true, message: 'Active' }]"
            >
                <a-switch v-model:checked="modalForm.active" checked-children="开" un-checked-children="关" />
            </a-form-item>

            <a-form-item :wrapper-col="{ offset: 8, span: 16 }">
            <a-button type="primary" @click="updateRecord(modalForm)">Save</a-button>
            </a-form-item>
        </a-form>
    </a-modal>    
</template>

<script>
//import { Form } from 'ant-design-vue';
import { useForm } from "@inertiajs/inertia-vue3";

export default{
    data(){
        return{
            dataSource:{},
            modalForm:{},
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
        openModal(score){
            if(score=='Add'){
                this.modalTitle="Add Supplier";
                this.modalVisible=true;
                this.modalMode='Add';
            }else if(score=='Edit'){
                this.modalTitle="Edit Supplier";
                this.modalMode='Edit';
                this.modalVisible=true;
            }else{
                this.modalTitle="Undefined";
                this.modalMode='Close';
                this.modalVisible=true;
            }
            
        },
        closeModal(){
            this.modalTitle="Undefined";
            this.modalMode='Close';
            this.modalVisible=false;
        },
        editRecord(record){
            this.modalForm={...record};
            this.openModal('Edit');
        },
        deleteRecord(index){
            alert("Delete Record: "+index);
        },
        addRecord(){
            this.modalForm={}
            this.openModal('Add');
        },
        storeRecord(){
            this.modalVisible=false;
            this.modalMode="close";
        },
        updateRecord(data){
            data._method = 'PATCH';
            this.$inertia.post('/supplier/' + data.id, data)
            this.modalVisible=false;
            this.modalMode="close";
        },
        handleOk(e) {
            console.log(e);
            this.modalVisible = false;
            this.modalMode="close";
        },
        fetchData(){
            axios.get("../supplier")
                .then(response=>{
                    this.dataSource.dataSet=response.data.dataSet.data;
                    console.log(response.data);
                }
            )
        }
    }
}
</script>