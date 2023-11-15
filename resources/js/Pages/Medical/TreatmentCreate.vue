<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Medial Treatment
            </h2>
        </template>
        <a-divider/>
        <a-row>
            <a-col :span="18">
                <a-card>
                    <a-form
                        :model="treatment"
                        layout="vertical"
                        name="Treatment"
                        ref="modalRef"
                        :rules="rules"
                        :validate-messages="validateMessages"
                    >
                        <a-form-item label="Student" name="student">
                            {{ treatment.student_id }}
                        </a-form-item>

                        <a-form-item label="Category" name="category">
                            <a-select v-model:value="treatment.category" :options="medicalTreatments"/>
                        </a-form-item>
                        <a-form-item label="Title" name="title">
                            <a-input v-model:value="treatment.title"/>
                        </a-form-item>
                        <a-form-item label="Title" name="title">
                            <a-textarea v-model:value="treatment.description"/>
                        </a-form-item>
                        <a-button @click="onSubmit" type="primary" class="ml-3">保存</a-button>
                    </a-form>

                    <p>Treatment Records</p>
                    <ol>
                        <li v-for="treat in medicalRecord.treatments">{{ treat }}</li>
                    </ol>
                    <p>General Records</p>
                    <ol>
                        <li v-for="(health, field) in medicalRecord.healthcare">{{field}} : {{ health }}</li>
                    </ol>
                </a-card>
            </a-col>
            <a-col :span="6">
                <a-card>
                    <div class="py-5">
                        <a-radio-group v-model:value="selectedGradeId" button-style="solid">
                            <template v-for="grade in grades">
                                <a-radio-button :value="grade.id">{{ grade.tag }}</a-radio-button>
                            </template>
                        </a-radio-group>
                        <a-divider/>
                        <a-radio-group v-model:value="selectedKlassId" button-style="solid" @change="onChangeKlass">
                            <template v-for="klass in grades.find(g=>g.id==selectedGradeId).klasses">
                                <a-radio-button :value="klass.id">{{ klass.tag }}</a-radio-button>
                            </template>
                        </a-radio-group>
                    </div>
                    <ol>
                        <li v-for="student in students" @click="onSelectStudent(student)">{{ student.pivot.student_number }}:{{ student.name_zh }}</li>
                    </ol>
                </a-card>
            </a-col>
        </a-row>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { affixProps } from 'ant-design-vue/lib/affix';
import dayjs from 'dayjs';

export default {
    components: {
        AdminLayout,
        dayjs,
    },
    props: ['grades','medicalTreatments'],
    data() {
        return {
            dateFormat: 'YYYY-MM-DD',
            treatment:{},
            selectedGradeId:0,
            selectedKlassId:0,
            students:{},
            medicalRecord:{},
            columns: [
                {
                    title: 'Student',
                    dataIndex: 'student_id',
                }, {
                    title: 'klass',
                    dataIndex: 'current_klass',
                }, {
                    title: 'Category',
                    dataIndex: 'category',
                }, {
                    title: '日期',
                    dataIndex: 'date',
                }, {
                    title: 'Title',
                    dataIndex: 'title',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ],
            rules:{
                name_zh:{
                    required:true,
                },
                gender:{
                    required:true,
                },
                mobile:{
                    required:true,
                }
            },
            validateMessages:{
                required: '${label} is required!',
                types: {
                    email: '${label} is not a valid email!',
                    number: '${label} is not a valid number!',
                },
                number: {
                    range: '${label} must be between ${min} and ${max}',
                },
            },

        }
    },
    created() {
        this.selectedGradeId=this.grades.find(g=>g.grade_year==4).id
        this.selectedKlassId=this.grades.find(g=>g.id==this.selectedGradeId).klasses
    },
    mounted(){

    },
    methods: {
        createRecord(){
            
        },
        onSubmit(){

        },
        onChangeKlass(){
            axios.get(route('api.klassStudents',this.selectedKlassId))
                .then(resp=> {
                    this.students=resp.data.students;
                    }
                );
        },
        onSelectStudent(student){
            this.treatment.student_id=student.id
            axios.get(route('api.studentMedicalRecords',student.id))
                .then(resp=> {
                    console.log(resp.data);
                    this.medicalRecord=resp.data
                    }
                );

        },
        changeSelectedKlass(){
            console.log('klass changed');
        }
    },
}
</script>
