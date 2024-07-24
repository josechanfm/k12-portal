<template>
    <AdminLayout title="個人信息" :breadcrumb="breadcrumb">
        <div>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                <a-row type="flex">
                    <a-col flex="230px">
                        <a-image :width="200" v-if="student.avatars && student.avatars[0]"
                            :src="student.avatars[0].image.original_url" />
                    </a-col>
                    <a-col flex="auto">
                        <a-descriptions
                            bordered
                            :column="{ xxl: 2, xl: 2, lg: 2, md: 2, sm: 2, xs: 1 }"
                        >
                            <a-descriptions-item label="中文姓名：">{{ student.name_zh }}</a-descriptions-item>
                            <a-descriptions-item label="外文姓名：">{{ student.name_fn }}</a-descriptions-item>
                            <a-descriptions-item label="性別：">{{ student.gender }}</a-descriptions-item>
                            <a-descriptions-item label="出生日期(年齡)：">{{ student.dob }} ({{ calculateAge(student.dob) }})</a-descriptions-item>
                        </a-descriptions>
                    </a-col>
                </a-row>
            </h2>
        </div>
        <div class="p-5">
            修改模式: <a-switch v-model:checked="isEdit" @change="onChangeEditMode" checkedChildren="開" unCheckedChildren="關"/>
        </div>
        
        <div :class="isEdit ? 'formEditOn' : 'formEditOff'">
            <a-form ref="formRef" name="advanced_search" class="ant-advanced-search-form" :model="student"
                :rules="rules" @finish="onFinish" @finishFailed="onFinishFailed">
                <a-collapse v-model:activeKey="activeKey">
                    <a-collapse-panel key="avatar" header="頭像照片">
                        <a-row>
                            <a-col :span="4" v-for="avatar in student.avatars">
                                <a-image :width="200" :src="avatar.image.preview_url" />
                                <br>
                                {{ avatar.full_tag }}
                            </a-col>
                        </a-row>
                    </a-collapse-panel>

                    <a-collapse-panel key="basic" header="基本信息">
                        <a-row>
                            <a-col :span="6">
                                <a-form-item label="姓名" name="name_zh" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.name_zh" />
                                </a-form-item>
                                <a-form-item label="校內編號" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.sid" />
                                </a-form-item>
                                <a-form-item label="教青局編號" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.dsedj_num" />
                                </a-form-item>
                                <a-form-item label="衛生局金咭編號" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.ssm_num" />
                                </a-form-item>
                                <a-form-item label="學生手提電話" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-input v-model:value="student.phone" />
                                </a-form-item>
                            </a-col>
                            <a-col :span="12">
                                <a-form-item label="外文姓名" :label-col="{ span: 8 }" :wrapper-col="{ span: 16 }">
                                    <a-input v-model:value="student.name_fn" />
                                </a-form-item>
                                <a-form-item label="成綪表顯示英文名稱" :label-col="{ span: 8 }" :wrapper-col="{ span: 16 }">
                                    <a-input v-model:value="student.name_display" />
                                </a-form-item>
                                <a-form-item label="過往就請學校" :label-col="{ span: 8 }" :wrapper-col="{ span: 16 }">
                                    <a-input v-model:value="student.previour_school" />
                                </a-form-item>
                                <a-row>
                                    <a-col :span="14">
                                        <a-form-item label="過往就年級" :label-col="{ span: 14 }" :wrapper-col="{ span: 6 }">
                                            <a-input v-model:value="student.previour_grade" />
                                        </a-form-item>
                                    </a-col>
                                    <a-col :span="10">
                                        <a-form-item label="班別號" :label-col="{ span: 14 }" :wrapper-col="{ span: 10 }">
                                            <a-input v-model:value="student.start_klass" />
                                        </a-form-item>
                                    </a-col>
                                </a-row>
                                <a-row>
                                    <a-col :span="16">
                                        <a-form-item label="接收短訊用手提電話" :label-col="{ span: 12 }"
                                            :wrapper-col="{ span: 12 }">
                                            <a-input v-model:value="student.phone_sms" />
                                        </a-form-item>
                                    </a-col>
                                    <a-col :span="8">
                                        <a-form-item label="性別" :label-col="{ span: 12 }" :wrapper-col="{ span: 12 }">
                                            <a-input v-model:value="student.gender" />
                                        </a-form-item>
                                    </a-col>
                                </a-row>
                            </a-col>
                            <a-col :span="6">
                                <a-form-item label="出生日期" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-date-picker v-model:value="student.dob" :format="dateFormat" :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item label="入學日期" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    <a-date-picker v-model:value="student.entry_date" :format="dateFormat" :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item label="監護人" :label-col="labelCol" :wrapper-col="wrapperCol">
                                    display guardian
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

                    <a-collapse-panel key="id_card" header="證件信息">
                        <a-row>
                            <a-col :span="8">
                                <a-form-item label="證件類別" name="id_type">
                                    <a-select v-model:value="student.id_type" :options="idTypeOptions" />
                                </a-form-item>
                                <a-form-item label="請指明證件類別" name="id_type_other" v-if="student.id_type == 'OT'">
                                    <a-input v-model:value="student.id_type_other" />
                                </a-form-item>
                                <template v-if="student.id_type == 'OT'">
                                    <a-form-item label="簽發地點">
                                        <a-select v-model:value="student.issue_place" :options="issuePlaceOptions" />
                                    </a-form-item>
                                    <a-form-item label="請指明簽發地點" name="issue_place_other"
                                        v-if="student.issue_place == 'OT'">
                                        <a-input v-model:value="student.issue_place_other" />
                                    </a-form-item>
                                </template>
                                <a-form-item label="證件編號" name="id_num">
                                    <a-input v-model:value="student.id_num" />
                                </a-form-item>
                            </a-col>
                            <a-col :span="8">
                                <template v-if="student.id_type == 'CT'">
                                    <a-form-item label="逗留簽發日期">
                                        <a-date-picker v-model:value="student.stay_issue" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                    <a-form-item label="逗留至有效日期">
                                        <a-date-picker v-model:value="student.stay_expired" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                </template>
                                <template v-else>
                                    <a-form-item label="本次發出日期">
                                        <a-date-picker v-model:value="student.id_issue" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                    <a-form-item label="有效日期">
                                        <a-date-picker v-model:value="student.id_expired" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                </template>
                            </a-col>
                            <a-col :span="8">
                                <a-form-item label="回鄉證編號">
                                    <a-input v-model:value="student.hrc_num" />
                                </a-form-item>
                                <a-form-item label="回鄉證簽發日期">
                                    <a-date-picker v-model:value="student.hrc_issue" :format="dateFormat"
                                        :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item label="回鄉證有效日期">
                                    <a-date-picker v-model:value="student.hrc_expired" :format="dateFormat"
                                        :valueFormat="dateFormat" />
                                </a-form-item>
                            </a-col>
                        </a-row>
                    </a-collapse-panel>

                    <a-collapse-panel key="detail" header="補充信息">
                        <a-descriptions bordered v-if="student.detail">
                            <a-descriptions-item label="聖名">
                                <a-input v-model:value="student.detail.holy_name" />
                            </a-descriptions-item>
                            <a-descriptions-item label="領洗日期">
                                <a-date-picker v-model:value="student.detail.baptized" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-descriptions-item>
                            <a-descriptions-item label="初領聖體日期">
                                <a-date-picker v-model:value="student.detail.first_communion" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-descriptions-item>
                            <a-descriptions-item label="有效日期(逗留)">
                                <a-date-picker v-model:value="student.detail.stay_issue" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-descriptions-item>
                            <a-descriptions-item label="兄弟姊妹總數">
                                <a-input v-model:value="student.detail.sibling" />
                            </a-descriptions-item>
                            <a-descriptions-item label="已工作兄弟姊妹總數">
                                <a-input v-model:value="student.detail.sibling_at_work" />
                            </a-descriptions-item>
                            <a-descriptions-item label="入校年級(過去就讀)">
                                <a-input v-model:value="student.detail.previour_grade" />
                            </a-descriptions-item>
                            <a-descriptions-item label="入校日期(過去就讀)">
                                <a-date-picker v-model:value="student.detail.entry_date" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-descriptions-item>
                            <a-descriptions-item label="就讀年級(過去就讀)">
                                <a-input v-model:value="student.detail.entry_klass" />
                            </a-descriptions-item>
                        </a-descriptions>
                    </a-collapse-panel>

                    <a-collapse-panel key="address" header="住址信息">
                        <a-descriptions bordered v-if="student.address">
                            <a-descriptions-item label="住址街名" :span="2">
                                <a-input v-model:value="student.address.road" />
                            </a-descriptions-item>
                            <a-descriptions-item label="門牌大廈">
                                <a-input v-model:value="student.address.building" />
                            </a-descriptions-item>
                            <a-descriptions-item label="居住地區">
                                <a-input v-model:value="student.address.zone" />
                            </a-descriptions-item>

                        </a-descriptions>
                    </a-collapse-panel>

                    <a-collapse-panel key="bank" header="銀行信息">
                        <a-descriptions bordered>
                            <a-descriptions-item label="銀行">
                                <a-input v-model:value="student.bank.bank_name" />
                            </a-descriptions-item>
                            <a-descriptions-item label="戶口名稱">
                                <a-input v-model:value="student.bank.account_name" />
                            </a-descriptions-item>
                            <a-descriptions-item label="銀行帳號">
                                <a-input v-model:value="student.bank.account_number" />
                            </a-descriptions-item>
                        </a-descriptions>
                    </a-collapse-panel>


                    <a-collapse-panel key="parent" header="父母信息" >
                        <a-descriptions bordered  v-if="student.father">
                            <a-form-item label="父親姓名">
                                <a-input v-model:value="student.father.name_zh" />
                            </a-form-item>
                            <a-form-item label="父親工作機構">
                                <a-input v-model:value="student.father.occupation" />
                            </a-form-item>
                            <a-form-item label="父親職業">
                                <a-input v-model:value="student.father.occupation" />
                            </a-form-item>
                            <a-form-item label="父親手提電話">
                                <a-input v-model:value="student.father.mobile" />
                            </a-form-item>
                            <a-form-item label="父親住址" :span="2">
                                <a-input v-model:value="student.father.name_zh" />
                            </a-form-item>
                            <a-form-item label="母親姓名">
                                <a-input v-model:value="student.mother.name_zh" />
                            </a-form-item>
                            <a-form-item label="母親工作機構">
                                <a-input v-model:value="student.mother.organization" />
                            </a-form-item>
                            <a-form-item label="母親職業">
                                <a-input v-model:value="student.mother.occupation" />
                            </a-form-item>
                            <a-form-item label="母親手提電話">
                                <a-input v-model:value="student.mother.mobile" />
                            </a-form-item>
                            <a-form-item label="母親住址">
                                <a-input v-model:value="student.mother.name_zh" />
                            </a-form-item>
                        </a-descriptions>
                    </a-collapse-panel>

                    <a-collapse-panel key="guardian" header="監護人信息">
                        <a-descriptions bordered v-if="student.guardian">
                            <a-descriptions-item label="監護人姓名">
                                <a-input v-model:value="student.guardian.name_zh" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人職業">
                                <a-input v-model:value="student.guardian.occupation" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人機構電話">
                                <a-input v-model:value="student.guardian.mobile" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人關係">
                                <a-input v-model:value="student.guardian.kinship" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人工作機構" :span="2">
                                <a-input v-model:value="student.guardian.organization" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人電話">
                                <a-input v-model:value="student.guardian.mobile" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人居住地區" :span="2">
                                <a-input v-model:value="student.guardian.mobile" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人郵政編號">
                                <a-input v-model:value="student.guardian.mobile" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人街道名稱" :span="2">
                                <a-input v-model:value="student.guardian.mobile" />
                            </a-descriptions-item>
                            <a-descriptions-item label="監護人門牌,大廈,樓座">
                                <a-input v-model:value="student.guardian.mobile" />
                            </a-descriptions-item>
                        </a-descriptions>
                    </a-collapse-panel>

                    <a-collapse-panel key="health" header="健康信息">
                        <a-descriptions bordered v-if="student.health">
                            <a-descriptions-item label="醫院">
                                <a-input v-model:value="student.health.hospital" />
                            </a-descriptions-item>
                            <a-descriptions-item label="學生健康情況" :span="2">
                                <a-input v-model:value="student.health.status" />
                            </a-descriptions-item>
                            <a-descriptions-item label="慢性疾患">
                                <a-input v-model:value="student.health.chronic" />
                            </a-descriptions-item>
                            <a-descriptions-item label="遺傳性疾病">
                                <a-input v-model:value="student.health.hereditary" />
                            </a-descriptions-item>
                            <a-descriptions-item label="（食物及藥物）過敏症">
                                <a-input v-model:value="student.health.disease" />
                            </a-descriptions-item>
                            <a-descriptions-item label="remark" :span="3">
                                <a-input v-model:value="student.health.remark" />
                            </a-descriptions-item>
                            <a-descriptions-item label="創傷" :span="3">
                                trauma
                            </a-descriptions-item>
                            <a-descriptions-item label="創傷治療" :span="3">
                                trauma treatment
                            </a-descriptions-item>
                            <a-descriptions-item label="過敏" :span="3">
                                <a-input v-model:value="student.health.allergy" />
                            </a-descriptions-item>
                            <a-descriptions-item label="藥物過敏" :span="3">
                                medician allergy
                            </a-descriptions-item>
                        </a-descriptions>
                    </a-collapse-panel>

                    <a-collapse-panel key="siblings" header="本校兄弟姊妹">
                        <a-table :dataSource="student.siblings" :columns="columnSiblings">
                            <template #bodyCell="{ column, text, record, index }">
                                <template v-if="column.dataIndex == 'klasses'">
                                    <ol>
                                        <li v-for="klass in record.klasses">{{ klass.school_year }}-{{ klass.tag }}</li>
                                    </ol>
                                </template> 
                                <template v-else>
                                    {{record[column.dataIndex]}}
                                </template>
                            </template>
                        </a-table>

                        <a-button as="link" :href="route('director.student.siblings',student.id)" class="ant-btn">連結本校兄弟姊妹</a-button>
                    </a-collapse-panel>

                </a-collapse>

                <a-form-item :wrapper-col="{ offset: 8, span: 16 }">
                    <a-button type="primary" html-type="submit">Submit</a-button>
                </a-form-item>

            </a-form>
        </div>
        <a-typography-title :level="3">個人文件檔案</a-typography-title>
        <ol>
            <li v-for="file in student.medias">
                {{file.collection_name }}: <a :href="file.original_url" target="_blank">{{ file.file_name }}</a>
            </li>
        </ol>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link } from '@inertiajs/vue3';

