<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                All Klasses
            </h2>
        </template>
        <a-typography-title :level="4">學年:{{ grade.year.code }}</a-typography-title>
        <a-typography-title :level="4">年級:{{ grade.tag }}</a-typography-title>
        <ButtonLink v-for="g in grades" :href="'klasses?gid='+g.id" :style="'Add'" :type="'Link'">{{ g.tag }}</ButtonLink>
        <br>
        <button @click="createRecord()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">Create Class</button>
            <a-table :dataSource="klasses" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <a-button @click="editRecord(record)">Edit</a-button>
                    </template>
                    <template v-else-if="column.dataIndex=='courses'">
                        <a-popover :title="'Courses for '+record.tag">
                            <template #content>
                                <p v-for="course in record.courses">{{ course.code }}-{{ course.title_zh }}</p>
                            </template>
                            <a>{{record.courses.length}}</a>
                    </a-popover>

                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" 
            :title="modal.title" width="60%" 
        >
        {{ klass_letters }}
        <a-form
            ref="modalRef"
            :model="modal.data"
            name="klasses"
            :label-col="{ span: 8 }"
            :wrapper-col="{ span: 16 }"
            autocomplete="off"
            :rules="rules"
            :validate-messages="validateMessages"
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
            <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
            <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary"  @click="storeRecord()">Add</a-button>
        </template>
    </a-modal>    
    <!-- Modal End-->
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';
import { Link } from '@inertiajs/inertia-vue3';
import ButtonLink from '@/Components/ButtonLink.vue';

export default {
    components: {
        AdminLayout,
        ButtonLink,
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
                    title: 'Courses',
                    dataIndex: 'courses',
                    key: 'courses',
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
                        this.modal.isOpen=false;
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
            this.klasses.forEach(klass=>{
                this.klass_letters.forEach((kl,idx)=>{
                    if(klass.letter==kl.value){
                        this.klass_letters[idx].disabled=true;
                    }
                })
            })
        },
        onChangeGradeSelect(){
            console.log(this.gradeSelected);
            //this.$inertia.get('klasses?gid='+this.gradeSelected);
        }
    },
}
</script>
