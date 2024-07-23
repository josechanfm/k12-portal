<template>
    <AdminLayout title="學生註冊表">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Student Registration
            </h2>
        </template>
        Current Year:{{ years.find(y => y.current_term == 1).code }}
        <ul>
            <li v-for="year in years">{{ year.code }}</li>
        </ul>
        <a-button @click="clickSampleData">Sample Data</a-button>
        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg p-5">
                <a-typography-title :level="3" class="text-center">學生註冊表</a-typography-title>
                <a-divider style="height: 2px; background-color: #7cb305" />
                <a-form ref="formRef" :label-col="{ span: 8 }" :model="student" :rules="rules" @finish="onFinish">
                    <a-row>
                        <a-col :span="8">
                            <a-form-item label="姓名(中文)" name="name_zh">
                                <a-input v-model:value="student.name_zh" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="16">
                            <a-form-item label="姓名(外文)" :label-col="{ span: 4 }">
                                <a-input v-model:value="student.name_fn" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-row>
                        <a-col :span="8">
                            <a-form-item label="性別" name="gender">
                                <a-radio-group v-model:value="student.gender" button-style="solid">
                                    <a-radio-button value="M">Male</a-radio-button>
                                    <a-radio-button value="F">Female</a-radio-button>
                                </a-radio-group>
                            </a-form-item>
                            <a-form-item label="出生地點" name="pob">
                                <a-select v-model:value="student.pob" :options="pobOptions" />
                            </a-form-item>
                            <a-form-item label="請指明出生地點" name="pob_other" v-if="student.pob == 'OT'">
                                <a-input v-model:value="student.pob_other" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="出生日期" name="dob">
                                <a-date-picker v-model:value="student.dob" :format="dateFormat" :valueFormat="dateFormat" />
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
                            <a-form-item label="學歷" name="is_new" :label-col="{ span: 4 }">
                                <a-radio-group v-model:value="student.is_new" button-style="solid">
                                    <a-radio-button value="Y">新生</a-radio-button>
                                    <a-radio-button value="N">舊生</a-radio-button>
                                </a-radio-group>
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-row>
                        <a-col span="8">
                                <template v-if="student.is_new == 'Y'">
                                    <a-form-item label="上學期在" name="previour_school">
                                        <a-input v-model:value="student.previour_school" />
                                    </a-form-item>
                                </template>
                                <template v-else>
                                    <a-form-item label="上學期在">
                                        本校
                                    </a-form-item>
                                </template>
                        </a-col>
                        <a-col span="8">
                            <a-form-item label="年級" name="school_year">
                                <a-input v-model:value="student.school_year" />
                            </a-form-item>
                        </a-col>
                        <a-col span="8" v-if="student.is_new == 'N'">
                            <a-form-item label="班別" name="school_klass">
                                <a-input v-model:value="student.school_klass" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-typography-title :level="5">身份證明文件</a-typography-title>
                    <a-row>
                        <a-col :span="8">
                            <a-form-item label="證件類別" name="id_type">
                                <a-select v-model:value="student.id_type" :options="idTypeOptions" />
                            </a-form-item>
                            <a-form-item label="請指明證件類別" name="id_type_other" v-if="student.id_type == 'OT'">
                                <a-input v-model:value="student.id_type_other" />
                            </a-form-item>
                            <template v-if="student.id_type == 'OT'">
                                <a-form-item label="簽發地點" name="issue_place">
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
                                <a-form-item label="本次發出日期" name="id_issue">
                                    <a-date-picker v-model:value="student.id_issue" :format="dateFormat"
                                        :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item label="有效日期" name="id_expired">
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
                            <a-form-item label="教青局學生證號碼">
                                <a-input v-model:value="student.dsedj" />
                            </a-form-item>
                            <a-form-item label="醫療咭號碼">
                                <a-input v-model:value="student.ssm" />
                            </a-form-item>

                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-typography-title :level="5">學生住址及家庭資料</a-typography-title>
                    <a-row>
                        <a-col :span="16">
                            <a-form-item label="街道名稱" :label-col="{ span: 4 }">
                                <a-input v-model:value="address.street_name" />
                            </a-form-item>
                            <a-form-item label="門牌，大廈，樓座" :label-col="{ span: 4 }">
                                <a-input v-model:value="address.building" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="居住地區" name="student_resident_zone">
                                <a-select v-model:value="address.zone" :options="zoneOptions"/>
                            </a-form-item>
                            <a-form-item label="住宅電話" name="student_resident_phone">
                                <a-input v-model:value="address.phone" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-row>
                        <a-col :span="16">
                            <a-form-item label="夜宿地及地址" :label-col="{ span: 4 }">
                                <a-input v-model:value="address.overnight" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="晚間住宿地區">
                                <a-input v-model:value="address.overnight_zone" />
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
                                <a-input v-model:value="detail.sibling" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="家庭狀況" name="student_family_status">
                                <a-input v-model:value="detail.family_status" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-typography-title :level="5">監護人</a-typography-title>
                    <a-row>
                        <a-col :span="10">
                            <a-form-item label="監護人姓名">
                                <a-input v-model:value="guardian.name_zh" />
                            </a-form-item>
                            <a-form-item label="聯絡電話">
                                <a-input v-model:value="guardian.mobile" />
                            </a-form-item>

                            <a-form-item label="街道名稱">
                                <a-input v-model:value="guardian.street_name" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="10">
                            <a-form-item label="興監護人關係:">
                                <a-input v-model:value="guardian.kinship" />
                            </a-form-item>
                            <a-form-item label="職業" name="guardian_occupation">
                                <a-input v-model:value="guardian.occupation" />
                            </a-form-item>
                            <a-form-item label="門牌，大廈，樓座" name="guardian_bulding">
                                <a-input v-model:value="guardian.building" />
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
                                <a-select v-model:value="guardian.zone" :options="zoneOptions"/>
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-typography-title :level="5">父母</a-typography-title>
                    <a-row :gutter="12">
                        <a-col span="4">
                            <div class="ant-col ant-col-24">關係:</div>
                            <div class="ant-col ant-col-24 pt-2">{{ parents[0].kinship }}:</div>
                            <div class="ant-col ant-col-24 pt-2">{{ parents[1].kinship }}:</div>
                        </a-col>
                        <a-col span="4">
                            姓名
                            <a-input v-model:value="parents[0].name_zh" />
                            <a-input v-model:value="parents[1].name_zh" />
                        </a-col>
                        <a-col span="4">
                            年齡
                            <a-input v-model:value="parents[0].age" />
                            <a-input v-model:value="parents[1].age" />
                        </a-col>
                        <a-col span="4">
                            職業
                            <a-input v-model:value="parents[0].occupation" />
                            <a-input v-model:value="parents[1].occupation" />
                        </a-col>
                        <a-col span="4">
                            工作機構
                            <a-input v-model:value="parents[0].organization" />
                            <a-input v-model:value="parents[1].organization" />
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
                            <a-input v-model:value="relative.name_zh" />
                        </a-col>
                        <a-col span="4">
                            年齡
                            <a-input v-model:value="relative.age" />
                        </a-col>
                        <a-col span="4">
                            職業
                            <a-input v-model:value="relative.occupation" />
                        </a-col>
                        <a-col span="4">
                            工作機構
                            <a-input v-model:value="relative.organization" />
                        </a-col>
                        <a-col span="4">
                            聯絡電話
                            <a-input v-model:value="relative.mobile" />
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-typography-title :level="5">健康情況</a-typography-title>
                    <p>可患有慢性或穩性之疾病或身體機能有否特殊情況？如有，謮寫明：</p>
                    <a-form-item label="可患有" :label-col="{ span: 4 }">
                        <a-radio-group v-model:value="health.special" button-style="solid">
                            <a-radio-button value="Y">有</a-radio-button>
                            <a-radio-button value="N">沒有</a-radio-button>
                        </a-radio-group>
                    </a-form-item>
                    <a-form-item label="慢性疾患" :label-col="{ span: 4 }">
                        <a-input v-model:value="health.chronic" />
                    </a-form-item>
                    <a-form-item label="遺傳性疾病" :label-col="{ span: 4 }">
                        <a-input v-model:value="health.hereditary" />
                    </a-form-item>
                    <a-form-item label="（食物及藥物）過敏症" :label-col="{ span: 4 }">
                        <a-input v-model:value="health.allergy" />
                    </a-form-item>
                    <a-form-item label="轉送醫院" :label-col="{ span: 4 }">
                        <a-input v-model:value="health.hospital" />
                    </a-form-item>
                    <a-form-item label="健康備註"  :label-col="{ span: 4 }">
                        <a-textarea v-model:value="health.remark" :rows="5" />
                    </a-form-item>

                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-form-item label="學生備註"  :label-col="{ span: 4 }">
                        <a-textarea v-model:value="student.remark" :rows="5" />
                    </a-form-item>
                    <a-form-item label="更新日期" name="registration_date" :label-col="{ span: 4 }">
                        <a-date-picker v-model:value="student.registration_date" :format="dateFormat"
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
import { message } from 'ant-design-vue';

