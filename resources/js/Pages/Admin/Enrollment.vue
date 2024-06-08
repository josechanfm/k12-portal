<template>
    <AdminLayout title="學生註冊表">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Enrollment
            </h2>
        </template>
        <p>{{ student.name_zh }}</p>
        <p>{{ student.name_fn }}</p>
        <p>{{ student.gender }}</p>
        <p>{{ student.dob }}</p>
        <p>{{ candidate.name_zh }}</p>
        <p>{{ candidate.name_fn }}</p>
        <p>{{ candidate.name_gender }}</p>
        <p>{{ candidate.name_dob }}</p>
        <p>{{ candidate.start_grade }}</p>
        <p>{{ candidate.start_klass }}</p>
        {{ candidate }}
        <a-form :model="enroll" :rules="rules" layout="vertical">
            <a-form-item label="學年" name="year_id">
                <a-select v-model:value="enroll.year_id" :options="years" :fieldNames="{value:'id',label:'code'}" @change="onChangeYear"/>
            </a-form-item>
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
    props: ['years','year','grades','enrollment','student','candidate'],
    data() {
        return {
            selectedYear:{},
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
            this.selectedYear=this.years.find(y=>y.id==this.enroll.year_id)
            this.grades=this.selectedYear.grades_klasses
            this.selectedGrade=this.grades[0]
            this.klasses=this.selectedGrade.klasses
            this.selectedKlass=this.klasses[0]
        },
        onChangeYear(){
            this.selectedYear=this.years.find(y=>y.id==this.enroll.year_id)
            this.grades=this.selectedYear.grades_klasses??null
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

