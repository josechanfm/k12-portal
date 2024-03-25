<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                課外活動
            </h2>
        </template>
        {{toStudents}}
        <div class="w-full mt-5 p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
            <a-radio-group v-model:value="selectedGradeId" button-style="solid" @change="onChangeGrade">
                <template v-for="grade in grades">
                    <a-radio-button :value="grade.id">{{ grade.tag }}</a-radio-button>
                </template>
            </a-radio-group>
            <p>&nbsp;</p>
            <a-radio-group v-model:value="selectedKlassId" button-style="solid" @change="onChangeKlass">
                <template v-for="klass in klasses">
                    <a-radio-button :value="klass.id" v-if="klass.grade_id==selectedGradeId">{{ klass.tag }}</a-radio-button>
                </template>
            </a-radio-group>
            <p>&nbsp;</p>
            <a-radio-group v-model:value="selectedCertificateType" button-style="solid" @change="onChangeCertificate">
                <template v-for="certificate in certificateTemplates">
                    <a-radio-button :value="certificate.value" >{{ certificate.label }}</a-radio-button>
                </template>
            </a-radio-group>
            <p>&nbsp;</p>
            <a-button @click="saveSelecedStudents">Save</a-button>
        </div>
        <div class="w-full mt-5 p-6 bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
            <a-row>
                <a-col :span="8">
                    <table>
                        <tr v-for="student in fromStudents">
                            <td>{{ student.name_zh }}</td>
                            <td>
                                <a-button @click="selectStudent(student)">Add</a-button>
                            </td>
                        </tr>
                    </table>
                </a-col>
                <a-col :span="14">
                    <div>
                        <a-button @click="onChangeTerm(0)">全年</a-button>
                        <a-button v-for="term in terms" @click="onChangeTerm(term.value)">{{ term.label }}</a-button>
                        <div class="float-right ">
                            <a-switch v-model:checked="showAllStudents" /><span class="pl-3">全部顯示</span>
                        </div>
                        
                    </div>
                    <div class="ant-table">
                        <div class="ant-table-container">
                            <div class="ant-table-content">
                                <table style="table-layout: auto;" id="dataTable" ref="dataTable">
                                    <thead class="ant-table-thead">
                                        <tr>
                                            <th>Term</th>
                                            <th>Name</th>
                                            <th>Cert Date</th>
                                            <th>Cert Number</th>
                                            <th>Extra</th>
                                        </tr>
                                    </thead>
                                    <tbody class="ant-table-tbody">
                                        <template  v-for="student in toStudents">
                                            <tr v-if="student.term_id==selectedTermId || showAllStudents==true">
                                                <td>{{ termLabel(student.term_id) }}</td>
                                                <td>{{ student.name_display }}</td>
                                                <td>
                                                    <a-date-picker v-model:value="student.issue_date" :format="dateFormat" :valueFormat="dateFormat"/>
                                                </td>
                                                <td>
                                                    <a-input v-model:value="student.issue_number"/>
                                                </td>
                                                <td>
                                                    <a-input v-model:value="student.extra"/>
                                                    {{student}}
                                                </td>
                                            </tr>
                                        </template>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </a-col>
            </a-row>
        </div>
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
    props: ['years','terms', 'grades', 'klasses','certificateTemplates'],
    data() {
        return {
            dateFormat: 'YYYY-MM-DD',
            selectedYearId:0,
            selectedTermId:0,
            selectedGradeId:4,
            selectedKlassId:0,
            selectedCertificateType:'C1',
            selectedGrade: {},
            selectedKlass:{},
            //selectdCertificate:{},
            showAllStudents:true,
            students:[],
            fromStudents:{},
            toStudents:{},
            columns: [
                {
                    title: '學期',
                    dataIndex: 'name_zh',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ],

        }
    },
    created() {
    },
    mounted(){
        this.currentYear()
    },
    methods: {
        onChangeCertificate(){
            console.log(this.selectedCertificateType)
            this.getCertificateByConditions()
        },
        onChangeGrade(){
            this.selectedKlassId=this.klasses.find(klass=>klass.grade_id==this.selectedGradeId).id
            this.getCertificateByConditions()
        },
        onChangeKlass(){
            console.log(this.selectedKlassId)
            this.getCertificateByConditions()
        },
        onChangeTerm(termId){
            this.selectedTermId=termId
            this.showAllStudents=false
        },
        termLabel(termId){
            var tmp=this.terms.find(term=>term.value==termId)
            if(tmp){
                return tmp.label
            }else{
                return '全年'
            }
        },
        currentYear(){
            this.selectedYearId=this.years.find(year=>year.active==true).id
            this.selectedGrade=this.grades.find(grade=>grade.grade_year==4)
            this.selecdtedGradeId=this.grades.find(grade=>grade.grade_year==4).id
            this.selectedKlassId=this.klasses.find(klass=>klass.grade_id==this.selectedGradeId).id
            this.selectedCertificateType=this.certificateTemplates[0].value
            // this.selectdCertificate=this.certificateTemplates[0]
            var klass=this.klasses.filter(k=>k.grade_id==this.selectedGrade.id)[0];
            this.getStudentsByKlass(klass);
            this.getCertificateByConditions()    
        },
        getCertificateByConditions(){
            this.selectedTermId=0
            var data={
                year_id:0,
                klass_id:this.selectedKlassId,
                certificate_type:this.selectedCertificateType
            }
            axios.get(route('director.certificate.getByConditions'),{params:data
            }).then(res=>{
                this.toStudents={}
                res.data.forEach(std=>{
                    std.student.issue_date=std.issue_date
                    std.student.issue_number=std.issue_number
                    std.student.extra=std.extra
                    std.student.name_display=std.name_display
                    std.student.term_id=std.term_id
                    this.toStudents[std.id]=std.student
                })
            }).catch(err=> {
                console.log(err);
            })
        },
        getStudentsByKlass(klass) {
            this.selectedKlass=klass
            axios.get(route('director.students.getByKlassId', klass.id), {
                klass: klass.id
            }).then(res => {
                this.fromStudents={}
                res.data.forEach(std=>{
                    this.fromStudents[std.id]=std
                })
            }).catch(err=> {
                console.log(err);
            });
        },
        getStudentByNames(items) {
            axios.post(route('director.students.getByNames'), items).then(res => {
                this.fromStudents={}
                res.data.forEach(std=>{
                    this.fromStudents[std.id]=std
                })
            })
        },
        selectStudent(student){
            
            this.toStudents[student.id]={...student}
            this.toStudents[student.id]['name_display']=student.name_zh
            this.toStudents[student.id]['term_id']=this.selectedTermId
        },
        saveSelecedStudents(){
            console.log(this.toStudents)
            var data=[]
            Object.entries(this.toStudents).forEach(([key,std])=>{
                console.log(std)
                data.push({
                    certificate_type:this.selectedCertificateType,
                    certificate_meta:JSON.stringify(this.certificateTemplates.find(cert=>cert.value==this.selectedCertificateType)),
                    issue_date:std.issue_date,
                    issue_number:std.issue_number,
                    year_id:this.selectedGrade.year_id,
                    term_id:this.selectedTermId,
                    student_id:std.id,
                    student_number:std.klass.pivot.student_number,
                    klass_id:std.klass.id,
                    klass_tag:std.klass.tag,
                    name_display:std.name_zh,
                    extra:std.extra
                })
            })
            console.log(data)
            this.$inertia.put(route('director.certificates.update', this.selectedCertificateType), data, {
                onSuccess: (page) => {
                    console.log(page);
                },
                onError: (error) => {
                    console.log(error);
                }
            })
        }
    },
}
</script>
