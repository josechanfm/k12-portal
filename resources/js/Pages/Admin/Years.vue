<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                School Years
            </h2>
        </template>
        
        <button @click="createRecord()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">Create New School Year</button>
            <a-table :dataSource="years.data" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex!='operation'">
                        {{record[column.dataIndex]}}
                    </template>
                    <template v-else>
                        <a :href="'/year/klasses/'+record.id">Klasses</a>
                        <a-button @click="editRecord(index)">Edit</a-button>
                        <a-button @click="deleteRecord(record.id)">Delete</a-button>
                        <a-button :href="'year/subjects/'+record.id">Subject template</a-button>
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
            <a-form-item label="Herit" name="herit">
                <a-select
                    v-model:value="modalForm.herit"
                    :options="years.data.map((y)=>{
                        return {
                            value: y.id,
                            label: y.title
                        }
                    })"
                    style="width: 100%"
                />
            </a-form-item>

            <a-form-item label="Abbr" name="abbr">
                <a-input v-model:value="modalForm.abbr" style="width: 100px"/>
            </a-form-item>
            <a-form-item label="Title" name="Title">
                <a-input v-model:value="modalForm.title" />
            </a-form-item>
            <a-form-item label="period" name="Period">
                <a-range-picker v-model:value="modalForm.period" />
            </a-form-item>
            
            <div v-if="modalMode=='Create'">
                <a-form-item label="Description" name="description">
                    <a-textarea v-model:value="modalForm.description" />
                </a-form-item>

                <a-divider orientation="left">Kindergarten</a-divider>
                <a-row>
                    <a-col :span="8"></a-col>
                    <a-col :span="8">
                        <a-form-item label="K Klass" name="kklass">
                            <a-select
                            v-model:value="modalForm.kklass"
                            :options="klassOptions"
                            style="width: 80px"
                            />
                        </a-form-item>
                    </a-col>
                    <a-col :span="8">
                        <a-form-item label="K Grade" name="kgrade">
                            <a-select
                            v-model:value="modalForm.kgrade"
                            :options="gradeOptions"
                            style="width: 80px"
                            />
                        </a-form-item>
                    </a-col>
                </a-row>
                <a-divider orientation="left">Primary</a-divider>
                <a-row>
                    <a-col :span="8"></a-col>
                    <a-col :span="8">
                        <a-form-item label="P Klass" name="pklass">
                            <a-select
                            v-model:value="modalForm.pklass"
                            :options="klassOptions"
                            style="width: 80px"
                            />
                        </a-form-item>
                    </a-col>
                    <a-col :span="8">
                        <a-form-item label="P Grade" name="pgrade">
                            <a-select
                            v-model:value="modalForm.pgrade"
                            :options="gradeOptions"
                            style="width: 80px"
                            />
                        </a-form-item>
                    </a-col>
                </a-row>
                <a-divider orientation="left">Secondary</a-divider>
                <a-row>
                    <a-col :span="8"></a-col>
                    <a-col :span="8">
                        <a-form-item label="S Klass" name="sklass">
                            <a-select
                            v-model:value="modalForm.sklass"
                            :options="klassOptions"
                            style="width: 80px"
                            />
                        </a-form-item>
                    </a-col>
                    <a-col :span="8">
                        <a-form-item label="S Grade" name="sgrade">
                            <a-select
                            v-model:value="modalForm.sgrade"
                            :options="gradeOptions"
                            style="width: 80px"
                            />
                        </a-form-item>
                    </a-col>
                </a-row>
            </div>
            





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
import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc';
import timezone from 'dayjs/plugin/timezone';
dayjs.extend(utc);
dayjs.extend(timezone);

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
            modalTitle:'School Year Creation',
            modalForm:{},
            dataSource:[],
            dateFormat:'YYYY-MM-DD',
            loading:false,
            columns:[
                {
                    title: 'Abbr',
                    dataIndex: 'abbr',
                    key: 'abbr',
                },
                {
                    title: 'Title',
                    dataIndex: 'title',
                    key: 'title',
                },
                {
                    title: 'Start',
                    dataIndex: 'start',
                    key: 'start',
                },
                {
                    title: 'End',
                    dataIndex: 'end',
                    key: 'end',
                },
                {
                    title: 'Grade Group',
                    dataIndex: 'grade_group',
                    key: 'grade_group',
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
            klassOptions:[
                {
                    value: '0',
                    label: '0',
                },{
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
                }
            ],
            gradeOptions:[
                {
                    value: '0',
                    label: '0',
                },{
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
                this.$inertia.post('/years/', data,{
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
        editRecord(index){
            console.log(index);
            this.modalForm={...this.years.data[index]};
            this.modalForm.period=[dayjs(this.modalForm.start, this.dateFormat), dayjs(this.modalForm.end, this.dateFormat)];
            this.currentId=index;
            this.ChangeModalMode('Edit');
        },
        deleteRecord(recordId){
            console.log(recordId);
            if (!confirm('Are you sure want to remove?')) return;
            this.$inertia.delete('/years/' + recordId,{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
            this.ChangeModalMode('Close');
        },

        updateRecord(data){
            this.$refs.modalRef.validateFields().then(()=>{
                this.loading=true;
                data._method = 'PATCH';
                this.$inertia.post('/years/' + data.id, data,{
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
        createRecord(){
            this.modalForm={};
            this.modalForm.period=[dayjs('2022/09/01', this.dateFormat), dayjs('2023/07/01', this.dateFormat)];
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