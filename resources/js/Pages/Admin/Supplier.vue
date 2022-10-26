<template>
    {{formState}}
    {{modalMode}}
    <span v-if="modalMode!=''">
        edit or add
    </span>
    <span v-else>
        null
    </span>
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


    <a-modal v-model:visible="modalVisible" :title="modalMode" width="60%" @ok="handleOk">
        <a-form
            :model="formState"
            name="basic"
            :label-col="{ span: 8 }"
            :wrapper-col="{ span: 16 }"
            autocomplete="off"
            @finish="onFinish"
            @finishFailed="onFinishFailed"
        >
            <a-input type="hidden" v-model:value="formState.id"/>
            <a-form-item 
                label="Name Zh"
                name="name_zh"
                :rules="[{ required: true, message: 'Please input Supplier name in Chinese' }]"
            >
                <a-input v-model:value="formState.name_zh" />
            </a-form-item>

            <a-form-item
                label="Name En"
                name="name_en"
                :rules="[{ required: true, message: 'Please input Supplier name in English!' }]"
            >
                <a-input v-model:value="formState.name_en" />
            </a-form-item>

            <a-form-item
                label="Email"
                name="email"
                :rules="[{ required: true, message: 'Please input Email' }]"
            >
                <a-input v-model:value="formState.email" />
            </a-form-item>

            <a-form-item
                label="Phone"
                name="phone"
                :rules="[{ required: true, message: 'Please input contact Phone number' }]"
            >
                <a-input v-model:value="formState.phone" />
            </a-form-item>

            <a-form-item
                label="Address"
                name="address"
                :rules="[{ required: true, message: 'Please input location address' }]"
            >
                <a-textarea
                    v-model:value="formState.address"
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
                    v-model:value="formState.category"
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
                <a-date-picker v-model:value="formState.register_date" value-format="YYYY-MM-DD" />
            </a-form-item>
            
            <a-form-item
                label="Disproved Date"
                name="disproved_date"
                :rules="[{ required: true, message: 'Disproved date' }]"
            >
                <a-date-picker v-model:value="formState.disproved_date" value-format="YYYY-MM-DD" />
            </a-form-item>

            <a-form-item
                label="Remark"
                name="remark"
                :rules="[{ required: true, message: 'Remark' }]"
            >
                <a-textarea
                    v-model:value="formState.remark"
                    placeholder="Remark"
                    :auto-size="{ minRows: 2, maxRows: 5 }"
                />
            </a-form-item>


            <a-form-item
                label="Active"
                name="active"
                :rules="[{ required: true, message: 'Active' }]"
            >
                <a-switch v-model:checked="formState.active" checked-children="开" un-checked-children="关" />
            </a-form-item>

            <a-form-item :wrapper-col="{ offset: 8, span: 16 }">
            <a-button type="primary" html-type="submit">Submit</a-button>
            </a-form-item>
        </a-form>
    </a-modal>    
</template>

<script>

export default{
    data(){
        return{
            dataSource:{},
            formState:{},
            modalVisible:false,
            modalMode:'close',
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
    props:[],
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

        editRecord(record){
            this.formState={...record};
            this.modalVisible = true;
            this.modalMode="edit";
        },
        deleteRecord(index){
            alert("Delete Record: "+index);
        },
        addRecord(){
            this.formState={}
            this.modalVisible=true;
            this.modalMode="add";
        },
        addStore(){
            this.modalVisible=false;
            this.modalMode="close";
        },
        addUpdate(){
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