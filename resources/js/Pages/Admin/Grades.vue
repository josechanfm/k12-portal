<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                學年級別
            </h2>
        </template>
        <a-typography-title :level="4">學年代號: {{ year.code }}</a-typography-title>
        <a-typography-title :level="4">學年全稱: {{ year.title }}</a-typography-title>
        <a-typography-title :level="4">學年開始: {{ year.start }}</a-typography-title>
        <a-typography-title :level="4">學年結束: {{ year.end }}</a-typography-title>
        <button @click="createRecord()" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">
            新增學年級別
        </button>
        <a-table :dataSource="grades" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='operation'">
                    <ButtonLink :href="'gradeSubjects?gid='+record.id" :type="'Link'">學科</ButtonLink>
                    <ButtonLink :href="'klasses?gid='+record.id" :type="'Link'">班別</ButtonLink>
                    <ButtonLink @click="editRecord(record)" :style="'Edit'">修改</ButtonLink>
                    <ButtonLink @click="deleteRecord(record)" :style="'Delete'">刪除</ButtonLink>
                </template>
                <template v-if="column.dataIndex=='active'">
                    <check-square-outlined v-if="text=='1'" :style="{color:'green'}"/>
                    <stop-outlined v-else :style="{color:'red'}"/>
                </template>
                <template v-else>
                    {{record[column.dataIndex]}}
                </template>
            </template>
        </a-table>

            <!-- Modal Start-->
            <a-modal v-model:visible="modal.isOpen"  :title="modal.title" width="60%" >
                <a-form
                    ref="modalRef"
                    :model="modal.data"
                    name="grade"
                    :rules="rules"
                    :validate-messages="validateMessages"
                    :label-col="{ span: 8 }"
                    :wrapper-col="{ span: 16 }"
                >
                    <a-form-item label="學習年" name="rank" >
                        <a-select
                            v-model:value="modal.data.rank"
                            style="width: 100%"
                            placeholder="請選擇..."
                            max-tag-count="responsive"
                            :options="[...Array(12)].map((_, i) => ({ value: (i + 1) }))"
                            disable="true"
                        ></a-select>
                    </a-form-item>
                    <a-form-item label="學年階段" name="initial">
                        <a-select
                            v-model:value="modal.data.initial"
                            style="width: 100%"
                            placeholder="請選擇..."
                            max-tag-count="responsive"
                            :options="gradeCategories"
                        ></a-select>
                    </a-form-item>
                    <a-form-item label="學年階段年級" name="level" >
                        <a-select
                            v-model:value="modal.data.level"
                            style="width: 100%"
                            placeholder="請選擇..."
                            max-tag-count="responsive"
                            :options="[...Array(6)].map((_, i) => ({ value: (i + 1) }))"
                            disable="true"
                        ></a-select>
                    </a-form-item>
                    <a-form-item label="年級代號" name="tag">
                        {{ modal.data.initial }}{{ modal.data.level }}
                    </a-form-item>
                    <a-form-item label="中文名稱" name="title_zh">
                        <a-input v-model:value="modal.data.title_zh" />
                    </a-form-item>
                    <a-form-item label="英文名稱" name="title_en">
                        <a-input v-model:value="modal.data.title_en" />
                    </a-form-item>
                    <a-form-item label="建立班別數" name="klass_num">
                        <a-input-number v-model:value="modal.data.klass_num" />
                    </a-form-item>
                    <a-form-item label="版本" name="version">
                        <a-input v-model:value="modal.data.version" />
                    </a-form-item>
                    <a-form-item label="有效" name="active">
                        <a-switch v-model:checked="modal.data.active" :checkedValue="1" :unCheckedValue="0"/>
                    </a-form-item>
                    <a-form-item label="簡介" name="description">
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
import {CheckSquareOutlined, StopOutlined} from '@ant-design/icons-vue';


export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined
    },
    props: ['year','grades','gradeCategories'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'建立學年級別',
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
                    title: '學習年',
                    dataIndex: 'rank',
                },{
                    title: '學年階段',
                    dataIndex: 'initial',
                },{
                    title: '學年階段年級',
                    dataIndex: 'level',
                },{
                    title: '年級代號',
                    dataIndex: 'tag',
                },{
                    title: '中文名稱',
                    dataIndex: 'title_zh',
                },{
                    title: '版本',
                    dataIndex: 'version',
                },{
                    title: '有效',
                    dataIndex: 'active',
                },{
                    title: '操作',
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
            this.modal.data.klass_num=0;
            this.modal.isOpen = true;
            this.modal.mode='CREATE';
            this.modal.title='建立學年級別';
        },
        editRecord(record){
            this.modal.data={...record}
            this.modal.isOpen = true;
            this.modal.mode='EDIT';
            this.modal.title='修改學年級別'
            console.log(record);
        },
        updateRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                // this.modal.data._method = 'PATCH';
                this.$inertia.put('/admin/grades/' + this.modal.data.id, this.modal.data,{
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
                this.$inertia.post('/admin/grades/', this.modal.data,{
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
        deleteRecord(record){
            if (!confirm('是否確定刪除?')) return;
            this.$inertia.delete('/admin/grades/'+record.id,{
                onSuccess:(page)=>{
                    console.log(record.id+" deleted.");
                },
                onError:(error)=>{
                    alert(error.message);
                    console.log(error);
                }
            });
        },  
    },
}
</script>