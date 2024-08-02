<template>
    <AdminLayout title="學生註冊表">
        <div>
            <a-typography-title :level="4">入讀本學年:{{currentYear.title}}</a-typography-title> 
            <a-typography-title :level="4">入讀下學年:{{nextYear.title}}</a-typography-title> 
        </div>
        <a-row>
            <a-col :span="12">
                <a-typography-title :level="4">學生</a-typography-title>
                <div>
                    <div>中文姓名:{{ student.name_zh }}</div>
                    <div>外文姓名:{{ student.name_fn }}</div>
                    <div>性別:{{ student.gender }}</div>
                    <div>出生日期:{{ student.dob }}</div>
                </div>
            </a-col>
            <a-col :span="12">
                <a-typography-title :level="4">報名表</a-typography-title>
                <div v-if='candidate'>
                    <div>中文姓名:{{ candidate.name_zh }}</div>
                    <div>外文姓名:{{ candidate.name_fn }}</div>
                    <div>性別:{{ candidate.name_gender }}</div>
                    <div>出生日期:{{ candidate.name_dob }}</div>
                    <div>報讀年級:{{ candidate.start_grade }}</div>
                    <div>報讀班別{{ candidate.start_klass }}</div>
                    <a-button as="link" :href="route('admin.candidates.edit',candidate.id)" target="_blank">報名表</a-button>
                </div>
            </a-col>
        </a-row>
        <a-form :model="enroll" :rules="rules" layout="vertical" @finish="onFinish" @finishFailed="onFinishFailed">
            <a-form-item label="入讀學年" name="year_id">
                <a-radio-group v-model:value="enroll.year_id" button-style="solid">
                    <a-radio-button :value="currentYear.id" @click="refresh(currentYear)">本學年 {{ currentYear.title }}</a-radio-button>
                    <a-radio-button :value="nextYear.id" @click="refresh(nextYear)">下學年 {{ nextYear.title }}</a-radio-button>
                </a-radio-group>
            </a-form-item>
            <a-form-item label="級別" name="grade_id">
                <a-select v-model:value="enroll.grade_id" :options="grades" :fieldNames="{value:'id',label:'tag'}" @change="onChangeGrade"/>
            </a-form-item>
            <a-form-item label="班別" name="klass_id" v-if="enroll.grade_id">
                <a-select v-model:value="enroll.klass_id" :options="grades.find(g=>g.id==enroll.grade_id).klasses" :fieldNames="{value:'id',label:'tag'}"/>
            </a-form-item>
            <a-form-item :wrapper-col="{ offset: 8, span: 16 }">
                <a-button type="primary" html-type="submit">Submit</a-button>
            </a-form-item>
        </a-form>
        <div class="text-red-500">
            若下個學年未創建，此功能再無效！
        </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['currentYear','nextYear','year','student','candidate'],
    data() {
        return {
            selectedGrade:{},
            selectedKlass:{},
            grades:[],
            klasses:[],
            enroll:{
                candidate_id:this.candidate?this.candidate.id:null,
                student_id:this.student.id,
                year_id:null,
                grade_id:null,
                klass_id:null,
            },
            rules:{
                year_id:{required:true},
                grade_id:{required:true},
                klass_id:{required:true},
            }
        }
    },
    created(){
        //根據報名表預設入讀年級及班別，班別預設為第一個班
        this.refresh(this.nextYear)
    },
    methods: {
        refresh(year){
            this.enroll.year_id=year.id
            this.grades=year.grades_klasses
            this.enroll.grade_id=this.grades.find(g=>g.tag==this.candidate.start_grade_tag).id
            this.enroll.klass_id=this.grades.find(g=>g.id==this.enroll.grade_id).klasses[0].id

        },
        onChangeGrade(){
            this.enroll.klass_id=this.grades.find(g=>g.id==this.enroll.grade_id).klasses[0].id
        },
        onFinish(){
            console.log('on finish');
            console.log(this.enroll,this.student);
            this.$inertia.post(route('admin.enrollments.store'),this.enroll, {
                onSuccess: (page) => {
                    console.log('enrolled');
                },
                onError: (error) => {
                    console.log(error);
                }
            });

        },
        onFinishFailed(){
            console.log('on Finish Failed')
        }
    }
}
</script>

