<template>
    <AdminLayout title="學人個人檔案" :breadcrumb="breadcrumb">
        <div>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                <a-row type="flex">
                    <a-col flex="230px">
                        <a-image
                            :width="200"
                            src="https://zos.alipayobjects.com/rmsportal/jkjgkEfvpUPVyRjUImniVslZfWPnJuuZ.png"
                        />
                    </a-col>
                    <a-col flex="auto">
                        <a-typography-title :level="1">{{ student.name_zh }}</a-typography-title>
                        <a-typography-title :level="3">{{ student.name_fn }}</a-typography-title>
                        <a-typography-title :level="5">{{ student.gender }}</a-typography-title>
                        <a-typography-title :level="5">{{ student.dob }}</a-typography-title>
                    </a-col>
                </a-row>
            </h2>
        </div>
       
        <div :class="isEdit?'formEditOn':'formEditOff'">
            <a-switch v-model:checked="isEdit" @change="onChangeEditMode"/>
            <a-form
                ref="formRef"
                name="advanced_search"
                class="ant-advanced-search-form"
                :model="student"
                >
                <a-collapse v-model:activeKey="activeKey">
                    <a-collapse-panel key="basic" header="學生基本資料">
                        <a-row>
                            <a-col :span="6">
                                <a-form-item label="姓名" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.name_zh" />
                                </a-form-item>
                                <a-form-item label="校內編號" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.sic" />
                                </a-form-item>
                                <a-form-item label="教青局編號" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.dsej_num" />
                                </a-form-item>
                                <a-form-item label="衛生局金咭編號" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.health_num" />
                                </a-form-item>
                                <a-form-item label="學生手提電話" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.phone" />
                                </a-form-item>
                            </a-col>
                            <a-col :span="12">
                                <a-form-item label="外文姓名" :label-col="{ span:8 }" :wrapper-col="{ span:16 }">
                                    <a-input v-model:value="student.name_fn" />
                                </a-form-item>
                                <a-form-item label="成綪表顯示英文名稱" :label-col="{ span:8 }" :wrapper-col="{ span:16 }">
                                    <a-input v-model:value="student.name_display" />
                                </a-form-item>
                                <a-form-item label="過往就請學校" :label-col="{ span:8 }" :wrapper-col="{ span:16 }">
                                    <a-input v-model:value="student.past_school_name" />
                                </a-form-item>
                                <a-row>
                                    <a-col :span="14">
                                        <a-form-item label="學生入學級號" :label-col="{ span:14 }" :wrapper-col="{ span:6 }">
                                            <a-input v-model:value="student.entry_grade" />
                                        </a-form-item>
                                    </a-col>
                                    <a-col :span="10">
                                        <a-form-item label="班別號" :label-col="{span:14 }" :wrapper-col="{ span: 10 }">
                                            <a-input v-model:value="student.start_letter" />
                                        </a-form-item>
                                    </a-col>
                                </a-row>
                                <a-row>
                                    <a-col :span="16">
                                        <a-form-item label="接收短訊用手提電話" :label-col="{ span:12 }" :wrapper-col="{ span:12 }">
                                            <a-input v-model:value="student.phone_sms" />
                                        </a-form-item>
                                    </a-col>
                                    <a-col :span="8">
                                        <a-form-item label="性別" :label-col="{span:12 }" :wrapper-col="{ span: 12 }">
                                            <a-input v-model:value="student.gender" />
                                        </a-form-item>
                                    </a-col>
                                </a-row>
                            </a-col>
                            <a-col :span="6">
                                <a-form-item label="出生日期" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.dob" />
                                </a-form-item>
                                <a-form-item label="入學日期" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.entry_data" />
                                </a-form-item>
                                <a-form-item label="監護人" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.carer" />
                                </a-form-item>
                                <a-form-item label="宗教" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.religion" />
                                </a-form-item>
                                <a-form-item label="住宅電話" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.phone_home" />
                                </a-form-item>

                            </a-col>
                        </a-row>
                    </a-collapse-panel>
                    <a-collapse-panel key="address" header="地址資料">
                        <a-descriptions bordered>
                            <a-descriptions-item label="國籍" >
                                <a-input v-model:value="student.nationality" :bordered="false"/>
                            </a-descriptions-item>
                            <a-descriptions-item label="住址街名" :span="2">
                                <a-input v-model:value="student.address.road_name" />
                            </a-descriptions-item>
                            <a-descriptions-item label="籍貫">
                                <a-input v-model:value="student.native" />
                            </a-descriptions-item>
                            <a-descriptions-item label="門牌大廈">
                                <a-input v-model:value="student.address.building" />
                            </a-descriptions-item>
                            <a-descriptions-item label="居住地區">
                                <a-input v-model:value="student.address.zone" />
                            </a-descriptions-item>
                            <a-descriptions-item label="夜宿地區">
                                <a-input v-model:value="student.address.overnight" />
                            </a-descriptions-item>
                            <a-descriptions-item label="夜宿(國內)地址" :span="2">
                                <a-input v-model:value="student.address.overnight_address" />
                            </a-descriptions-item>
                        </a-descriptions>
                    </a-collapse-panel>
                    <a-collapse-panel key="id_card" header="證件資料">
                        <a-descriptions :column="2" bordered>
                            <a-descriptions-item label="居留種類" >
                                <a-input v-model:value="student.identity_document.residentship" />
                            </a-descriptions-item>
                            <a-descriptions-item label="發出地點" >
                                    <a-input v-model:value="student.identity_document.residentship" />
                            </a-descriptions-item>
                            <a-descriptions-item label="證件編號" >
                                    <a-input v-model:value="student.identity_document.residentship" />
                            </a-descriptions-item>
                            <a-descriptions-item label="證件有效日期" >
                                    <a-input v-model:value="student.identity_document.residentship" />
                            </a-descriptions-item>
                            <a-descriptions-item label="回鄉證" >
                                    <a-input v-model:value="student.identity_document.residentship" />
                            </a-descriptions-item>
                        </a-descriptions>
                        
                    </a-collapse-panel>
                    <a-collapse-panel key="bank" header="銀行資料">
                        <a-descriptions bordered>
                            <a-descriptions-item label="銀行" >
                                <a-input v-model:value="student.bank.bank_name" />
                            </a-descriptions-item>
                            <a-descriptions-item label="戶口名稱" >
                                <a-input v-model:value="student.bank.account_name" />
                            </a-descriptions-item>
                            <a-descriptions-item label="銀行帳號" >
                                <a-input v-model:value="student.bank.account_number" />
                            </a-descriptions-item>
                        </a-descriptions>
                    </a-collapse-panel>
                    <a-collapse-panel key="detail" header="學生詳細資料">
                        <a-descriptions bordered>
                            <a-descriptions-item label="聖名" >
                                <a-input v-model:value="student.detail.holy_name" />
                            </a-descriptions-item>
                            <a-descriptions-item label="領洗日期" >
                                <a-input v-model:value="student.detail.baptized" />
                            </a-descriptions-item>
                            <a-descriptions-item label="初領聖體日期" >
                                <a-input v-model:value="student.detail.first_communion" />
                            </a-descriptions-item>
                            <a-descriptions-item label="有效日期(逗留)" >
                                <a-input v-model:value="student.detail.valid_stay" />
                            </a-descriptions-item>
                            <a-descriptions-item label="兄弟姊妹總數" >
                                <a-input v-model:value="student.detail.sibling" />
                            </a-descriptions-item>
                            <a-descriptions-item label="已工作兄弟姊妹總數" >
                                <a-input v-model:value="student.detail_sibling_at_work" />
                            </a-descriptions-item>
                            <a-descriptions-item label="入校年級(過去就讀)" >
                                <a-input v-model:value="student.detail.past_grade" />
                            </a-descriptions-item>
                            <a-descriptions-item label="入校日期(過去就讀)" >
                                <a-input v-model:value="student.detail.past_entry_date" />
                            </a-descriptions-item>
                            <a-descriptions-item label="就讀年級(過去就讀)" >
                                <a-input v-model:value="student.detail.past_entry_grade" />
                            </a-descriptions-item>
                        </a-descriptions>
                    </a-collapse-panel>
                    <a-collapse-panel key="parent" header="父母資料">
                        <a-descriptions bordered>
                            <a-descriptions-item label="父親姓名" >
                                <a-input v-model:value="student.parent.father_name" />
                            </a-descriptions-item>
                            <a-descriptions-item label="父親工作機構" >
                                <a-input v-model:value="student.parent.father_organization" />
                            </a-descriptions-item>
                            <a-descriptions-item label="父親職業" >
                                <a-input v-model:value="student.parent.father_job" />
                            </a-descriptions-item>
                            <a-descriptions-item label="父親手提電話" >
                                <a-input v-model:value="student.parent.father_phone" />
                            </a-descriptions-item>
                            <a-descriptions-item label="父親住址" :span="2">
                                <a-input v-model:value="student.parent.father_address" />
                            </a-descriptions-item>
                            <a-descriptions-item label="母親姓名" >
                                <a-input v-model:value="student.parent.mother_name" />
                            </a-descriptions-item>
                            <a-descriptions-item label="母親工作機構" >
                                <a-input v-model:value="student.parent.mother_organization" />
                            </a-descriptions-item>
                            <a-descriptions-item label="母親職業" >
                                <a-input v-model:value="student.parent.mother_job" />
                            </a-descriptions-item>
                            <a-descriptions-item label="母親手提電話" >
                                <a-input v-model:value="student.parent.mother_phone" />
                            </a-descriptions-item>
                            <a-descriptions-item label="母親住址" >
                                <a-input v-model:value="student.parent.mother_address" />
                            </a-descriptions-item>
                        </a-descriptions>
                    </a-collapse-panel>
                    <a-collapse-panel key="guardian" header="監護人資料">
                        <a-descriptions bordered>
                            <a-descriptions-item label="監護人姓名" >
                                <a-input v-model:value="student.guardian.name" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人職業" >
                                <a-input v-model:value="student.guardian.job" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人機構電話" >
                                <a-input v-model:value="student.guardian.organization_phone" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人關係" >
                                <a-input v-model:value="student.guardian.relation" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人工作機構" :span="2">
                                <a-input v-model:value="student.guardian.organization" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人電話" >
                                <a-input v-model:value="student.guardian.phone" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人居住地區" :span="2">
                                <a-input v-model:value="student.guardian.zone"/>
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人郵政編號" >
                                <a-input v-model:value="student.guardian.post_code"/>
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人街道名稱" :span="2">
                                <a-input v-model:value="student.guardian.road_name" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人門牌,大廈,樓座">
                                <a-input v-model:value="student.guardian.address" />
                            </a-descriptions-item>
                        </a-descriptions>
                    </a-collapse-panel>
                    <a-collapse-panel key="health" header="健康相關">
                        <a-descriptions bordered>
                            <a-descriptions-item label="醫院" >
                                <a-input v-model:value="student.healthcare.hospital" />
                            </a-descriptions-item>
                            <a-descriptions-item label="學生健康情況" :span="2">
                                <a-input v-model:value="student.healthcare.health_state" />
                            </a-descriptions-item>
                            <a-descriptions-item label="已接種新冠疫苖" >
                                <a-input v-model:value="student.healthcare.covid_19" />
                            </a-descriptions-item>
                            <a-descriptions-item label="疫苖接種次數" >
                                <a-input v-model:value="student.healthcare.vaccine_count" />
                            </a-descriptions-item>
                            <a-descriptions-item label="最近接種疫苖" >
                                <a-input v-model:value="student.healthcare.last_vaccine" />
                            </a-descriptions-item>
                            <a-descriptions-item label="患病"  :span="3">
                                <a-input v-model:value="student.healthcare.illness" />
                            </a-descriptions-item>
                            <a-descriptions-item label="創傷"  :span="3">
                                <a-input v-model:value="student.healthcare.trauma" />
                            </a-descriptions-item>
                            <a-descriptions-item label="創傷治療"  :span="3">
                                <a-input v-model:value="student.healthcare.trauma_treatment" />
                            </a-descriptions-item>
                            <a-descriptions-item label="食物過敏"  :span="3">
                                <a-input v-model:value="student.healthcare.food_allergy" />
                            </a-descriptions-item>
                            <a-descriptions-item label="藥物過敏"  :span="3">
                                <a-input v-model:value="student.healthcare.medicine_allergy" />
                            </a-descriptions-item>
                        </a-descriptions>
                    </a-collapse-panel>
                </a-collapse>
            </a-form>
        </div>
        <a-typography-title :level="3">Personal Files</a-typography-title>
        <ol>
            <li v-for="file in student.archives">
                {{file.file_type}}: {{file.file_name}}
            </li>
        </ol>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link } from '@inertiajs/inertia-vue3';

export default {
    components: {
        AdminLayout, Link
    },
    props: ['student'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('manage')},
                {label:"學人個人檔案",url:null}
            ],
            activeKey: ['basic'],
            isEdit:false,
            labelCol: {span: 10},
            wrapperCol: {span: 14},
        }
    },
    created(){
        if(this.student.address==null) this.student.address={}
        if(this.student.identity_document==null) this.student.identity_document={}
        if(this.student.bank==null) this.student.bank={}
        if(this.student.parent==null) this.student.parent={}
        if(this.student.guardian==null) this.student.guardian={}
        if(this.student.healthcare==null) this.student.healthcare={}
    }, 
    methods: {
        onChangeEditMode(){
            console.log(this.isEdit);
        }
    },
}
</script>

<style>
.ant-input{
    border:none
}
.ant-form-item-label label{
    font-weight: bold;
}
.formEditOn .ant-input{
    border:1px solid #ccc
}
.formEditOff .ant-input{
    border:none;
    pointer-events: none;
}

</style>