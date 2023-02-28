<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                學年級別學科列表
            </h2>
        </template>
        <a-typography-title :level="3">年級: {{ klass.tag }}</a-typography-title>
        <a-typography-title :level="3">年級全稱: {{ klass.title_zh }}</a-typography-title>
        <button @click="onClickSave()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">Save</button>
            <a-table :dataSource="subjects" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='selection'">
                        <a-checkbox v-model:checked="record.selected"/>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="60%" @update="updateRecord()" @onCancel="closeModal()">
            <a-checkbox-group v-if="modal.mode=='CREATE'"
                v-model:value="selectedSubjects" 
                name="checkboxgroup" 
                :options="subjectTemplates.map(subject=>({value:subject.code,label:subject.title_zh+' ('+subject.stream+')'}))" 
            />
            <a-form
                v-if="modal.mode=='EDIT'"
                :model="modal.data"
                name="Subject"
                ref="modalRef"
                :rules="rules"
                :validate-messages="validateMessages"
            >
                <a-form-item label="科目代號" name="code">
                    {{ modal.data.code }}
                </a-form-item>
                <a-form-item label="科目名稱 (中文)" name="title_zh">
                    <a-input v-model:value="modal.data.title_zh" />
                </a-form-item>
                <a-form-item label="科目名稱 (英文)" name="title_en">
                    <a-input v-model:value="modal.data.title_en" />
                </a-form-item>
                <a-form-item label="分類" name="type" hidden>
                    <a-input v-model:value="modal.data.type" />
                </a-form-item>
                <a-form-item label="專業方向" name="stream">
                    <a-radio-group v-model:value="modal.data.stream" button-style="solid">
                        <a-radio-button value="LIB">Liberal Studies</a-radio-button>
                        <a-radio-button value="SCI">Science</a-radio-button>
                        <a-radio-button value="ART">Liberal Arts</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="必修/選修" name="elective">
                    <a-radio-group v-model:value="modal.data.elective" button-style="solid">
                        <a-radio-button value="COP">Compulsary</a-radio-button>
                        <a-radio-button value="ELE">Elective</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="簡介" name="description">
                    <a-textarea v-model:value="modal.data.description" placeholder="textarea with clear icon" allow-clear />
                </a-form-item>
                <a-form-item label="有效" name="active">
                    <a-switch v-model:checked="modal.data.active" :checkedValue="1" :uncheckedValue="0"/>
                </a-form-item>
            </a-form>
        <template #footer>
            <a-checkbox v-if="modal.mode=='CREATE'" class="float-left" v-model:checked="selectAll" @change="onChangeSelectAll">SelectAll</a-checkbox>
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
import ButtonLink from '@/Components/ButtonLink.vue';
import {CheckSquareOutlined, StopOutlined} from '@ant-design/icons-vue';

export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined
    },
    props: ['klass','courses','subjects'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Subjects',
                data:{}
            },
            selectedSubjects:[],
            selectAll:false,
            dataSource:[],
            columns:[
                {
                    title: 'Select',
                    dataIndex: 'selection',
                    key: 'selction',
                },
                {
                    title: '學科代號',
                    dataIndex: 'code',
                    key: 'code',
                },{
                    title: '中文名稱',
                    dataIndex: 'title_zh',
                    key: 'title_zh',
                },{
                    title: '專業方向',
                    dataIndex: 'stream',
                    key: 'stream',
                },{
                    title: '選修/必修',
                    dataIndex: 'elective',
                    key: 'elective',
                },{
                    title: '有效',
                    dataIndex: 'active',
                    key: 'active',
                }
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
    methods: {
        onClickSave(){
            console.log(this.subjects.filter(subject => subject.selected==true));
        },
        onClickEdit(record){
            this.modal.data={...record};
            this.modal.title="Edit Subject";
            this.modal.mode='EDIT';
            this.modal.isOpen = true;
        },
        storeRecord(){
            this.$inertia.post('/admin/gradeSubjects/', {
                selectedSubjects:this.selectedSubjects,
                grade_id:this.grade.id
            },{
                onSuccess:(page)=>{
                    //console.log(page);
                    this.modal.isOpen=false;
                },
                onError:(err)=>{
                    console.log(err);
                }
            });
        },
        updateRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.put('/admin/gradeSubjects/' + this.modal.data.id, this.modal.data,{
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
            if (!confirm('是否確定刪除?')) return;
            this.$inertia.delete('/admin/gradeSubjects/' + recordId,{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        onChangeSelectAll(){
            if(this.selectAll){
                this.selectedSubjects=this.selectedSubjects=this.subjectTemplates.map(subject=>subject.code);
            }else{
                this.selectedSubjects=[];
            }
        },
        onFinishFailed(errorInfo){
            console.log('errorInfo: '+errorInfo);
        },
    },
}
</script>