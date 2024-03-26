<template>
    <AdminLayout title="學生註冊表">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Student Registration
            </h2>
        </template>
        <hr />
        Current Year:{{ years.find(y => y.current_term == 1).code }}
        <ul>
            <li v-for="year in years">{{ year.code }}</li>
        </ul>
        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg p-5">
                <a-typography-title :level="3" class="text-center">學生註冊表</a-typography-title>
                <a-divider style="height: 2px; background-color: #7cb305" />
                <a-form ref="formRef" :label-col="{ span: 8 }" :model="registration" :rules="rules" @finish="onFinish">
                    <a-row>
                        <a-col :span="8">
                            <a-form-item label="姓名(中文)" name="student_name_zh">
                                <a-input v-model:value="student.name_zh" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="16">
                            <a-form-item label="姓名(外文)" name="student_name_fn" :label-col="{ span: 4 }">
                                <a-input v-model:value="student.name_fn" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-row>
                        <a-col :span="8">
                            <a-form-item label="性別" name="student_gender">
                                <a-radio-group v-model:value="student.gender" button-style="solid">
                                    <a-radio-button value="M">Male</a-radio-button>
                                    <a-radio-button value="F">Female</a-radio-button>
                                </a-radio-group>
                            </a-form-item>
                            <a-form-item label="出生地點" name="student_pob">
                                <a-select v-model:value="student.pob" :options="pobOptions" />
                            </a-form-item>
                            <a-form-item label="請指明出生地點" name="student_pob_other" v-if="student.pob == 'OT'">
                                <a-input v-model:value="student.pob_other" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="出生日期" name="student_dob">
                                <a-date-picker v-model:value="student.dob" :format="dateFormat"
                                    :valueFormat="dateFormat" />
                            </a-form-item>
                            <a-form-item label="國籍" name="nationality">
                                <a-input v-model:value="student.nationality" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="宗教" name="religion">
                                <a-input v-model:value="student.religion" />
                            </a-form-item>
                            <a-form-item label="籍貫" name="native">
                                <a-input v-model:value="student.native" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-row>
                        <a-col :span="16">
                            <a-form-item label="學歷" name="new" :label-col="{ span: 4 }">
                                <a-radio-group v-model:value="student.new" button-style="solid">
                                    <a-radio-button value="Y">新生</a-radio-button>
                                    <a-radio-button value="N">舊生</a-radio-button>
                                </a-radio-group>
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-row>
                        <a-col span="8">
                            <a-form-item label="上學期在" name="previour_school">
                                <template v-if="student.new == 'Y'">
                                    <a-input v-model:value="student.previour_school" />
                                </template>
                                <template v-else>
                                    本校
                                </template>
                            </a-form-item>
                        </a-col>
                        <a-col span="8">
                            <a-form-item label="年級" name="school_year">
                                <a-input v-model:value="student.school_year" />
                            </a-form-item>
                        </a-col>
                        <a-col span="8" v-if="student.new == 'N'">
                            <a-form-item label="班別" name="school_klass">
                                <a-input v-model:value="student.school_klass" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-typography-title :level="5">身份證明文件</a-typography-title>
                    <a-row>
                        <a-col :span="8">
                            <a-form-item label="證件類別" name="student_id_type">
                                <a-select v-model:value="student.id_type" :options="idTypeOptions" />
                            </a-form-item>
                            <a-form-item label="請指明證件類別" name="student_id_type_other" v-if="student.id_type == 'OT'">
                                <a-input v-model:value="student.id_type_other" />
                            </a-form-item>
                            <template v-if="student.id_type == 'OT'">
                                <a-form-item label="簽發地點" name="issue_place">
                                    <a-select v-model:value="student.issue_place" :options="issuePlaceOptions" />
                                </a-form-item>
                                <a-form-item label="請指明簽發地點" name="student_issue_place_other"
                                    v-if="student.issue_place == 'OT'">
                                    <a-input v-model:value="student.issue_place_other" />
                                </a-form-item>
                            </template>

                            <a-form-item label="證件編號" name="student_id_num">
                                <a-input v-model:value="student.id_num" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <template v-if="student.id_type == 'CT'">
                                <a-form-item label="逗留簽發日期" name="stay_issue">
                                    <a-date-picker v-model:value="student.stay_issue" :format="dateFormat"
                                        :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item label="逗留至有效日期" name="stay_expired">
                                    <a-date-picker v-model:value="student.stay_expired" :format="dateFormat"
                                        :valueFormat="dateFormat" />
                                </a-form-item>
                            </template>
                            <template v-else>
                                <a-form-item label="本次發出日期" name="student.id_issue">
                                    <a-date-picker v-model:value="student.id_issue" :format="dateFormat"
                                        :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item label="有效日期" name="student.id_expired">
                                    <a-date-picker v-model:value="student.id_expired" :format="dateFormat"
                                        :valueFormat="dateFormat" />
                                </a-form-item>
                            </template>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="回鄉證編號" name="student_hrc_num">
                                <a-input v-model:value="student.hrc_num" />
                            </a-form-item>
                            <a-form-item label="回鄉證簽發日期" name="student.hrc_issue">
                                <a-date-picker v-model:value="student.hrc_issue" :format="dateFormat"
                                    :valueFormat="dateFormat" />
                            </a-form-item>
                            <a-form-item label="回鄉證有效日期" name="student.hrc_expired">
                                <a-date-picker v-model:value="student.hrc_expired" :format="dateFormat"
                                    :valueFormat="dateFormat" />
                            </a-form-item>
                            <a-form-item label="教青局學生證號碼" name="stuent_dsedj_num">
                                <a-input v-model:value="student.dsedj_num" />
                            </a-form-item>
                            <a-form-item label="醫療咭號碼" name="student_ssm_num">
                                <a-input v-model:value="student.ssm_num" />
                            </a-form-item>

                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-typography-title :level="5">學生住址及家庭資料</a-typography-title>
                    <a-row>
                        <a-col :span="16">
                            <a-form-item label="街道名稱" name="student_resident_street" :label-col="{ span: 4 }">
                                <a-input v-model:value="student.resident_street" />
                            </a-form-item>
                            <a-form-item label="門牌，大廈，樓座" name="student_resident_building" :label-col="{ span: 4 }">
                                <a-input v-model:value="student.resident_building" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="居住地區" name="student_resident_zone">
                                <a-input v-model:value="student.resident_zone" />
                            </a-form-item>
                            <a-form-item label="住宅電話" name="student_resident_phone">
                                <a-input v-model:value="student.resident_phone" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-row>
                        <a-col :span="16">
                            <a-form-item label="夜宿地及地址" name="student_overnight_address" :label-col="{ span: 4 }">
                                <a-input v-model:value="student.overnight_address" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="晚間住宿地區" name="student_overnight_zone">
                                <a-input v-model:value="student.overnight_zone" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-row>
                        <a-col :span="8">
                            <a-form-item label="緊急聯繫電話" name="student_emergency_mobile">
                                <a-input v-model:value="student.emergency_mobile" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="兄弟姊妹總數" name="student_bro_count">
                                <a-input v-model:value="student.bro_count" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="家庭狀況" name="student_family_status">
                                <a-input v-model:value="student.family_status" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-typography-title :level="5">監護人</a-typography-title>
                    <a-row>
                        <a-col :span="10">
                            <a-form-item label="監護人姓名" name="guardian_name">
                                <a-input v-model:value="guardian.name" />
                            </a-form-item>
                            <a-form-item label="聯絡電話" name="guardian_mobile">
                                <a-input v-model:value="guardian.mobile" />
                            </a-form-item>

                            <a-form-item label="街道名稱" name="guardian_street">
                                <a-input v-model:value="guardian.street" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="10">
                            <a-form-item label="興監護人關係:" name="guardian_relationship">
                                <a-input v-model:value="guardian.relatinship" />
                            </a-form-item>
                            <a-form-item label="職業" name="guardian_occupation">
                                <a-input v-model:value="guardian.occupation" />
                            </a-form-item>
                            <a-form-item label="門牌，大廈，樓座" name="guardian_bulding">
                                <a-input v-model:value="guardian.buiding" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="4">
                            <a-form-item label="與監護人同住" name="guardian_staywith">
                                <a-input v-model:value="guardian.staywith" />
                            </a-form-item>
                            <a-form-item label="年齡" name="guardian_age">
                                <a-input v-model:value="guardian.age" />
                            </a-form-item>
                            <a-form-item label="居住地區" name="guardian_zone">
                                <a-input v-model:value="guardian.zone" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-typography-title :level="5">父母</a-typography-title>
                    <a-row :gutter="12">
                        <a-col span="4">
                            <div class="ant-col ant-col-24">關係:</div>
                            <div class="ant-col ant-col-24 pt-2">{{ parents[0].relation }}:</div>
                            <div class="ant-col ant-col-24 pt-2">{{ parents[1].relation }}:</div>
                        </a-col>
                        <a-col span="4">
                            姓名
                            <a-input v-model:value="parents[0].name" />
                            <a-input v-model:value="parents[1].name" />
                        </a-col>
                        <a-col span="4">
                            年齡
                            <a-input v-model:value="parents[0].age" />
                            <a-input v-model:value="parents[1].age" />
                        </a-col>
                        <a-col span="4">
                            業業
                            <a-input v-model:value="parents[0].occupation" />
                            <a-input v-model:value="parents[1].occupation" />
                        </a-col>
                        <a-col span="4">
                            通訊處
                            <a-input v-model:value="parents[0].contact" />
                            <a-input v-model:value="parents[1].contact" />
                        </a-col>
                        <a-col span="4">
                            聯絡電話
                            <a-input v-model:value="parents[0].mobile" />
                            <a-input v-model:value="parents[1].mobile" />
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-button class="float-right" @click="onClickAddRelative">Add</a-button>
                    <a-typography-title :level="5">家庭其他成員</a-typography-title>
                    <a-row :gutter="12" v-for="relative in relatives">
                        <a-col span="4">
                            <div class="ant-col ant-col-24">關係:</div>
                            <a-input v-model:value="relative.relation" />
                        </a-col>
                        <a-col span="4">
                            姓名
                            <a-input v-model:value="relative.name" />
                        </a-col>
                        <a-col span="4">
                            年齡
                            <a-input v-model:value="relative.age" />
                        </a-col>
                        <a-col span="4">
                            業業
                            <a-input v-model:value="relative.occupation" />
                        </a-col>
                        <a-col span="4">
                            通訊處
                            <a-input v-model:value="relative.contact" />
                        </a-col>
                        <a-col span="4">
                            聯絡電話
                            <a-input v-model:value="relative.mobile" />
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-typography-title :level="5">健康情況</a-typography-title>
                    <p>可患有慢性或穩性之疾病或身體機能有否特殊情況？如有，謮寫明：</p>
                    <a-form-item label="可患有" name="medical.chronic" :label-col="{ span: 4 }">
                        <a-radio-group v-model:value="medical.special" button-style="solid">
                            <a-radio-button value="Y">有</a-radio-button>
                            <a-radio-button value="N">沒有</a-radio-button>
                        </a-radio-group>
                    </a-form-item>
                    <a-form-item label="慢性疾患" name="medical.chronic" :label-col="{ span: 4 }">
                        <a-input v-model:value="medical.chronic" />
                    </a-form-item>
                    <a-form-item label="遺傳性疾病" name="medical.hereditary" :label-col="{ span: 4 }">
                        <a-input v-model:value="medical.hereditary" />
                    </a-form-item>
                    <a-form-item label="（食物及藥物）過敏症" name="medical.allergic" :label-col="{ span: 4 }">
                        <a-input v-model:value="medical.allergic" />
                    </a-form-item>
                    <a-form-item label="轉送醫院" name="medical.hospital" :label-col="{ span: 4 }">
                        <a-input v-model:value="registration.hospital" />
                    </a-form-item>

                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-form-item label="備註" name="registration" :label-col="{ span: 4 }">
                        <a-textarea v-model:value="registration.remark" :rows="5" />
                    </a-form-item>
                    <a-form-item label="更新日期" name="registration.date" :label-col="{ span: 4 }">
                        <a-date-picker v-model:value="registration.date" :format="dateFormat"
                            :valueFormat="dateFormat" />
                    </a-form-item>

                    <a-form-item :wrapper-col="{ offset: 8, span: 16 }">
                        <a-button type="primary" html-type="submit">Submit</a-button>
                    </a-form-item>
                </a-form>
            </div>
        </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['years', 'registration'],
    data() {
        return {
            rules: {
                student_name_zh: { required: true },
                student_gender: { required: true },
                student_dob: { required: true },
                student_id_type: { required: true },
                student_id_num: { required: true },
                student_id_type_other: { required: true },
                student_issue_place_other: { required: true },  
            },
            student: {

            },
            medical: {
                special: null,

            },
            parents: [
                { relation: '父親', name: null, occupation: null, contact: null, mobile: null },
                { relation: '母親', name: null, occupation: null, contact: null, mobile: null },
            ],
            guardian: { relation: '監護人', name: null, occupation: null, contact: null, mobile: null },
            relatives: [
                {
                    relation: null,
                    name: null,
                    occupation: null,
                    contact: null,
                    mobile: null
                }
            ],
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
        }
    },
    methods: {
        onFinish() {
            console.log(this.registration)
        },
        onClickAddRelative(){
            this.relatives.push(
                {
                    relation: null,
                    name: null,
                    occupation: null,
                    contact: null,
                    mobile: null
                }
            )

        }
    }
}
</script>
