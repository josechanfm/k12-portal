<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                All Klasses
            </h2>
        </template>
        <button @click="createRecord()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">Create Subject template</button>
            <a-table :dataSource="klasses" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex!='operation'">
                        {{record[column.dataIndex]}}
                    </template>
                    <template v-else>
                        <a-button @click="editRecord(record)">Edit</a-button>
                    </template>
                </template>
            </a-table>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" 
            :title="modal.title" width="60%" 
        >
        <a-form
            ref="modalRef"
            :model="modal.data"
            name="klasses"
            :label-col="{ span: 8 }"
            :wrapper-col="{ span: 16 }"
            autocomplete="off"
            :rules="rules"
            :validate-messages="validateMessages"
            @validate="handleValidate"
            @finish="onFinish"
            @onFinishFailed="onFinishFailed"
        >
            <a-form-item label="Grade" name="grade" >
                <a-select
                    v-model:value="modal.data.grade_id"
                    style="width: 100%"
                    placeholder="Select Item..."
                    max-tag-count="responsive"
                    :options="grades.map(grade=>({value:grade.id, label:grade.tag}))"
                    disable="true"
                ></a-select>

            </a-form-item>
            <a-form-item label="Letter" name="letter">
                <a-select
                    v-model:value="modal.data.letter"
                    style="width: 100%"
                    placeholder="Select Item..."
                    max-tag-count="responsive"
                    :options="klass_letters"
                ></a-select>

            </a-form-item>
            <a-form-item label="Room" name="room">
                <a-input v-model:value="modal.data.room" />
            </a-form-item>
        </a-form>
        <template #footer>
            <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary" :loading="loading" @click="updateRecord()">Update</a-button>
            <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary" :loading="loading" @click="storeRecord()">Add</a-button>
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
    props: ['selected_year','klasses','school_years','grades','klass_letters', 'errors'],
    data() {
        return {
            paymentList: [],
            form: {
                title: null,
            },
            modal: {
                mode:null,
                isOpen: false,
                title:'Klasses',
                data:{}
            },
            dataSource:[],
            loading:false,
            columns:[
                {
                    title: 'Year',
                    dataIndex: 'year_abbr',
                    key: 'year_abbr',
                },
                {
                    title: 'Tag',
                    dataIndex: 'tag',
                    key: 'tag',
                },{
                    title: 'Room',
                    dataIndex: 'room',
                    key: 'room',
                },
                {
                    title: 'Head',
                    dataIndex: 'head_id',
                    key: 'head_id',
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
        closeModal() {
            this.isOpen = false;
            this.reset();
            this.editMode = false;
        },
        storeRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.post('/essential/klasses/', this.modal.data,{
                    onSuccess:(page)=>{
                        console.log(page);
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
                this.modal.data._method = 'PATCH';
                this.$inertia.post('/essential/klasses/' + this.modal.data.id, this.modal.data,{
                    onSuccess:(page)=>{
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
        editRecord(record){
            this.modal.data={...record};
            this.modal.mode='EDIT';
            this.modal.title="Edit klasses of "+this.selected_year.abbr;
            this.modal.isOpen = true;
        },
        createRecord(){
            this.modal.data={};
            this.modal.mode='CREATE';
            this.modal.title="Create klasses of "+this.selected_year.abbr;
            this.modal.isOpen = true;
        },
    },
}
</script>