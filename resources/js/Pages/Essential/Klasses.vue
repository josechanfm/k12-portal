<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                All Klasses
            </h2>
        </template>
        <a-typography-title :level="4">學年:{{ grade.year.code }}</a-typography-title>
        <a-typography-title :level="4">年級:{{ grade.tag }}</a-typography-title>
        <Link v-for="g in grades" :href="'klasses?gid='+g.id" method="get" 
            class="px-3 py-2 mr-2 rounded text-white text-sm font-bold whitespace-no-wrap bg-blue-600 hover:bg-blue-800">
            {{ g.tag }}
        </Link>
        <br>
        <button @click="createRecord()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">Create Class</button>
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
        >
            <a-form-item label="Grade" name="grade" >
                {{ grade.tag }}
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
import { Link } from '@inertiajs/inertia-vue3';

export default {
    components: {
        AdminLayout,
        Link
    },
    props: ['grades','grade','klasses','klass_letters'],
    data() {
        return {
            gradeSelected:1,
            modal: {
                mode:null,
                isOpen: false,
                title:'Klasses',
                data:{}
            },
            dataSource:[],
            columns:[
                {
                    title: 'Tag',
                    dataIndex: 'tag',
                    key: 'tag',
                },{
                    title: 'Room',
                    dataIndex: 'room',
                    key: 'room',
                },{
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
                this.$inertia.put('/essential/klasses/' + this.modal.data.id, this.modal.data,{
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
            this.modal.title="Edit klasses ";
            this.modal.isOpen = true;
        },
        createRecord(){
            this.modal.data={};
            this.modal.data.grade_id=this.grade.id;
            this.modal.mode='CREATE';
            this.modal.title="Create klasses";
            this.modal.isOpen = true;
        },
        onChangeGradeSelect(){
            console.log(this.gradeSelected);
            //this.$inertia.get('klasses?gid='+this.gradeSelected);
        }
    },
}
</script>