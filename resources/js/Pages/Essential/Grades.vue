<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Grades in the year
            </h2>
        </template>
        <a-typography-title :level="4">學年代號: {{ year.code }}</a-typography-title>
        <a-typography-title :level="4">學年全稱: {{ year.title }}</a-typography-title>
        <a-typography-title :level="4">學年開始: {{ year.start }}</a-typography-title>
        <a-typography-title :level="4">學年結束: {{ year.end }}</a-typography-title>
        <button @click="createRecord()" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">
            Create grade in the year
        </button>
        <a-table :dataSource="grades" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='operation'">
                    <ButtonLink :href="'gradeSubjects?gid='+record.id" :type="'Link'">Subject</ButtonLink>
                    <ButtonLink :href="'klasses?gid='+record.id" :type="'Link'">Classes</ButtonLink>
                    <ButtonLink @click="editRecord(record)" :style="'Edit'">Edit</ButtonLink>
                    <ButtonLink @click="deleteRecord(record)" :style="'Delete'">Delete</ButtonLink>
                </template>
                <template v-if="column.dataIndex=='subjects'">
                    <a-popover :title="'Subjects for '+record.tag">
                        <template #content>
                            <p v-for="subject in record.subjects">{{ subject.code }}-{{ subject.title_zh }}</p>
                        </template>
                        <a>{{ record.subjects.length }}</a>
                    </a-popover>
                </template>
                <template v-else>
                    {{record[column.dataIndex]}}
                </template>
            </template>
        </a-table>

            <!-- Modal Start-->
            <a-modal v-model:visible="modal.isOpen"  :title="modal.title" width="60%" >
                {{ modal.data }}
                <a-form
                    ref="modalRef"
                    :model="modal.data"
                    name="grade"
                    :rules="rules"
                    :validate-messages="validateMessages"
                    :label-col="{ span: 8 }"
                    :wrapper-col="{ span: 16 }"
                >
                    <a-form-item label="Rank" name="rank" >
                        <a-select
                            v-model:value="modal.data.rank"
                            style="width: 100%"
                            placeholder="Select Item..."
                            max-tag-count="responsive"
                            :options="[...Array(12)].map((_, i) => ({ value: (i + 1) }))"
                            disable="true"
                        ></a-select>
                    </a-form-item>
                    <a-form-item label="Initial" name="initial">
                        <a-select
                            v-model:value="modal.data.initial"
                            style="width: 100%"
                            placeholder="Select Item..."
                            max-tag-count="responsive"
                            :options="[{value:'K',label:'幼稚園'},{value:'P',label:'小學'},{value:'S',label:'中學'}]"
                        ></a-select>
                    </a-form-item>
                    <a-form-item label="Level" name="level" >
                        <a-select
                            v-model:value="modal.data.level"
                            style="width: 100%"
                            placeholder="Select Item..."
                            max-tag-count="responsive"
                            :options="[...Array(6)].map((_, i) => ({ value: (i + 1) }))"
                            disable="true"
                        ></a-select>
                    </a-form-item>
                    <a-form-item label="Tag" name="tag">
                        {{ modal.data.initial }}{{ modal.data.level }}
                    </a-form-item>
                    <a-form-item label="Title zh" name="title_zh">
                        <a-input v-model:value="modal.data.title_zh" />
                    </a-form-item>
                    <a-form-item label="Title en" name="title_en">
                        <a-input v-model:value="modal.data.title_en" />
                    </a-form-item>
                    <a-form-item label="Version" name="version">
                        <a-input v-model:value="modal.data.version" />
                    </a-form-item>
                    <a-form-item label="Active" name="active">
                        <a-switch v-model:checked="modal.data.active" :checkedValue="1" :unCheckedValue="0"/>
                    </a-form-item>
                    <a-form-item label="Description" name="description">
                        <a-textarea v-model:value="modal.data.description" />
                    </a-form-item>
                </a-form>
                <template #footer>
                    <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary"  @click="updateRecord()">Update</a-button>
                    <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary" @click="storeRecord()">Add</a-button>
                </template>
            </a-modal>    
            <!-- Modal End-->

        </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';


export default {
    components: {
        AdminLayout,
        ButtonLink,
    },
    props: ['year','grades'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Klasses',
                data:{}
            },
            rules:{
                rank:{
                    required:true,
                },
                initial:[{
                    required:true,
                }],
                level:[{
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
            columns:[
                {
                    title: 'Level',
                    dataIndex: 'level',
                },{
                    title: 'Initial',
                    dataIndex: 'initial',
                },{
                    title: 'Tag',
                    dataIndex: 'tag',
                },{
                    title: 'Title Zh',
                    dataIndex: 'title_zh',
                },{
                    title: 'Subjects',
                    dataIndex: 'subjects',
                },{
                    title: 'Version',
                    dataIndex: 'version',
                },{
                    title: 'Active',
                    dataIndex: 'version',
                },{
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ]
        }
    },
    mounted() {
    },
    methods: {
        createRecord(){
            this.modal.data={}
            this.modal.data.year_id=this.year.id;
            this.modal.isOpen = true;
            this.modal.mode='CREATE';
        },
        editRecord(record){
            this.modal.data={...record}
            this.modal.isOpen = true;
            this.modal.mode='EDIT';
            console.log(record);
        },
        deleteRecord(record){
            this.$inertia.delete('/essential/grades/'+record.id,{
                onSuccess:(page)=>{
                    console.log(record.id+" deleted.");
                },
                onError:(error)=>{
                    console.log(error);
                }
            });
        },  
        updateRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                // this.modal.data._method = 'PATCH';
                this.$inertia.put('/essential/grades/' + this.modal.data.id, this.modal.data,{
                    onSuccess:(page)=>{
                        this.modal.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log(err);
            })
        },
        storeRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                console.log(this.modal.data)
                this.$inertia.post('/essential/grades/', this.modal.data,{
                    onSuccess:(page)=>{
                        console.log(page);
                        this.modal.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log(err);
            })
        },
    },
}
</script>