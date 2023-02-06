<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                總科目列表
            </h2>
        </template>
            <button @click="saveSelected"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">Save Selected</button>
            <a-table :dataSource="subjects" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <a-button @click="onClickEdit(record)">Edit</a-button>
                        <a-button @click="onClickDelete(record.id)">Delete</a-button>
                    </template>
                    <template v-else-if="column.dataIndex=='selected'">
                        <a-checkbox v-model:checked="record.selected">Checkbox</a-checkbox>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="60%" @update="updateRecord()" @onCancel="closeModal()">
            <a-form
                :model="modal.data"
                name="Subject"
                ref="modalRef"
                :rules="rules"
                :validate-messages="validateMessages"
            >
                <a-form-item label="版本" name="version">
                    <a-input-number v-model:value="modal.data.version" />
                </a-form-item>
                <a-form-item label="名稱 (中文)" name="title_zh">
                    <a-input v-model:value="modal.data.title_zh" />
                </a-form-item>
                <a-form-item label="名稱 (英文)" name="title_en">
                    <a-input v-model:value="modal.data.title_en" />
                </a-form-item>
                <a-form-item label="專業方向" name="stream">
                    <a-radio-group v-model:value="modal.data.stream" button-style="solid">
                        <a-radio-button v-for="ss in studyStreams" :value="ss.value">{{ ss.label }}</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="簡介" name="description">
                    <a-textarea v-model:value="modal.data.description" placeholder="textarea with clear icon" allow-clear />
                </a-form-item>
                <a-form-item label="有效" name="active">
                    <a-switch v-model:checked="modal.data.active" :checkedValue="1" :uncheckedValue="0"/>
                </a-form-item>
                <a-form-item label="學年階段" name="grade">
                    <a-select
                        ref="select"
                        v-model:value="modal.data.grade"
                        :options="gradeCategories"
                    />
                </a-form-item>
            </a-form>
        <template #footer>
            <a-button key="back" @click="modalCancel">Return</a-button>
            <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
            <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary" @click="storeRecord()">Create</a-button>
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
    props: ['study','subjects'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Subjects',
                data:{}
            },
            dataSource:[],
            columns:[
                {
                    title: 'Selected',
                    dataIndex: 'selected',
                },{
                    title: 'Title Zh',
                    dataIndex: 'title_zh',
                },{
                    title: 'Stream',
                    dataIndex: 'stream',
                },{
                    title: 'grade',
                    dataIndex: 'grade',
                },{
                    title: 'Operation',
                    dataIndex: 'operation',
                },
            ],
            rules:{
                code:{
                    required:true,
                },
                title_zh:{
                    required:true,
                },
                title_en:{
                    required:true,
                },
                type:{
                    required:true,
                },
                stream:{
                    required:true,
                },
                eletive:{
                    required:true,
                },
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
    mounted(){
        this.subjects.map(subject=>{
            return subject.selected=this.study.subjects.find(ss=>{
                return subject.id==ss.id
            })!==undefined;
        } )
    },
    methods: {
        onClickCreate(record){
            this.modal.data={};
            this.modal.title="Edit Subject";
            this.modal.mode='CREATE';
            this.modal.isOpen = true;
        },
        onClickEdit(record){
            this.modal.data={...record};
            this.modal.title="Edit Subject";
            this.modal.mode='EDIT';
            this.modal.isOpen = true;
        },
        storeRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.post('/master/studies/', this.modal.data,{
                    onSuccess:(page)=>{
                        console.log(page);
                        this.modal.isOpen=false;
                    },
                    onError:(err)=>{
                        console.log(err);
                    }
                });
            }).catch(err => {
                console.log(err);
            });
        },
        updateRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.put('/master/studies/' + this.modal.data.id, this.modal.data,{
                    onSuccess:(page)=>{
                        console.log(page);
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
        onClickDelete(recordId){
            if (!confirm('Are you sure want to remove?')) return;
            this.$inertia.delete('/master/subjects/' + recordId,{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
            this.ChangeModalMode('Close');
        },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        onFinishFailed(errorInfo){
            console.log('errorInfo: '+errorInfo);
        },
        saveSelected(){
            const subjects=this.subjects.filter(subject=>{ return subject.selected==true })
            this.$inertia.put('/master/study/subjects/' + this.study.id, subjects,{
                onSuccess:(page)=>{
                    console.log(page);
                    this.modal.isOpen=false;
                },
                onError:(error)=>{
                    console.log(error);
                }
            });

        }
    },
}
</script>