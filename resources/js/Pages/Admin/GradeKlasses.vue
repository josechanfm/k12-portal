<template>
    <AdminLayout title="班別列表" :breadcrumb="breadcrumb">
        <a-typography-title :level="4">學年:{{ grade.year.title }}</a-typography-title>
        <a-typography-title :level="4">年級:{{ grade.tag }}</a-typography-title>
        <div>
            <a-button as="link" v-for="g in grades" :href="route('admin.grade.klasses.index', g.id)" :class="grade.tag==g.tag?'ant-btn ant-btn-primary':'ant-btn'" >
                {{g.tag }}
            </a-button>
        </div>   
        <a-button @click="createRecord()" type="primary">新增班別</a-button>
        
        <a-table :dataSource="klasses" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <a-button as="link" :href="route('director.klasses.show',record.id)" class="ant-btn">班別管理</a-button>
                    <a-button as="link" :href="route('teacher.selected.students', {model:'klass',id:record})" class="ant-btn">學生名單</a-button>
                    <span v-if="record.grade.grade_year <= 3">
                        <a-button as="link"  :href="route('admin.klass.themes.index', record.id)" class="ant-btn">主題</a-button>
                    </span>
                    <span v-else>
                        <a-button as="link"  :href="route('admin.klass.courses.index', record.id)" class="ant-btn">科目</a-button>
                    </span>
                    <a-popconfirm
                        :title="(record.course_locked?'是否確定解鎖':'是否確定鎖定')+record.tag+'的成績表?'"
                        ok-text="Yes"
                        cancel-text="No"
                        @confirm="onClickSelectedTermLock(record.id,0)"
                    >
                        <a-button>
                            <span v-if="record.course_locked">解鎖成績</span>
                            <span v-else>鎖定成績</span>
                        </a-button>
                    </a-popconfirm>
                    <a-button @click="editRecord(record)">修改</a-button>

                    <br>
                    現時學段
                    <template v-for="term in yearTerms">
                        <a-button 
                            @click="onClickSelectedTermLock(record.id,term.value)" 
                            :type="record.current_term==term.value?'secondary':'default'"
                            :disabled="record.course_locked"
                        >{{term.label}}</a-button>
                    </template>

                </template>
                <template v-else-if="column.dataIndex == 'head_teacher'">
                    <!-- {{ record.klass_heads }} -->
                    {{ record.klass_heads.map(t=>t.name_zh).toString() }}
                </template>
                <template v-else-if="column.dataIndex == 'room'">
                    {{ record.room }}
                </template>
                <template v-else-if="column.dataIndex == 'courses'">
                    {{ record.course_count }}
                </template>
                <template v-else-if="column.dataIndex == 'students'">
                    {{ record.student_count }}
                    <!-- {{ record.students.length }} -->
                </template>
                <template v-else-if="column.dataIndex == 'transcript_migrated'">
                    <div class="flex">
                        <div v-if="record.transcript_migrated">
                            <NodeExpandOutlined />
                        </div>
                        <div v-else>
                            <MenuOutlined />
                        </div>
                        <div v-if="record.transcript_locked">
                            <LockOutlined />
                        </div>
                    </div>
                </template>
                <template v-else>
                    {{ record[column.dataIndex] }}
                </template>
            </template>
        </a-table>

        <!-- Modal Start-->
        <a-modal v-model:open="modal.isOpen" :title="modal.title" width="60%">
            <a-form ref="modalRef" :model="modal.data" name="klasses" :label-col="{ span: 8 }" :wrapper-col="{ span: 16 }"
                autocomplete="off" :rules="rules" :validate-messages="validateMessages">
                <a-form-item label="年級代號" name="grade">
                    {{ grade.tag }}
                </a-form-item>
                <a-form-item label="班別號" name="letter">
                    <a-select v-model:value="modal.data.letter" style="width: 100%" placeholder="請選擇..."
                        max-tag-count="responsive" :options="klassLetters"></a-select>
                </a-form-item>
                <a-form-item label="班別別稱" name="byname">
                    <a-input v-model:value="modal.data.byname" />
                </a-form-item>
                <a-form-item label="專業方向" name="stream">
                    <a-radio-group v-model:value="modal.data.stream" :options="studyStreams" option-type="button" button-style="solid" :disabled="modal.mode=='EDIT'"/>
                </a-form-item>
                <a-form-item label="學習計劃" name="study_id">
                    <a-select v-model:value="modal.data.study_id" :options="studies" :fieldNames="{value:'id',label:'title_zh'}" :disabled="modal.mode=='EDIT'"/>
                    </a-form-item>
                <a-form-item label="當前學段" name="current_term">
                    <a-radio-group v-model:value="modal.data.current_term" :options="yearTerms" option-type="button" button-style="solid"/>
                </a-form-item>
                <a-form-item label="學科鎖定" name="course_locked">
                    <a-switch v-model:checked="modal.data.course_locked" checkedChildren="鎖定成績" unCheckedChildren="解鎖成績"/>
                </a-form-item>
                <a-form-item label="教室編號" name="room">
                    <a-input v-model:value="modal.data.room" />
                </a-form-item>
                <a-form-item label="班主任" name="klass_head_ids">
                    <a-select v-model:value="modal.data.klass_head_ids" style="with:100%" placeholder="請選擇..."
                        max-tag-count="responsive" :options="teachers" mode="multiple"
                        :field-names="{ value: 'id', label: 'name_zh'  }"></a-select>
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button key="back" @click="modalCancel">Close</a-button>
                <a-button v-if="modal.mode == 'EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
                <a-button v-if="modal.mode == 'CREATE'" key="Store" type="primary" @click="storeRecord()">Add</a-button>
            </template>
        </a-modal>
        <!-- Modal End-->
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import { NodeExpandOutlined, MenuOutlined, LockOutlined } from '@ant-design/icons-vue'
export default {
    components: {
        AdminLayout,
        ButtonLink,
        NodeExpandOutlined,
        MenuOutlined,
        LockOutlined
    },
    props: ['yearTerms','grades', 'grade', 'klasses', 'klassLetters', 'studyStreams', 'studies','teachers'],
    data() {
        return {
            breadcrumb:[
                {label:"行政管理" ,url:route('admin.dashboard')},
                {label:"學年" ,url:route('admin.years.index')},
                {label:"年級" ,url:route('admin.year.grades.index',this.grade.year_id)},
                {label:"班別" ,url:null},
            ],
            selectedTerm: 1,
            modal: {
                mode: null,
                isOpen: false,
                title: 'Klasses',
                data: {}
            },
            dataSource: [],
            columns: [
                {
                    title: '班別代號',
                    dataIndex: 'tag',
                }, {
                    title: '班主任',
                    dataIndex: 'head_teacher',
                }, {
                    title: '專業方向',
                    dataIndex: 'stream',
                }, {
                    title: '教室編號',
                    dataIndex: 'room',
                }, {
                    title: '科目數目',
                    dataIndex: 'courses',
                }, {
                    title: '學生人數',
                    dataIndex: 'students',
                }, {
                    title: '成績表鎖定',
                    dataIndex: 'transcript_migrated',
                }, {
                    title: '操作',
                    dataIndex: 'operation',
                },
            ],
            rules: {
                letter: {
                    required: true,
                },
                study_id: {
                    required: true,
                }
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
    mounted(){
        // axios.get(route('api.config.item',{key:'year_terms'}))
        //     .then(res=>{
        //         this.yearTerms=res.data
        //     })
        //     .catch(err=>{
        //         console.log(err)
        //     })
    },
    methods: {
        closeModal() {
            this.isOpen = false;
            this.reset();
            this.editMode = false;
        },
        storeRecord() {
            console.log(this.modal.data);
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.post(route('admin.grade.klasses.store',this.grade.id), this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                        console.log(page);
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
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.put(route('admin.grade.klasses.update',[this.grade.id,this.modal.data.id]),  this.modal.data, {
                    onSuccess: (page) => {
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
        editRecord(record) {
            this.modal.data = { ...record };
            this.modal.mode = 'EDIT';
            this.modal.title = "修改班別";
            this.modal.isOpen = true;
        },
        createRecord() {
            this.modal.data = {};
            this.modal.data.grade_id = this.grade.id;
            this.modal.mode = 'CREATE';
            this.modal.title = "新增班別";
            this.modal.isOpen = true;
            this.klasses.forEach(klass => {
                this.klassLetters.forEach((kl, idx) => {
                    if (klass.letter == kl.value) {
                        this.klassLetters[idx].disabled = true;
                    }
                })
            })
        },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        onClickSelectedTermLock(klassId, termId) {
            this.$inertia.post(route('admin.lock.klass',{klassId:klassId,termId:termId}),{},{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError:(err)=>{
                    alert(err.message)                        
                }
            })

        },
        getStudyPlan(text) {
            const study = this.studyPlans.find(study => study.id == text)
            return text;
            //return study.title_zh + " (v."+study.version+")"
        },

    },
}
</script>
