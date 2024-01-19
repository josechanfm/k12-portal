<template>
    <AdminLayout title="就診記錄" :breadcrumb="breadcrumb">
        <div class="py-5">
            <KlassSelector routePath="medical.klass.medicnotes.index" :param="[]" :currentKlass="klass" />
        </div>
        <a-table :dataSource="klass.medicnotes" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <a-button @click="editRecord(record)">修改</a-button>
                </template>
                <template v-else>
                    {{ record[column.dataIndex] }}
                </template>
            </template>
        </a-table>

        <!-- Modal Start-->
        <a-modal :model="modal.data" v-model:visible="modal.isOpen" :title="modal.title" width="60%" okText="Save" @ok="onFormSubmit">
            <a-form ref="modalForm" :model="modal.data" :rules="rules" layout="vertical" @finish="onFormSubmit" id="modalForm">
                <a-row :gutter="10">
                    <a-col :span="12">
                        <a-form-item label="轉送醫院" name="hospital">
                            <a-input v-model:value="modal.data.hospital"/>
                        </a-form-item>
                    </a-col>
                    <a-col :span="12">
                        <a-form-item label="健康狀況" name="health_state">
                            <a-input v-model:value="modal.data.health_state"/>
                        </a-form-item>
                    </a-col>
                </a-row>
                <a-row :gutter="10">
                    <a-col span="8">
                        <a-form-item label="疫苗注射次數" name="vaccinated">
                            <a-input-number v-model:value="modal.data.vaccinated" min="0"/>
                        </a-form-item>
                    </a-col>
                    <a-col span="8">
                        <a-form-item label="最後接種疫苗日期" name="last_vaccine">
                            <a-date-picker v-model:value="modal.data.last_vaccine" :format="dateFormat" :valueFormat="dateFormat"/>
                        </a-form-item>
                    </a-col>
                    <a-col span="8">
                        <a-form-item label="新冠疫苗注射" name="covid_19">
                            <a-input v-model:value="modal.data.covid_19"/>
                        </a-form-item>
                    </a-col>
                </a-row>
                <a-form-item label="曾進行過手術" name="trauma">
                    <a-radio-group v-model:value="modal.data.trauma" button-style="solid">
                        <a-radio-button value="YES">曾進接受過手術</a-radio-button>
                        <a-radio-button value="NO">未曾授受過手術</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="手術描述" name="trauma_treatment" v-if="modal.data.trauma=='YES'">
                    <a-textarea v-model:value="modal.data.trauma_treatment"/>
                </a-form-item>
                <a-form-item label="病史" name="illness">
                    <a-textarea v-model:value="modal.data.illness"/>
                </a-form-item>
                <a-form-item label="食物敏感" name="food_allergy">
                    <a-textarea v-model:value="modal.data.food_allergy"/>
                </a-form-item>
                <a-form-item label="藥物敏感" name="medicine_allergy">
                    <a-textarea v-model:value="modal.data.medicine_allergy"/>
                </a-form-item>
                <div>
                    <a-button type="default" html-type="submit">新增</a-button>
                </div>

            </a-form>
            
            <!-- <template #footer>
                <a-button key="back" @click="handleCancel">Return</a-button>
                <a-button v-if="modal.mode == 'EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
                <a-button v-if="modal.mode == 'CREATE'" key="Store" type="primary" @click="storeRecord()">Add</a-button>
            </template> -->
        </a-modal>
        <!-- Modal End-->

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { affixProps } from 'ant-design-vue/lib/affix';
import dayjs from 'dayjs';
import KlassSelector from '@/Components/KlassSelector.vue';

export default {
    components: {
        AdminLayout,
        dayjs,
        KlassSelector
    },
    props: ['klass'],
    data() {
        return {
            breadcrumb:[
                {label:"Medical" ,url:route('medical')},
                {label:"Treatments" ,url:null},
            ],
            dateFormat: 'YYYY-MM-DD',
            selectedGrade: 4,
            modal: {
                mode: null,
                isOpen: false,
                title: '課外活動',
                data: {}
            },
            columns: [
                {
                    title: '姓生',
                    dataIndex: 'name_zh',
                }, {
                    title: '性別',
                    dataIndex: 'gender',
                }, {
                    title: '出生日期',
                    dataIndex: 'dob',
                }, {
                    title: '醫療卡號',
                    dataIndex: 'dsej_num',
                }, {
                    title: '教青局號',
                    dataIndex: 'medical_num',
                }, {
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],
            rules:{
            },
        }
    },
    created() {
        // dayjs.locale('en');
    },
    mounted(){

    },
    methods: {
        editRecord(record) {
            console.log(record)
            if(record.medicnote==null){
                this.modal.data = {id:0 }
                this.modal.data.student_id=record.id
            }else{
                this.modal.data = { ...record.medicnote }
            }
            this.modal.mode = 'EDIT'
            this.modal.title = "修改健康記錄"
            this.modal.isOpen = true
        },
        onFormSubmit(){
            this.$inertia.put(route("medical.klass.medicnotes.update",[this.klass.id,this.modal.data.id]), this.modal.data, {
                onSuccess: (page) => {
                    this.modal.isOpen=false
                },
                onError: (error) => {
                    console.log(error);
                }
            })
        }
    },
}
</script>