export default {
    components: {
        AdminLayout
    },
    props: ['years','student'],
    data() {
        return {
            detail:{},
            address:{},
            parents: [
                { relation: 'MOTHER', kinship:'母親', name_zh: null, occupation: null, organization: null, mobile: null },
                { relation: 'FATHER', kinship:'父親', name_zh: null, occupation: null, organization: null, mobile: null },
            ],
            guardian: { relation: 'GUARDIAN', kinship:'Guardian', name_zh: null, occupation: null, organization: null, mobile: null },
            relatives: [
                {
                    relation: null,
                    kinship:null,
                    name_zh: null,
                    occupation: null,
                    organization: null,
                    mobile: null
                }
            ],
            health: {
                special: null,
            },
            dateFormat: 'YYYY-MM-DD',
            rules: {
                name_zh: { required: true },
                gender: { required: true },
                dob: { required: true },
                is_new: { required: true },
                previour_school:{required: true},
                school_year:{required: true},
                school_klass:{required: true},                
                id_type: { required: true },
                id_num: { required: true },
                id_type_other: { required: true },
                pob: { required: true },  
                issue_place: { required: true },  
                issue_place_other: { required: true },  
                nationality: { required: true },  
                registration_date: { required: true },  
            },

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
            zoneOptions: [
                { value: 'MO', label: '澳門' },
                { value: 'TP', label: '氹仔' },
                { value: 'CL', label: '路環' },
                { value: 'ML', label: '內地' },
                { value: 'HK', label: '香港' },
                { value: 'OT', label: '其他' },
            ],

        }
    },
    methods: {
        clickSampleData(){
            this.student.name_zh='陳大文'
            this.student.name_fn='Chan Tai Man'
            this.student.gender='M'
            this.student.dob='2016-04-04'
            this.student.pob='MO'
            this.student.nationality='Chinese'
            this.student.native='ZhuHai'
            this.student.religion='None'
            this.student.is_new='Y'
            this.student.previour_school='ESLC'
            this.student.school_year='F1'
            this.student.school_klass='S1A'
            this.student.id_type='OT'
            this.student.id_type_other='Portugal'
            this.student.issue_place='OT'
            this.student.issue_place_other='Portugal'
            this.student.id_num='12345678'
            this.student.id_issue='2016-05-01'
            this.student.id_expired='2026-05-01'
            this.student.hrc_issue='2020-01-01'
            this.student.hrc_expired='2030-01-01'
            this.student.hrc_num='M123456789'
            this.student.dsedj='987654321'
            this.student.ssm='1234567890'
            this.student.emergency_mobile='61234567'
            this.student.remark='Studnet remark'
            this.address.street_name='Rua de ....'
            this.address.building='Edif. ABC, block 2, 9H'
            this.address.zone='MO'
            this.address.phone='28123456'
            this.detail.sibling='3'
            this.detail.family_status='Normal'
            this.guardian.relation='GURADIAN'
            this.guardian.kinship='Father'
            this.guardian.name_zh='Guardian name'
            this.guardian.occupation='jbo guardian'
            this.guardian.organization='org guardian'
            this.guardian.age='50'
            this.guardian.mobile='62345678'
            this.guardian.zone='ML'
            this.guardian.street_name='Rua Dois ....'
            this.guardian.building='Edif. AAA ..'
            this.parents[0].relation='MOHTER'
            this.parents[0].kinship='Mother'
            this.parents[0].name_zh='Mother Name'
            this.parents[0].occupation='Job Mother'
            this.parents[0].organization='Org Mother'
            this.parents[0].age='49'
            this.parents[0].mobile='63456789'
            // this.parents[0].street_name='Rua Tres ...'
            // this.parents[0].bulding='Edif. BBB ...'
            this.parents[1].relation='FATHER'
            this.parents[1].kinship='Father'
            this.parents[1].name_zh='Father Name'
            this.parents[1].occupation='Job Father'
            this.parents[1].organization='Org Father'
            this.parents[1].age='51'
            this.parents[1].mobile='64456789'
            // this.parents[1].street_name='Rua Quatro ...'
            // this.parents[1].bulding='Edif. ccc ...'
            this.relatives[0].relation='relatives'
            this.relatives[0].kinship='Uncle'
            this.relatives[0].name_zh='Uncle Name'
            this.relatives[0].occupation='job Uncle'
            this.relatives[0].organization='org Uncle'
            this.relatives[0].age='57'
            this.relatives[0].mobile='66223344'
            this.onClickAddRelative()
            this.relatives[1].relation='relatives'
            this.relatives[1].kinship='Antie'
            this.relatives[1].name_zh='Antie Name'
            this.relatives[1].occupation='job Antie'
            this.relatives[1].organization='org Antie'
            this.relatives[1].age='56'
            this.relatives[1].mobile='66334455'
            this.health.speical='Y'
            this.health.chronic='Chonic'
            this.health.hereditary='Hereditary'
            this.health.allergy='Allergy'
            this.health.hospital='Hospital'
            this.health.remark='Health Remark'

            this.student.registration_date='2024-06-01'
        },
        onFinish() {
            const registration={
                student:this.student,
                detail:this.detail,
                address:this.address,
                guardian:this.guardian,
                parents:this.parents,
                relatives:this.relatives,
                health:this.health,


            };
            console.log(registration);
            this.$inertia.post(route('admin.registrations.store'),registration,{
                onSuccess:(page)=>{
                    console.log(page);
                },
                onError:(error)=>{
                    console.log(error);
                    message.error(error.message);
                }
            });

        },
        onClickAddRelative(){
            this.relatives.push(
                {
                    relation: null,
                    kinship:null,
                    name_zh: null,
                    age:null,
                    occupation: null,
                    organization: null,
                    mobile: null
                }
            )

        }
    }
}
</script>
