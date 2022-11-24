<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Dashboard
            </h2>
        </template>

        <button @click="createRecord()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">Create New Post</button>
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

        <!-- Modal Start-->
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
            <a-form-item label="Abbr" name="abbr">
                <a-input v-model:value="modalForm.abbr" />
            </a-form-item>
            <a-form-item label="Title" name="Title">
                <a-input v-model:value="modalForm.title" />
            </a-form-item>
            <a-form-item label="Description" name="description">
                <a-textarea v-model:value="modalForm.description" />
            </a-form-item>
            <a-form-item label="Grade K" name="gradek">
                <a-select
                    v-model:value="modalForm.category"
                    style="width: 100%"
                    placeholder="Select Item..."
                    max-tag-count="responsive"
                    :options="sectionOptions"
                ></a-select>
            </a-form-item>
            <a-form-item label="Grade S" name="grades">
                <a-select
                    v-model:value="modalForm.category"
                    style="width: 100%"
                    placeholder="Select Item..."
                    max-tag-count="responsive"
                    :options="gradeOptions"
                ></a-select>
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

export default {
    components: {
        AdminLayout,
    },
    props: ['years', 'errors'],
    data() {
        return {
            paymentList: [],
            editMode: false,
            isOpen: false,
            form: {
                title: null,
            },
            modalVisible:false,
            modalTitle:'Modal Title',
            modalForm:{},
            dataSource:[],
            loading:false,
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
        save(data) {
            this.$inertia.post('/payments', data)
            this.reset();
            this.closeModal();
            this.editMode = false;
        },
        edit(data) {
            this.form = Object.assign({}, data);
            this.editMode = true;
            this.openModal();
        },
        update(data) {
            data._method = 'PATCH';
            this.$inertia.post('/payments/' + data.id, data, {
                onSuccess: (page) => {
                    this.modalVisible = false;
                    this.reset();
                    this.closeModal();
                },
                onError: (error) => {
                    console.log(error);
                }
            });


            //this.reset();
            //this.closeModal();
        },
        deleteRow(data) {
            if (!confirm('Are you sure want to remove?')) return;
            data._method = 'DELETE';
            this.$inertia.post('/payments/' + data.id, data)
                .then(response => {
                    console.log(response.data);
                })
            this.reset();
            this.closeModal();
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