export default {
    components: {
        AdminLayout, Link
    },
    props: ['student'],
    data() {
        return {
            breadcrumb: [
                { label: "主控台", url: route('director.dashboard') },
                { label: "學人個人檔案", url: null }
            ],
            columnSiblings:[
                {title:'姓名', dataIndex: 'name_zh'},
                {title:'性別', dataIndex: 'gender'},
                {title:'出生日期', dataIndex: 'dob'},
                {title:'就讀班級', dataIndex: 'klasses'},
            ],
            rules: {
                name_zh: { required: true },
                id_type: { required: true },
                id_type_other: { required: true },
                issue_place_other: { required: true },
                id_num: { required: true },
            },
            dateFormat: 'YYYY-MM-DD',
            idTypeOptions: [
                { value: 'MP', label: '永久居民身份證' },
                { value: 'MR', label: '居民身分證' },
                { value: 'MT', label: '非永久居民身份證' },
                { value: 'CT', label: '臨時逗留證' },
                { value: 'CN', label: '中國內地身份證' },
                { value: 'OT', label: '其他' }
            ],
            pobOptions: [
                { value: 'MO', label: '澳門' },
                { value: 'CN', label: '內地' },
                { value: 'OT', label: '其他' },
            ],
            issuePlaceOptions: [
                { value: 'MO', label: '澳門' },
                { value: 'CN', label: '內地' },
                { value: 'OT', label: '其他' },
            ],

            activeKey: ['basic'],
            isEdit: false,
            labelCol: { span: 10 },
            wrapperCol: { span: 14 },
        }
    },
    created() {
        this.init()        
    },
    mounted(){
        console.log('mounted')
    },  
    methods: {
        init(){
            if (this.student.address == null) this.student.address = {}
            if (this.student.identity_document == null) this.student.identity_document = {}
            if (this.student.bank == null) this.student.bank = {}
            if (this.student.detail == null) this.student.detail = {}
            if (this.student.health == null) this.student.health = {}
            if(this.student.relations){
                var mother=this.student.relations.find(r=>r.relation=='0MOTHER')
                var father=this.student.relations.find(r=>r.relation=='1FATHER')
                var guardian=this.student.relations.find(r=>r.relation=='0MOTHER')
            }else{
                this.student.relations=[];
            }
            if(mother){
                this.student.mother=mother
            }else{
                this.student.mother={"relation":'0MOTHER'}
                this.student.relations.push({"relation":'0MOTHER'})
            }
            if(father){
                this.student.father=father
            }else{
                this.student.father={"relation":'1FATHER'}
                this.student.relations.push(this.student.father)
            }
            if(guardian){
                this.student.guardian=guardian
            }else{
                this.student.guardian={"relation":'2GUARDIAN'}
                this.student.relations.push(this.student.guardian)
            }
            // this.student.father=father??{"relation":'1FATHER'};
            // this.student.mother=mother??{"relation":'0MONTHER'};
            // this.student.guardian=guardian??{"relation":'2GUARDIAN'};

            // this.student.father=this.student.relations.find(r=>r.relation=='1FATHER')
            // this.student.mother=this.student.relations.find(r=>r.relation=='0MOTHER')
            // this.student.guardian=this.student.relations.find(r=>r.relation=='2GUARDIAN')
        },
        onChangeEditMode() {
            console.log(this.isEdit);
        },
        onFinish() {
            console.log(this.student.health);
            this.$inertia.patch(route('director.students.update', this.student.id), this.student, {
                onSuccess: (page) => {
                    this.init()                    
                },
                onError: (error) => {
                    console.log(error);
                }
            })
        },
        onFinishFailed(error) {
            console.log(error)
        },
        calculateAge(dob){
          let currentDate = new Date();
          let birthDate = new Date(dob);
          let difference = currentDate - birthDate;
          let age = Math.floor(difference/31557600000);
          return age
        }


    },
}
</script>

<style>
.ant-input {
    border: none
}

.ant-form-item-label label {
    font-weight: bold;
}

.formEditOn .ant-input, .formEditOn .ant-picker {
    border: 1px solid #ccc
}

.formEditOff .ant-input, .formEditOff .ant-picker, .formEditOff .ant-select:not(.ant-select-customize-input) .ant-select-selector{
    border: none;
    pointer-events: none;
}

</style>