<template>
    <AdminLayout title="年級" :breadcrumb="breadcrumb">
    
            <!--  -->
            
            <div class="flex flex-wrap font-bold text-sm gap-1">
                <div class="flex bg-gray-300 rounded-lg p-1 px-2 items-center gap-1">
                    <div class="text-gray-600 font-black rounded-l-lg bg-gray-100  p-1 ">學年代號</div>
                    <div class=" "> 
                        <a-select  ref="select"   v-model:value="year.id"  style="width: 120px"
                            @change="selectYear"    :options="years"  :field-names="{label:'code',value:'id'}" >
                        </a-select>       
                    </div>
                </div>
                <div class="flex bg-gray-300 rounded-lg p-1 items-center gap-1">
                    <div class="text-gray-600 font-black rounded-l-lg bg-gray-100  p-1 ">學年全稱</div>
                    <div class=" ">{{ year.title }}</div>
                </div>
                <div class="flex bg-gray-300 rounded-lg p-1 items-center gap-1 ">
                    <div class="text-gray-600 font-black rounded-l-lg bg-gray-100  p-1 ">日期</div>
                    <div>{{ year.start }}</div>
                <ArrowRightOutlined/>
                    <div>{{ year.end }}</div>
                </div>
                <div class="flex-1"></div>
                <a-button @click="createRecord()" type="primary">
                    新增學年級別
                </a-button>
            </div>
            <!--  -->
        <a-table :dataSource="grades" :columns="columns" :pagination="{ pageSize: 20 }"
>
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='operation'">
                    <a-button as="link" :href="route('admin.grade.klasses.index',record.id)" class="ant-btn">班別</a-button>
                    <a-button @click="editRecord(record)">修改</a-button>
                    <a-button @click="deleteRecord(record)">刪除</a-button>
                    <a-popconfirm
                        title='是否確定鎖定 "全級" 的成績表?'
                        ok-text="Yes"
                        cancel-text="No"
                        @confirm="lockTranscript(record)"
                    >
                    </a-popconfirm>
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
            <a-modal v-model:open="modal.isOpen"  :title="modal.title" width="60%" >
                <a-form
                    ref="modalRef"
                    :model="modal.data"
                    name="grade"
                    :rules="rules"
                    :validate-messages="validateMessages"
                    :label-col="{ span: 4 }"
                    :wrapper-col="{ span: 20 }"
                >
                    <a-form-item label="學習年" name="grade_year" v-if="modal.mode=='CREATE'">
                        <a-select
                            v-model:value="modal.data.grade_year"
                            style="width: 100%"
                            placeholder="請選擇..."
                            max-tag-count="responsive"
                            :options="gradeLevels.map(level=>({value:level.value, label:level.label}))"
                            @change="onChangeGradeSelected"
                        ></a-select>
                    </a-form-item>
                    <a-form-item label="年級代號" name="tag" v-else >
                        {{ modal.data.initial }}{{ modal.data.level }}
                    </a-form-item>
                    <a-form-item label="中文名稱" name="title_zh">
                        <a-input v-model:value="modal.data.title_zh" />
                    </a-form-item>
                    <a-form-item label="英文名稱" name="title_en">
                        <a-input v-model:value="modal.data.title_en" />
                    </a-form-item>
                    <a-form-item label="成績表模版" name="transcript_template_id">
                        <a-input-number v-model:value="modal.data.transcript_template_id" />
                    </a-form-item>
                    <a-form-item label="操行分比" name="behaviour_scheme_data">
                        <a-textarea v-model:value="modal.data.behaviour_scheme_data" />
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
                    <a-button key="back" @click="modalCancel">Close</a-button>
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
import {ArrowRightOutlined, CheckSquareOutlined, StopOutlined} from '@ant-design/icons-vue';
import { Modal } from 'ant-design-vue';
import { ExclamationCircleOutlined } from '@ant-design/icons-vue';
import { ref, createVNode } from 'vue';


export default {
    components: {
        AdminLayout,
        ButtonLink,
        ArrowRightOutlined, CheckSquareOutlined, StopOutlined,
        Modal, ExclamationCircleOutlined, createVNode
    },
    props: ['years','year','grades','gradeLevels'],
    data() {
        return {
            breadcrumb:[
                {label:"行政管理" ,url:route('admin.dashboard')},
                {label:"年級" ,url:null},
            ],
            selectedYear:this.year.id,
            modal: {
                mode:null,
                isOpen: false,
                title:'建立學年級別',
                data:{}
            },
            columns:[
                {
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
            ],
            rules:{
                grade_year:{required:true},
                title_zh:{required:true},
                transcript_template_id:{required:true},
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
            this.modal.data.behaviour_scheme_data=JSON.stringify(this.modal.data.behaviour_scheme)
            this.modal.isOpen = true
            this.modal.mode='EDIT'
            this.modal.title='修改學年級別'
            console.log(record)
        },
        updateRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                // this.modal.data._method = 'PATCH';
                this.$inertia.put(route('admin.year.grades.update',[this.year.id,this.modal.data.id]), this.modal.data,{
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
                this.$inertia.post(route('admin.year.grades.store', [this.year.id,this.modal.data]),{
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
            console.log(record)
            Modal.confirm({
                title: '是否確定',
                content: '刪除所選之主題?',
                okText: '確定',
                cancelText: '取消',
                onOk: () => {
                    this.$inertia.delete(route('admin.year.grades.destroy', [record.year_id, record.id]), {
                        onSuccess: (page) => {
                            console.log(record.id+"deleted.");
                        },
                        onError: (error) => {
                            Modal.error({
                                title: '數據一致性出錯',
                                content: error.message,
                                okText: '了解',
                            });
                        }
                    });
                }
            })

        },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        selectYear(item){
            console.log(item)
            this.$inertia.get(route('admin.year.grades.index',{year:item}));
            //this.$inertia.get(route('admin.year.grades',item));
        },
        onChangeGradeSelected(){
            var tmp=this.gradeLevels.find(grade=>grade.value==this.modal.data.grade_year);
            console.log(tmp);
            this.modal.data.initial=tmp.initial;
            this.modal.data.level=tmp.level;
        },
        lockTranscript(record){
            this.$inertia.get(route('admin.transcript.lock'),{scope:'grade',id:record.id},{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        }
    },
}
</script>