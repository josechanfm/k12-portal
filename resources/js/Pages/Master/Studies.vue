<template>
<AdminLayout title="Dashboard">
    <template #header>
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            年級學習計劃
        </h2>
    </template>
    <div class="p-2 bg-white rounded-lg flex flex-col gap-1">
        <div class="flex">
            <div class="flex-1">
                <a-select v-model:value="currentYear" class="min-w-32" @change="toStudy(currentYear)">
                    <a-select-option :key="y.code" v-for="y in years"  :value="y.code">
                      {{ y.code }}<a-tag type="green" v-if="y.currentYear">運行中</a-tag>
                    </a-select-option>
                </a-select>
            </div>
            <a-button @click="onClickCreate()" type="primary">新增年級</a-button>
        </div>
        <div class="rounded-lg border-gray-200 border p-2">
            <a-table :dataSource="studies" :columns="columns" size="small" :pagination="false" row-key="id">
                <template #bodyCell="{column, text, record, index}">
                    <div v-if="column.dataIndex=='operation'" class="flex gap-1">
                        <a-button as="link" :href="route('master.studySubjects.edit',record.id)" size="small" type="info">選擇學科</a-button>
                        <a-button @click="onClickEdit(record)" size="small" type="edit">修改</a-button>
                        <a-button @click="onClickDelete(record)" size="small" type="delete">刪除</a-button>
                    </div>
                    <template v-else-if="column.dataIndex=='courses'">
                        <ul>
                            <li :key="klass" v-for="klass in record['klasses']">Class: {{klass.acronym}}</li>
                        </ul>
                    </template>
                    <template v-else-if="column.dataIndex=='grade_year'">
                        {{ getLabel(gradeYears, text) }}
                    </template>
                    <template v-else-if="column.dataIndex=='subjects'">
                        <a-tag :key="subject" v-for="subject in record.subjects" color="orange">
                          <span v-if="subject.pivot.stream!='ALL'">{{ subject.pivot.stream }}</span>  {{subject.title_zh}}:{{ subject.pivot.unit }}</a-tag>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
                <!--  -->
                <template #expandedRowRender="{ record }">
                    <table class="expand_table">
                        <tr>
                            <th>#</th>
                            <th>Code</th>
                            <th>科目名稱</th>
                            <th>科目名稱</th>
                            <th :key="edit_field_zh" v-for="edit_field_zh in ['單位','主/副科','顯示字母?','文/理/全','類','在成績表中?'] ">
                                {{ edit_field_zh }}
                            </th>
                        </tr>
                        <VueDraggableNext handle=".drag-handle" :list="record.subjects" @change="(e)=>{rowChange(e,record)}" tag="tbody" >
                            <tr :key="r.id" v-for="r in record.subjects  ">
                                <td class="drag-handle cursor-grab"><span class="p-1 text-lg bg-gray-50 rounded-lg ">:::</span>{{r.pivot.sort_num }}</td>
                                <td>{{ r.code }}</td>
                                <td>{{ r.title_zh }}</td>
                                <td>{{ r.title_en }}</td>
                                <td :key="edit_key" v-for="edit_key in  ['unit','main','is_letter','stream','type','in_transcript'] ">
                                    <a-input-number v-if="edit_key=='unit'" :key="edit_key" :min="0" v-model:value="r.pivot[edit_key]" @change="updateStudySubject( r.pivot,edit_key)" />
                                    <a-radio-group size="small" v-if="edit_key=='main'" v-model:value="r.pivot[edit_key]" button-style="solid"  @change="updateStudySubject( r.pivot,edit_key)">
                                        <a-radio-button value="MAIN">主科</a-radio-button>
                                        <a-radio-button value="SEC">副科</a-radio-button>
                                    </a-radio-group>
                                    <a-radio-group size="small" v-if="edit_key=='is_letter'" v-model:value="r.pivot[edit_key]" button-style="solid" @change="updateStudySubject( r.pivot,edit_key)">
                                        <a-radio-button value="ALPH">字母</a-radio-button>
                                        <a-radio-button value="DIG">數字</a-radio-button>
                                    </a-radio-group>
                                    <a-radio-group size="small" v-if="edit_key=='stream'" v-model:value="r.pivot[edit_key]" button-style="solid" @change="updateStudySubject( r.pivot,edit_key)">
                                        <a-radio-button value="ALL">全科</a-radio-button>
                                        <a-radio-button value="ART">文</a-radio-button>
                                        <a-radio-button value="SCI">理</a-radio-button>
                                    </a-radio-group>
                                    <a-radio-group size="small" v-if="edit_key=='type'" v-model:value="r.pivot[edit_key]" button-style="solid" @change="updateStudySubject( r.pivot,edit_key)">
                                        <a-radio-button value="SUB">科目</a-radio-button>
                                    </a-radio-group>
                                     <a-radio-group size="small" v-if="edit_key=='in_transcript'" v-model:value="r.pivot[edit_key]" button-style="solid" @change="updateStudySubject( r.pivot,edit_key)">
                                        <a-radio-button :value="true">是</a-radio-button>
                                        <a-radio-button :value="false">否</a-radio-button>
                                    </a-radio-group>
                                </td>
                                <td>
                                    <a-button danger   size="small" @click="deleteStudySubject(r.pivot.id)">刪除</a-button>
                                </td>
                            </tr>
                        </VueDraggableNext>
                    </table>
                     <div class="flex bg-blue-50  w-full items-center">
                                    <div><a-button @click="storeStudySubject(record)" class="bg-blue-200 text-lg text-blue-700 h-fit">+</a-button> </div>
                                    <a-select  v-model:value="record.newSubjects" class="w-full"
                                        mode="multiple" 
                                        >
                                    <a-select-option  :value="sub.id"  :key="sub" v-for="sub in subjects"  >
                                        <div class="flex gap-1">
                                            <div class="flex-1"> {{ sub.title_zh }}</div>
                                            <div> {{ sub.title_en}}</div>
                                        </div> 
                                    </a-select-option >
                                    </a-select>
                            </div>
                </template>
                <template #expandColumnTitle>
                    <span style="color: red">更多</span>
                </template>
                <!--  -->
            </a-table>
        </div>
        <!-- Modal subject selection -->
      
        <!--  -->
        <!-- Modal Start-->
        <a-modal v-model:open="modal.isOpen" :title="modal.title" width="60%">
            <a-form name="Study" ref="modalRef" :model="modal.data" :label-col="{ span: 6 }" :wrapper-col="{ span: 18 }" :rules="rules" :validate-messages="validateMessages">
                <a-form-item label="學年階段.." name="grade_year">
                    <a-select ref="select" v-model:value="modal.data.grade_year" :options="gradeYears" />
                </a-form-item>
                <a-form-item label="版本" name="version">
                    <a-select v-model:value="modal.data.version" :options="versions" />
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
                <!-- <a-form-item label="Klass Heads" name="subject_head_ids">
                    <a-select v-model:value="modal.data.klass_head_ids" :options="teachers" :fieldNames="{value:'id',label:'name_zh'}"/>
                </a-form-item>
 -->
                <a-form-item label="有效" name="active">
                    <a-switch v-model:checked="modal.data.active" :checkedValue="1" :uncheckedValue="0" />
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button key="back" @click="modalCancel">Return</a-button>
                <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
                <a-button v-if="modal.mode=='CREATE'" key="Store" type="primary" @click="storeRecord()">Create</a-button>
            </template>
        </a-modal>
        <!-- Modal End-->
    </div>
</AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import {
    defineComponent,
    reactive
} from 'vue';
import {
    Modal
} from 'ant-design-vue';
import {
    ExclamationCircleOutlined
} from '@ant-design/icons-vue';
import {
    ref,
    createVNode
} from 'vue';
import {
    VueDraggableNext
} from 'vue-draggable-next'
export default {
    components: {
        AdminLayout,
        Modal,
        createVNode,
        ExclamationCircleOutlined,
        VueDraggableNext
    },
    props: ['studies', 'studyStreams', 'gradeYears', 'versions','subjects','years','tempYearCode'],
    data() {
        return {
            currentYear:false,
            modal: {
                mode: null,
                isOpen: false,
                title: 'Subjects',
                data: {}
            },
            columns: [{
                    title: '年級代號',
                    dataIndex: 'grade_year',
                }, {
                    title: '年級名稱',
                    dataIndex: 'title_zh',
                }, , {
                    title: '科目',
                    dataIndex: 'subjects',
                },
                {
                    title: '操作',
                    dataIndex: 'operation',
                },
            ],
            rules: {
                code: {
                    required: true,
                },
                title_zh: {
                    required: true,
                },
                type: {
                    required: true,
                },
                stream: {
                    required: true,
                },
                eletive: {
                    required: true,
                },
                grade_year: {
                    required: true,
                },
                active: {
                    required: true,
                },
            },
            validateMessages: {
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
    created(){
         this.currentYear=this.tempYearCode;
    },
    methods: {
        ///master.studySubjects.sortOrder
        toStudy(val){
            this.$inertia.visit(route('master.studies.index',{yearCode:val} ));
        },
         deleteStudySubject(studySubjectId){
               this.$inertia.delete(route('master.studySubjects.destroy',studySubjectId),{
               }
               , {
                preserveState:true,
                preserveScroll:true,
             })
         },
        updateStudySubject(studySubject,column){
             this.$inertia.patch(route('master.studySubjects.update',studySubject.id),
             {  studySubject:studySubject,column:column}, {
                preserveState:true,
                preserveScroll:true,
             })
        },
        storeStudySubject(record){
             this.$inertia.post(route('master.studySubjects.store'),{id:record.id,newSubjects:record?.newSubjects??[]}, {
                preserveState:true,
                preserveScroll:true,
             })
        },
        rowChange(event,record ) {//record.subjects,record.id
            let subjects=record.subjects
              this.$inertia.post(route('master.studySubjects.sortOrder',{study:record.id}),
             { subjects:subjects }, {
                preserveState:true,
                preserveScroll:true,
             })
        },
        ///
        onClickCreate(record) {
            this.modal.data = {
                active: 0
            };
            this.modal.title = "新增學科";
            this.modal.mode = 'CREATE';
            this.modal.isOpen = true;
        },
        onClickEdit(record) {
            this.modal.data = {
                ...record
            };
            this.modal.title = "修改學科";
            this.modal.mode = 'EDIT';
            this.modal.isOpen = true;
        },
        storeRecord() {
            console.log(this.modal.data);
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.post(route('master.studies.store'), this.modal.data, {
                    onSuccess: (page) => {
                        console.log(page);
                        this.modal.isOpen = false;
                    },
                    onError: (err) => {
                        console.log(err);
                    }
                });
            }).catch(err => {
                console.log(err);
            });
        },
        updateRecord() {
            console.log(this.modal.data);
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.put(route('master.studies.update', this.modal.data.id), this.modal.data, {
                    onSuccess: (page) => {
                        console.log(page);
                        this.modal.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });

        },
        onClickDelete(record) {
            Modal.confirm({
                title: '是否確定',
                content: '刪除所選之主題?',
                okText: '確定',
                cancelText: '取消',
                onOk: () => {
                    this.$inertia.delete(route('master.studies.destroy', record.id), {
                        onSuccess: (page) => {
                            console.log(record.id + "deleted.");
                        },
                        onError: (error) => {
                            console.log(error.message);
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
        modalCancel() {
            this.modal.data = {}
            this.modal.isOpen = false
        },
        onFinishFailed(errorInfo) {
            console.log('errorInfo: ' + errorInfo);
        },
        getLabel(arr, value) {
            const item = arr.find(a => a.value == value)
            return item ? item.label : 'Null value for: ' + value
        }

    },
    watch:{
      

    }
}
</script>

<style scoped>
:deep(.expand_table th) {
    @apply text-start
}

:deep(.expand_table td) {
    @apply text-start
}
</style>
