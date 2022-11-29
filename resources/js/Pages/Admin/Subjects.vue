<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Subjects template
            </h2>
        </template>
        <button @click="createRecord()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">Create Subject template</button>
            
            <a-table :dataSource="subjects.data" :columns="columns">
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

        <!-- Modal Start-->
        <a-modal v-model:visible="modalVisible" :title="modalTitle" width="60%" @update="updateRecord(modalForm)" @onCancel="closeModal()">
        <a-form
            ref="modalRef"
            :model="modalForm"
            name="subjects"
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
            <a-form-item label="Abbr" name="abbr">
                <a-input v-model:value="modalForm.abbr" style="width: 100px"/>
            </a-form-item>
            <a-form-item label="Title Zh" name="title_zh">
                <a-input v-model:value="modalForm.title_zh" />
            </a-form-item>
            <a-form-item label="Title En" name="title_en">
                <a-input v-model:value="modalForm.title_en" />
            </a-form-item>
            <a-form-item label="Type" name="type">
                <a-input v-model:value="modalForm.type" />
            </a-form-item>
            <a-form-item label="Description" name="description">
                <a-textarea v-model:value="modalForm.description" />
            </a-form-item>





        </a-form>
        <template #footer>
            <a-button v-if="modalMode=='Edit'" key="Update" type="primary" :loading="loading" @click="updateRecord(modalForm)">Update</a-button>
            <a-button v-if="modalMode=='Create'"  key="Store" type="primary" :loading="loading" @click="storeRecord(modalForm)">Add</a-button>
        </template>
    </a-modal>    
    <!-- Modal End-->
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['subjects', 'errors'],
    data() {
        return {
            paymentList: [],
            editMode: false,
            isOpen: false,
            form: {
                title: null,
            },
            modalVisible:false,
            modalTitle:'School Year Creation',
            modalForm:{},
            dataSource:[],
            currentId:null,
            loading:false,
            columns:[
                {
                    title: 'Abbr',
                    dataIndex: 'abbr',
                    key: 'abbr',
                },
                {
                    title: 'Title_zh',
                    dataIndex: 'title_zh',
                    key: 'title_zh',
                },
                {
                    title: 'Title_en',
                    dataIndex: 'title_en',
                    key: 'title_en',
                },
                {
                    title: 'Operation',
                    dataIndex: 'operation',
                    key: 'operation',
                },
            ],
            rules:{
                abbr:{
                    required:true,
                },
                title_zh:[{
                    required:true,
                }],
                type:[{
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
            },
            sectionOptions:[
                {
                    value: '1',
                    label: '1',
                }, {
                    value: '2',
                    label: '2',
                }, {
                    value: '3',
                    label: '3',
                }, {
                    value: '4',
                    label: '4',
                }
            ],
            gradeOptions:[
                {
                    value: '1',
                    label: '1',
                }, {
                    value: '2',
                    label: '2',
                }, {
                    value: '3',
                    label: '3',
                }, {
                    value: '4',
                    label: '4',
                }, {
                    value: '5',
                    label: '5',
                }, {
                    value: '6',
                    label: '6',
                }, {
                    value: '7',
                    label: '7',
                }, {
                    value: '8',
                    label: '8',
                }, {
                    value: '9',
                    label: '9',
                }
            ],
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
    methods: {
        openModal() {
            this.isOpen = true;
        },
        closeModal() {
            this.isOpen = false;
            this.reset();
            this.editMode = false;
        },
        reset() {
            this.form = {
                title: null,
                body: null,
            }
        },
        ChangeModalMode(mode){
            console.log("watch: "+mode);
            if(mode=='Create'){
                this.modalMode=mode;
                this.modalTitle='School Year Creation';
                this.modalVisible=true;
            }else if(mode=='Edit'){
                this.modalMode=mode;
                this.modalTitle='School Year Editing';
                this.modalVisible=true;
            }else{
                this.modalMode='Close';
                this.modalTitle='Modal Mode undefined';
                this.modalVisible=false;
            }
            this.$refs.modalRef!==undefined?this.$refs.modalRef.resetFields():'';
        },


        storeRecord(data){
            this.$refs.modalRef.validateFields().then(()=>{
                this.loading=true;
                this.$inertia.post('/subjects/', data,{
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
                this.$inertia.post('/subjects/' + data.id, data,{
                    onSuccess:(page)=>{
                        this.modalVisible=false;
                        this.ChangeModalMode('Close');
                        //this.fetchData();
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
        editRecord(index){
            console.log(index);
            this.modalForm={...this.subjects.data[index]};
            this.currentId=index;
            this.ChangeModalMode('Edit');
        },
        deleteRecord(recordId){
            console.log(recordId);
            if (!confirm('Are you sure want to remove?')) return;
            this.$inertia.delete('/subjects/' + recordId,{
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