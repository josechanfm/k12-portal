<template>
    <AdminLayout title="學生註冊表">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Enrollment
            </h2>
        </template>
        <div>
            學年:{{year.title}}
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
                </div>
            </a-col>
        </a-row>
        <a-form :model="enroll" :rules="rules" layout="vertical">
            <a-form-item label="級別" name="grade_id">
                <a-select v-model:value="enroll.grade_id" :options="grades" :fieldNames="{value:'id',label:'tag'}" @change="onChangeGrade"/>
            </a-form-item>
            <a-form-item label="班別" name="klass_id">
                <a-select v-model:value="enroll.klass_id" :options="klasses" :fieldNames="{value:'id',label:'tag'}" @change="onChangeKlass"/>
            </a-form-item>

        </a-form>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['year','grades','enrollment','student','candidate'],
    data() {
        return {
            selectedGrade:{},
            selectedKlass:{},
            klasses:[],
            enroll:{
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
        //this.selectedYear=this.years[0]
        this.enroll.year_id=this.year.id
        //this.grades=this.grades.klasses;
        this.selectedGrade=this.grades?this.grades[0]:null
        this.enroll.grade_id=this.selectedGrade?this.selectedGrade.id:null
        this.selectedKlass=this.selectedGrade?this.selectedGrade.klasses[0]:null
        this.enroll.klass_id=this.selectedKlass?this.selectedKlass.id:null
        this.klasses=this.selectedGrade?this.selectedGrade.klasses:null
        if(this.candidate && this.candidate.start_grade){
            
        }
    },
    methods: {
        refresh(){
            //this.selectedYear=this.years.find(y=>y.id==this.enroll.year_id)
            //this.grades=this.selectedYear.grades_klasses
            this.selectedGrade=this.grades[0]
            this.klasses=this.selectedGrade.klasses
            this.selectedKlass=this.klasses[0]
        },
        onChangeYear(){
            //this.selectedYear=this.years.find(y=>y.id==this.enroll.year_id)
            //this.grades=this.selectedYear.grades_klasses??null
            this.selectedGrade=this.grades?this.grades[0]:null
            this.klasses=this.selectedGrade?this.selectedGrade.klasses:null
            this.selectedKlass=this.klasses?this.klasses[0]:null
        },
        onChangeGrade(){
            //this.grades=this.year.grades.filter(g=>g.year_id==this.enroll.year_id)
            this.selectedGrade=this.grades.find(g=>g.id==this.enroll.grade_id)
            this.klasses=this.selectedGrade.klasses
            this.enroll.klass_id=this.klasses[0].id
        },
        onChangeKlass(){
            //this.klasess=this.filter(g=>g.year_id==this.enroll.year_id)
            console.log(this.enroll.klass_id)
        }
    }
}
</script>

