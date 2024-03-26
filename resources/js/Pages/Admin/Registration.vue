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
                <a-form ref="formRef" 
                    :label-col="{ span: 8 }" 
                    :model="registration"
                    @finish="onFinish"
                >
                    <a-row>
                        <a-col :span="8">
                            <a-form-item label="姓名(中文)" name="name_zh">
                                <a-input v-model:value="registration.name_zh" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="16">
                            <a-form-item label="姓名(外文)" name="name_fn" :label-col="{ span: 4 }">
                                <a-input v-model:value="registration.name_fn" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-row>
                        <a-col :span="8">
                            <a-form-item label="性別" name="gender">
                                <a-radio-group v-model:value="registration.gender" button-style="solid">
                                    <a-radio-button value="M">Male</a-radio-button>
                                    <a-radio-button value="F">Female</a-radio-button>
                                </a-radio-group>
                            </a-form-item>
                            <a-form-item label="出生地點" name="pob">
                                <a-select v-model:value="registration.pob" :options="pobOptions" />
                            </a-form-item>
                            <a-form-item label="請指明出生地點" name="pob_other" v-if="registration.pob=='OT'">
                                <a-input v-model:value="registration.pob_other" />
                            </a-form-item>

                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="出生日期" name="dob">
                                <a-date-picker v-model:value="registration.dob" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-form-item>
                            <a-form-item label="國籍" name="nationality">
                                <a-input v-model:value="registration.nationality" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="宗教" name="religion">
                                <a-input v-model:value="registration.religion" />
                            </a-form-item>
                            <a-form-item label="籍貫" name="native">
                                <a-input v-model:value="registration.native" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-typography-title :level="5">身份證明文件</a-typography-title>
                    <a-row>
                        <a-col :span="8">
                            <a-form-item label="證件類別" name="id_type">
                                <a-select v-model:value="registration.idType" :options="idTypeOptions" />
                            </a-form-item>
                            <a-form-item label="請指明證件類別" name="id_type" v-if="registration.idType=='OT'">
                                <a-input v-model:value="registration.idTypeOther"/>
                            </a-form-item>
                            <template v-if="registration.idType=='OT'">
                                <a-form-item label="簽發地點" name="issue_lace">
                                    <a-select v-model:value="registration.issuePlace" :options="issuePlaceOptions" />
                                </a-form-item>
                                <a-form-item label="請指明簽發地點" name="issue_place_other" v-if="registration.issuePlace=='OT'">
                                    <a-input v-model:value="registration.issue_place_other" />
                                </a-form-item>
                            </template>

                            <a-form-item label="證件編號" name="id_num">
                                <a-input v-model:value="registration.id_num" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <template v-if="registration.idType=='CT'">
                                <a-form-item label="逗留簽發日期" name="stay_issue">
                                    <a-date-picker v-model:value="registration.valid_date"  :format="dateFormat" :valueFormat="dateFormat"/>
                                </a-form-item>
                                <a-form-item label="逗留至有效日期" name="stay_expired">
                                    <a-date-picker v-model:value="registration.valid_date"  :format="dateFormat" :valueFormat="dateFormat"/>
                                </a-form-item>
                            </template>
                            <template v-else    >
                                <a-form-item label="本次發出日期" name="issue_date">
                                    <a-date-picker v-model:value="registration.issue_date"  :format="dateFormat" :valueFormat="dateFormat"/>
                                </a-form-item>
                                <a-form-item label="有效日期" name="valid_date">
                                    <a-date-picker v-model:value="registration.valid_date"  :format="dateFormat" :valueFormat="dateFormat"/>
                                </a-form-item>
                            </template>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="回鄉證編號" name="home_return">
                                <a-input v-model:value="registration.home_return" />
                            </a-form-item>
                            <a-form-item label="教青局學生證號碼" name="dsedj_num">
                                <a-input v-model:value="registration.dsedj_num" />
                            </a-form-item>
                            <a-form-item label="醫療咭號碼" name="ssm_num">
                                <a-input v-model:value="registration.ssm_num" />
                            </a-form-item>

                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-row>
                        <a-col :span="16">
                            <a-form-item label="往址" name="home_address" :label-col="{ span: 4 }">
                                <a-input v-model:value="registration.home_address" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="住宅電話" name="home_phone">
                                <a-input v-model:value="registration.home_phone" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-row>
                        <a-col :span="16">
                            <a-form-item label="夜宿地及地址" name="living_address" :label-col="{ span: 4 }">
                                <a-input v-model:value="registration.living_address" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="8">
                            <a-form-item label="父母／監護人手提電話" name="guardian_mobile">
                                <a-input v-model:value="registration.guardian_mobile" />
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
                    <a-row>
                        <a-col :span="16">
                            <a-form-item label="學歷" name="previour_school" :label-col="{ span: 4 }">
                                <a-radio-group v-model:value="registration.new" button-style="solid">
                                    <a-radio-button value="Y">新生</a-radio-button>
                                    <a-radio-button value="N">舊生</a-radio-button>
                                </a-radio-group>
                            </a-form-item>
                        </a-col>
                    </a-row>
                    <a-row>
                        <a-col span="8">
                            <a-form-item label="上學期在" name="previour_school">
                                <template v-if="registration.new == 'Y'">
                                    <a-input v-model:value="registration.previour_school" />
                                </template>
                                <template v-else>
                                    本校
                                </template>
                            </a-form-item>
                        </a-col>
                        <a-col span="8">
                            <a-form-item label="年級" name="school_year">
                                <a-input v-model:value="registration.school_year" />
                            </a-form-item>
                        </a-col>
                        <a-col span="8" v-if="registration.new == 'N'">
                            <a-form-item label="班別" name="school_klass">
                                <a-input v-model:value="registration.school_klass" />
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
                            <a-input v-model:value="registration.father_name" />
                            <a-input v-model:value="registration.mother_name" />
                        </a-col>
                        <a-col span="4">
                            年齡
                            <a-input v-model:value="registration.father_age" />
                            <a-input v-model:value="registration.mother_age" />
                        </a-col>
                        <a-col span="4">
                            業業
                            <a-input v-model:value="registration.father_occupation" />
                            <a-input v-model:value="registration.mother_occupation" />
                        </a-col>
                        <a-col span="4">
                            通訊處
                            <a-input v-model:value="registration.father_contact" />
                            <a-input v-model:value="registration.mother_contact" />
                        </a-col>
                        <a-col span="4">
                            聯絡電話
                            <a-input v-model:value="registration.father_mobile" />
                            <a-input v-model:value="registration.mother_mobile" />
                        </a-col>
                    </a-row>
                    <a-divider style="height: 2px; background-color: #7cb305" />
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
                    <a-typography-title :level="5">監護人</a-typography-title>
                    <a-row :gutter="12">
                        <a-col span="4">
                            <div class="ant-col ant-col-24">關係:</div>
                            <a-input v-model:value="guardian.relation" />
                        </a-col>
                        <a-col span="4">
                            姓名
                            <a-input v-model:value="guardian.name" />
                        </a-col>
                        <a-col span="4">
                            年齡
                            <a-input v-model:value="guardian.age" />
                        </a-col>
                        <a-col span="4">
                            業業
                            <a-input v-model:value="guardian.occupation" />
                        </a-col>
                        <a-col span="4">
                            通訊處
                            <a-input v-model:value="guardian.contact" />
                        </a-col>
                        <a-col span="4">
                            聯絡電話
                            <a-input v-model:value="guardian.mobile" />
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
                    <a-form-item label="填表日期" name="registration.date" :label-col="{ span: 4 }">
                        <a-date-picker v-model:value="registration.date"  :format="dateFormat" :valueFormat="dateFormat"/>
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
            idTypeOptions:[
                {value: 'MP', label:'永久居民身份證'},
                {value: 'MR', label:'居民身分證'},
                {value: 'MT', label:'非永久居民身份證'},
                {value: 'CT', label:'臨時逗留證'},
                {value: 'CN', label:'中國內地身份證'},
                {value: 'OT', label:'其他'}
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
        onFinish(){
            console.log(this.registration)
        }
    }
}
</script>
