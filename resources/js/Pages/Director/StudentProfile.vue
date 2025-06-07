<template>
    <AdminLayout title="個人信息" :breadcrumb="breadcrumb">
        <div class="flex flex-wrap bg-white rounded-lg p-4 ">
            <h2 class="font-semibold text-xl text-gray-800 leading-tight flex-1">
                <div class="flex flex-wrap bg-white rounded-lg p-1 items-center gap-2">
                    <div class="bg-gray-300/60 w-[3cm] h-[4cm] rounded-lg flex items-center justify-center">
                        <div v-if="student.avatars[0] && student.avatars[0].image" >
                            <a-image  width="2.4cm" height="3.2cm"  v-if="student.avatars && student.avatars[0]"
                                :src="student.avatars[0].image.original_url" />
                        </div>
                        <div v-else>
                            <a-avatar shape="square" :size="128">
                                <template #icon><UserOutlined /></template>
                            </a-avatar>                            
                        </div>
                    </div>
                    <div class="flex gap-1 flex-col">
                        <div class="profile-row">   
                            <div class="profile-label ">中文姓名：</div>
                            <div>{{ student.name_zh }}</div>
                        </div>
                        <div class="profile-row"> 
                            <div  class="profile-label">外文姓名：</div>
                            <div >{{ student.name_fn }}</div>
                        </div>
                        <div class="profile-row">
                            <div  class="profile-label">性別：</div>
                            <div >{{ student.gender }}</div>
                        </div>
                        <div class="profile-row"> 
                            <div class="profile-label">出生日期(年齡)：</div>
                            <div>{{ student.dob }} ({{ calculateAge(student.dob) }})</div>
                        </div>
                        <div class="profile-row"> 
                            <div class="profile-label">歷年年級：</div>
                            <div class='flex gap-1'>
                                <a-tag class="font-black text-lg bg-green-200/90 text-green-700" v-for="klass in  student.klasses" :key="klass.school_year">{{ klass.school_year }}:{{ klass.tag }}</a-tag>
                            </div>
                        </div>
                    </div>
                  
                </div>
            </h2>
            <div >
                <a-switch class="font-semibold" v-model:checked="isEdit" @change="onChangeEditMode" checkedChildren="編輯中" unCheckedChildren="鎖定中"/>
            </div>
        </div>
        
        <div :class="isEdit ? 'formEditOn' : 'formEditOff'">
            <div class='flex items-center p-2 bg-gray-200'>
                <div class="font-black bg-gray-400/60 text-slate-500 p-2 px-2 rounded-l-3xl text-lg">顯示類型</div>  
                <a-checkbox-group v-model:value="activeKeys" class="flex gap-1 bg-gray-300/30  p-1 rounded-r-2xl">
                    <div  :key="ackey" v-for="ackey in Object.keys( header_zh )">
                        <a-checkbox :value="ackey" 
                         class="checkbox-btn ">{{ header_zh[ackey]??ackey }}</a-checkbox>
                    </div>
                </a-checkbox-group>
            </div>
            <a-form ref="formRef" name="advanced_search" class="ant-advanced-search-form" :model="student"
                 :labelWrap='true'	  label-align="right"
                :rules="rules" @finish="onFinish" @finishFailed="onFinishFailed">
                <div  class="flex flex-col gap-2 bg-white p-2">
                    <transition-group name="list">
                    <div class="ant-form-bg" key="avatar" header=""  v-if='activeKeys.includes("avatar")  ||  activeKeys.includes("all")' >
                        <div class="form-header">頭像照片</div>
                        <div  class="flex flex-col gap-1 rounded-2xl p-2">
                            <div  v-for="avatar,idx in student.avatars" :key="idx">
                                <UploadAvatars :avatar="avatar"></UploadAvatars>
                                <!-- <div v-if="avatar.image">
                                    
                                </div>
                                <div v-else>
                                    <a-avatar shape="square" :size="92">
                                    </a-avatar>                            
                                </div> -->
                            </div>
                        </div>
                    </div>
                    <div class="ant-form-bg"  v-if='activeKeys.includes("basic")  ||  activeKeys.includes("all")' >
                        <div class="form-header">基本信息</div>
                        <div class="flex flex-col gap-1 rounded-2xl p-2">
                            <div class="flex flex-wrap gap-1">
                                <a-form-item class="student-form-layout" label="姓名" name="name_zh"   >
                                    <a-textarea autosize  v-model:value="student.name_zh" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="校內編號"   >
                                    <a-textarea autosize  v-model:value="student.sid" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="教青局編號"   >
                                    <a-textarea autosize  v-model:value="student.dsedj_num" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="衛生局金咭編號"   >
                                    <a-textarea autosize  v-model:value="student.ssm_num" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="學生手提電話"   >
                                    <a-textarea autosize  v-model:value="student.phone" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="外文姓名"     >
                                    <a-textarea autosize  v-model:value="student.name_fn" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="成績表顯示英文名稱"     >
                                    <a-textarea autosize  v-model:value="student.name_display" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="過往就請學校"     >
                                    <a-textarea autosize  v-model:value="student.previour_school" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="過往就年級"    >
                                    <a-textarea autosize  v-model:value="student.previour_grade" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="班別號"    >
                                    <a-textarea autosize  v-model:value="student.start_klass" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="接收短訊用手提電話"  >
                                    <a-textarea autosize  v-model:value="student.phone_sms" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="性別" >
                                    <a-textarea autosize  v-model:value="student.gender" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="出生日期"   >
                                    <a-date-picker v-model:value="student.dob" :format="dateFormat" :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="入學日期"   >
                                    <a-date-picker v-model:value="student.entry_date" :format="dateFormat" :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="監護人"   >
                                    display guardian
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="宗教"   >
                                    <a-textarea autosize  v-model:value="student.religion" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="住宅電話"   >
                                    <a-textarea autosize  v-model:value="student.phone_home" />
                                </a-form-item>
                            </div>
                        </div>
                    </div>
                    <div class="ant-form-bg" v-if='activeKeys.includes("id_card") ||  activeKeys.includes("all")' >
                        <div  class="form-header">證件信息</div>
                        <div class="flex flex-col ">
                            <div class="flex flex-wrap gap-1">
                                <a-form-item class="student-form-layout" label="證件類別" name="id_type">
                                    <a-select placeholder="請選擇證件類別" v-model:value="student.id_type" :options="idTypeOptions" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="請指明證件類別" name="id_type_other" v-if="student.id_type == 'OT'">
                                    <a-textarea autosize  v-model:value="student.id_type_other" />
                                </a-form-item>
                                <template v-if="student.id_type == 'OT'">
                                    <a-form-item class="student-form-layout" label="簽發地點">
                                        <a-select v-model:value="student.issue_place" :options="issuePlaceOptions" />
                                    </a-form-item>
                                    <a-form-item class="student-form-layout" label="請指明簽發地點" name="issue_place_other"
                                        v-if="student.issue_place == 'OT'">
                                        <a-textarea autosize  v-model:value="student.issue_place_other" />
                                    </a-form-item>
                                </template>
                                <a-form-item class="student-form-layout" label="證件編號" name="id_num">
                                    <a-textarea autosize  v-model:value="student.id_num" />
                                </a-form-item>
                                <template v-if="student.id_type == 'CT'">
                                    <a-form-item class="student-form-layout" label="逗留簽發日期">
                                        <a-date-picker v-model:value="student.stay_issue" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                    <a-form-item class="student-form-layout" label="逗留至有效日期">
                                        <a-date-picker v-model:value="student.stay_expired" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                </template>
                                <template v-else>
                                    <a-form-item class="student-form-layout" label="本次發出日期">
                                        <a-date-picker v-model:value="student.id_issue" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                    <a-form-item class="student-form-layout" label="有效日期">
                                        <a-date-picker v-model:value="student.id_expired" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                </template>
                                <a-form-item class="student-form-layout" label="回鄉證編號">
                                    <a-textarea autosize  v-model:value="student.hrc_num" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="回鄉證簽發日期">
                                    <a-date-picker v-model:value="student.hrc_issue" :format="dateFormat"
                                        :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="回鄉證有效日期">
                                    <a-date-picker v-model:value="student.hrc_expired" :format="dateFormat"
                                        :valueFormat="dateFormat" />
                                </a-form-item>
                            </div>
                        </div>
                    </div>

                    <div class="ant-form-bg"  v-if='activeKeys.includes("detail") ||  activeKeys.includes("all")' >
                        <div  class="form-header">補充信息</div>
                        <div  v-if="student.detail" class="flex flex-wrap gap-1">
                            <a-form-item class="student-form-layout"  label="聖名">
                                <a-textarea autosize  v-model:value="student.detail.holy_name" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="領洗日期">
                                <a-date-picker v-model:value="student.detail.baptized" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="初領聖體日期">
                                <a-date-picker v-model:value="student.detail.first_communion" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="有效日期(逗留)">
                                <a-date-picker v-model:value="student.detail.stay_issue" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="兄弟姊妹總數">
                                <a-textarea autosize  v-model:value="student.detail.sibling" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="已工作兄弟姊妹總數">
                                <a-textarea autosize  v-model:value="student.detail.sibling_at_work" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="入校年級(過去就讀)">
                                <a-textarea autosize  v-model:value="student.detail.previour_grade" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="入校日期(過去就讀)">
                                <a-date-picker v-model:value="student.detail.entry_date" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="就讀年級(過去就讀)">
                                <a-textarea autosize  v-model:value="student.detail.entry_klass" />
                            </a-form-item >
                        </div >
                    </div>

                    <div class="ant-form-bg"  v-if='activeKeys.includes("address") ||  activeKeys.includes("all")'>
                        <div  class="form-header">住址信息</div>
                        <div   v-if="student.address"  class="flex flex-wrap gap-1">
                            <a-form-item class="student-form-layout"  label="住址街名"  >
                                <a-textarea autosize  v-model:value="student.address.road" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="門牌大廈">
                                <a-textarea autosize  v-model:value="student.address.building" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="居住地區">
                                <a-textarea autosize  v-model:value="student.address.zone" />
                            </a-form-item >
                        </div >
                    </div>

                    <div class="ant-form-bg" v-if='activeKeys.includes("bank") ||  activeKeys.includes("all")'  >
                        <div  class="form-header">銀行信息</div>
                        <div   class="flex flex-wrap gap-1">
                            <a-form-item class="student-form-layout"  label="銀行">
                                <a-textarea autosize  v-model:value="student.bank.bank_name" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="戶口名稱">
                                <a-textarea autosize  v-model:value="student.bank.account_name" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="銀行帳號">
                                <a-textarea autosize  v-model:value="student.bank.account_number" />
                            </a-form-item >
                        </div >
                    </div>


                    <div class="ant-form-bg" v-if='activeKeys.includes("parent") ||  activeKeys.includes("all")' header="父母信息" >
                        <div  class="form-header">父母信息</div>
                        <div  class="flex flex-wrap gap-1"  v-if="student.father">
                            <a-form-item class="student-form-layout" label="父親姓名">
                                <a-textarea autosize  v-model:value="student.father.name_zh" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="父親工作機構">
                                <a-textarea autosize  v-model:value="student.father.occupation" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="父親職業">
                                <a-textarea autosize  v-model:value="student.father.occupation" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="父親手提電話">
                                <a-textarea autosize  v-model:value="student.father.mobile" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="父親住址"  >
                                <a-textarea autosize  v-model:value="student.father.name_zh" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="母親姓名">
                                <a-textarea autosize  v-model:value="student.mother.name_zh" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="母親工作機構">
                                <a-textarea autosize  v-model:value="student.mother.organization" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="母親職業">
                                <a-textarea autosize  v-model:value="student.mother.occupation" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="母親手提電話">
                                <a-textarea autosize  v-model:value="student.mother.mobile" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="母親住址">
                                <a-textarea autosize  v-model:value="student.mother.name_zh" />
                            </a-form-item>
                        </div >
                    </div>

                    <div class="ant-form-bg"   v-if='activeKeys.includes("guardian") ||  activeKeys.includes("all")'>
                        <div  class="form-header">監護人信息</div>
                        <div class="flex flex-wrap gap-1" v-if="student.guardian">
                            <a-form-item class="student-form-layout"  label="監護人姓名">
                                <a-textarea autosize  v-model:value="student.guardian.name_zh" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人職業">
                                <a-textarea autosize  v-model:value="student.guardian.occupation" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人機構電話">
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人關係">
                                <a-textarea autosize  v-model:value="student.guardian.kinship" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人工作機構"  >
                                <a-textarea autosize  v-model:value="student.guardian.organization" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人電話">
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人居住地區"  >
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人郵政編號">
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人街道名稱"  >
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人門牌,大廈,樓座">
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                        </div >
                    </div>

                    <div class="ant-form-bg" v-if='activeKeys.includes("health") ||  activeKeys.includes("all")' key="" >
                        <div  class="form-header">健康信息</div>
                        <div   class="flex flex-wrap gap-1" v-if="student.health">
                            <a-form-item class="student-form-layout"  label="醫院">
                                <a-textarea autosize  v-model:value="student.health.hospital" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="學生健康情況"  >
                                <a-textarea autosize  v-model:value="student.health.status" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="慢性疾患">
                                <a-textarea autosize  v-model:value="student.health.chronic" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="遺傳性疾病">
                                <a-textarea autosize  v-model:value="student.health.hereditary" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="（食物及藥物）過敏症">
                                <a-textarea autosize  v-model:value="student.health.disease" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="remark"  >
                                <a-textarea autosize  v-model:value="student.health.remark" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="創傷"  >
                                trauma
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="創傷治療"  >
                                trauma treatment
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="過敏"  >
                                <a-textarea autosize  v-model:value="student.health.allergy" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="藥物過敏"  >
                                medician allergy
                            </a-form-item >
                        </div >
                    </div>

                    <div class="ant-form-bg"  v-if='activeKeys.includes("siblings") ||  activeKeys.includes("all")'>
                    <div  class="form-header">本校兄弟姊妹</div>
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
                    </div>
                    </transition-group>

                </div>
               <div class="flex" v-if='isEdit'>
                    <div class="flex-1"></div> 
                    <a-button type="create" @click="onFinish">提交並更改</a-button>
               </div>
            </a-form>
        </div>
        <!-- <a-typography-title :level="3">個人文件檔案</a-typography-title> -->
        <!-- <ol>
            <li v-for="file in student.medias">
                {{file.collection_name }}: <a :href="file.original_url" target="_blank">{{ file.file_name }}</a>
            </li>
        </ol> -->
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link } from '@inertiajs/vue3';
import { UserOutlined } from '@ant-design/icons-vue';
import UploadAvatars from "../../Components/UploadAvatars.vue";


