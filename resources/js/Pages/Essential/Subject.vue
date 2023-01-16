<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                All Subjects
            </h2>
        </template>
        <button @click="createRecord()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">Create Subject template</button>
            <a-table :dataSource="subjects" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <a :href="'/essential/subjects/'+record.id">View</a>
                        <a-button @click="onClickEditSubject(record)">Edit</a-button>
                        <a-button @click="deleteRecord(record.id)">Delete</a-button>
                    </template>
                    <template v-else-if="column.dataIndex=='courses'">
                        <ul>
                            <li v-for="klass in record['klasses']">Class: {{klass.acronym}}</li>
                        </ul>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" :title="modalTitle" width="60%" @update="updateRecord(modalForm)" @onCancel="closeModal()">
        
        {{ modal.data }}
        <a-form
            :model="modal.data"
            name="Subject"
            ref="modalSubject"
            @finish="onModalFinish"
        >
            <a-form-item label="year_id" name="year_id">
                <a-input v-model:value="modal.data.year_id" />
            </a-form-item>
            <a-form-item label="科目代號" name="code">
                <a-input v-model:value="modal.data.code" />
            </a-form-item>
            <a-form-item label="科目名稱 (中文)" name="title_zh">
                <a-input v-model:value="modal.data.title_zh" />
            </a-form-item>
            <a-form-item label="分類" name="type">
                <a-input v-model:value="modal.data.type" />
            </a-form-item>
            <a-form-item label="專業方向" name="stream">
                <a-input v-model:value="modal.data.stream" />
            </a-form-item>
            <a-form-item label="必修/選修" name="elective">
                <a-input v-model:value="modal.data.elective" />
            </a-form-item>
            <a-form-item label="簡介" name="description">
                <a-textarea v-model:value="modal.data.descriion" placeholder="textarea with clear icon" allow-clear />
            </a-form-item>
            <a-form-item label="有效" name="active">
                <a-switch v-model:checked="modal.data.active" :checkedValue="1" :uncheckedValue="0"/>
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
    props: ['year','subjects','klasses','school_years','grades','initials', 'errors'],
    data() {
        return {
            paymentList: [],
            modal: {
                mode:null,
                isOpen: false,
                title:'Score Column',
                data:{}
            },
            form: {
                title: null,
            },
            modalVisible:false,
            modalTitle:'School Year Creation',
            modalForm:{},
            dataSource:[],
            loading:false,
            columns:[
                {
                    title: 'Year',
                    dataIndex: 'year_id',
                    key: 'year_id',
                },
                {
                    title: 'Abbr',
                    dataIndex: 'abbr',
                    key: 'abbr',
                },
                {
                    title: 'Title Zh',
                    dataIndex: 'title_zh',
                    key: 'title_zh',
                },
                {
                    title: 'Stream',
                    dataIndex: 'stream',
                    key: 'stream',
                },
                {
                    title: 'Elective',
                    dataIndex: 'elective',
                    key: 'elective',
                },
                {
                    title: 'Active',
                    dataIndex: 'active',
                    key: 'active',
                },
                {
                    title: 'Courses',
                    dataIndex: 'courses',
                    key: 'courses',
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
                this.$inertia.post('/essential/klasses/', data,{
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
                this.$inertia.post('/essential/klasses/' + data.id, data,{
                    onSuccess:(page)=>{
                        this.modalVisible=false;
                        this.ChangeModalMode('Close');
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
        onClickEditSubject(record){
            this.modal.data={...record};
            this.modal.title="Edit Subject";
            this.modal.mode='EDIT';
            this.modal.isOpen = true;
        },
        deleteRecord(recordId){
            console.log(recordId);
            if (!confirm('Are you sure want to remove?')) return;
            this.$inertia.delete('/essential/klasses/' + recordId,{
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