export default {
    components: {
        UploadAvatars,
        AdminLayout, Link,
        UserOutlined
    },
    props: ['student'],
    data() {
        return {
            header_zh:{'all':'全','avatar':'頭像照片','basic':'基本信息','id_card':'證件信息','detail':'補充信息',
                        'address':'住址信息','bank':'銀行信息','parent':'父母信息','guardian':'監護人信息','health':'健康信息','siblings':'本校兄弟姊妹'},
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

            activeKeys: ['all'],
            isEdit: false,
            labelCol: { span: 10 }, 
            wrapperCol: { span: 14 },
        }
    },
    created() {
        this.init()        
    },
    mounted(){
    },  
    watch:{
        activeKeys: {
            handler (newVal, oldVal) {
                if(newVal.includes('all') && oldVal.includes('all')  &&  newVal.length>1){
                    this.activeKeys=this.activeKeys.filter(x=>x!='all')
                }else if(newVal.includes('all') && newVal.length>1){
                    this.activeKeys=["all"]
                }
            }
        }
       
    },
    methods: {
       
        init(){
            if (this.student.address == null) this.student.address = {}
            if (this.student.identity_document == null) this.student.identity_document = {}
            if (this.student.bank == null) this.student.bank = {}
            if (this.student.detail == null) this.student.detail = {}
            if (this.student.health == null) this.student.health = {}
            if(this.student.relatives){
                var mother=this.student.relatives.find(r=>r.relation=='MOTHER')
                var father=this.student.relatives.find(r=>r.relation=='FATHER')
                var guardian=this.student.relatives.find(r=>r.relation=='GUARDIAN')
            }else{
                this.student.relatives=[];
            }
            if(mother){
                this.student.mother=mother
            }else{
                this.student.mother={"relation":'MOTHER'}
                this.student.relatives.push({"relation":'MOTHER'})
            }
            if(father){
                this.student.father=father
            }else{
                this.student.father={"relation":'FATHER'}
                this.student.relatives.push(this.student.father)
            }
            if(guardian){
                this.student.guardian=guardian
            }else{
                this.student.guardian={"relation":'GUARDIAN'}
                this.student.relatives.push(this.student.guardian)
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
                    console.log(page)
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