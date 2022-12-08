<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                升班操作
            </h2>
        </template>
        {{nextYear}}
        <hr>
        {{nextGrades}}
        <p>Abbr: {{year.abbr}}</p>
        <p>Title: {{year.title}}</p>
        <p>Description: {{year.description}}</p>
        <p>Start: {{year.start}}</p>
        <p>End: {{year.end}}</p>
        <p>Active: {{year.active}}</p>
        <p>
            <ul>
                <li v-for="group in year.grade_group">
                   {{group.initial}} : {{group.count}}
                </li>
            </ul>
        </p>
        <p class="text-red-500">To process specific GRADE, provide parameter with &gradeId=&ltgradeId&gt</p>
        <hr>
        <a-tabs v-model:activeKey="activeKey">
            <a-tab-pane key="grade" tab="Grade">
                <h3>Current Year {{year.title}}</h3>
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Level</th>
                            <th class="text-left">Initial</th>
                            <th class="text-left">Tag</th>
                            <th class="text-left">Titile Zh</th>
                            <th class="text-left">Version</th>
                            <th class="text-left">Active</th>
                            <th class="text-left">Class</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(grade, gradeKey) in grades">
                            <td class="text-left">{{grade.level}}</td>
                            <td class="text-left">{{grade.initial}}</td>
                            <td class="text-left">{{grade.tag}}</td>
                            <td class="text-left">{{grade.title_zh}}</td>
                            <td class="text-left">{{grade.version}}</td>
                            <td class="text-left">{{grade.active}}</td>
                            <td class="text-left">
                                <ul>
                                    <li v-for="(klass, klassKey) in grade.klasses">
                                        <span @click="selectGradeKlass(klass.id)">{{klass.id}}-{{grade.tag}}{{klass.letter}}</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </a-tab-pane>
            <a-tab-pane key="students" tab="Students" :disabled="(promotion.students.length==0)">
                <p>Promote: {{promotion.currentGrade.tag}} to {{promotion.nextGrade.tag}}</p>
                <a-button type="primary" @click="confirmPromotion()">確認升班</a-button>
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Number</th>
                            <th class="text-left">Name Zh</th>
                            <th class="text-left">Stream</th>
                            <th class="text-left">State</th>
                            <th class="text-left">Promote Class</th>
                            <th class="text-left">Operation</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="student in promotion.students">
                            <td class="text-left">{{(student.pivot.student_number)}}</td>
                            <td class="text-left">{{(student.name_zh)}}</td>
                            <td class="text-left">{{(student.pivot.stream)}}</td>
                            <td class="text-left">{{(student.pivot.state)}}</td>
                            <td class="text-left">
                                <a-tag v-for="klass in promotion.nextGradeKlasses" :color="klass.id==student.pivot.promote_to?'blue':''" @click="promoteStudent(klass.id, student)">{{klass.letter}}</a-tag>
                                <a-tag @click="(student.pivot.promote_to=-9)">重設</a-tag>
                                <a-tag @click="(student.pivot.promote_to=-1)" :color="student.pivot.promote_to==-1?'blue':''">留班</a-tag>
                            </td>
                            <td class="text-left"><span>ss</span></td>
                        </tr>
                    </tbody>
                </table>
            </a-tab-pane>
            <a-tab-pane key="next_grade" tab="Next Grade">
                <h3>Next year is {{nextYear.title}}</h3>
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Level</th>
                            <th class="text-left">Initial</th>
                            <th class="text-left">Tag</th>
                            <th class="text-left">Titile Zh</th>
                            <th class="text-left">Version</th>
                            <th class="text-left">Active</th>
                            <th class="text-left">Class</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(grade, gradeKey) in nextGrades">
                            <td class="text-left">{{grade.id}}-{{grade.level}}</td>
                            <td class="text-left">{{grade.initial}}</td>
                            <td class="text-left">{{grade.tag}}</td>
                            <td class="text-left">{{grade.title_zh}}</td>
                            <td class="text-left">{{grade.version}}</td>
                            <td class="text-left">{{grade.active}}</td>
                            <td class="text-left">
                                <ul>
                                    <li v-for="(klass, klassKey) in grade.klasses">
                                        <span @click="selectNextGradeKlass(klass.id,'next')">{{(klass.id)}}-{{grade.tag}}{{klass.letter}}</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </a-tab-pane>
            <a-tab-pane key="next_students" tab="Next Students" :disabled="(promotion.nextStudents.length==0)">
                <p>Promote: {{promotion.currentGrade.tag}} to {{promotion.nextGrade.tag}}</p>
                <a-button type="primary" @click="confirmPromotion()">確認升班</a-button>
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Number</th>
                            <th class="text-left">Name Zh</th>
                            <th class="text-left">Stream</th>
                            <th class="text-left">State</th>
                            <th class="text-left">Promote Class</th>
                            <th class="text-left">Operation</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="student in promotion.nextStudents">
                            <td class="text-left">{{(student.pivot.student_number)}}</td>
                            <td class="text-left">{{(student.name_zh)}}</td>
                            <td class="text-left">{{(student.pivot.stream)}}</td>
                            <td class="text-left">{{(student.pivot.state)}}</td>
                            <td class="text-left">
                                <a-tag v-for="klass in promotion.nextGradeKlasses" :color="klass.id==student.pivot.promote_to?'blue':''">{{klass.letter}}</a-tag>
                            </td>
                            <td class="text-left"><span>ss</span></td>
                        </tr>
                    </tbody>
                </table>
            </a-tab-pane>
        </a-tabs>
                
        <p></p>
        <ul>
            <li>所有同班同學 students</li>
            <li>所屬的年級記錄 currentGrade</li>
            <li>所屬的學年記錄 currentYear</li>
            <li>所升的學年記錄 nextYear</li>
            <li>所升的年級記錄 nextGrade</li>
            <li>所升的可選的所有班別 nextGradeKlasses</li>
        </ul>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['year','grades','nextYear','nextGrades'],
    data() {
        return {
            activeKey:"grade",
            promotion:{
                'students':[],
                'nextStudents':[],
                'currentGrade':{},
                'currentYear':{},
                'nextGrade':{},
                'nextYear':{}
            },
            selectedGradeKey:null,
            selectedKlassKey:null,
        }
    },
    methods: {
        //selectGradeKlass(gradeKey,klassKey,tabKey='current'){
        selectGradeKlass(klassId){
            // this.selectedGradeKey=gradeKey;
            // this.selectedKlassKey=klassKey;
            // var klassId=this.grades[this.selectedGradeKey].klasses[this.selectedKlassKey].id;
            axios.get('/promote/getStudents/'+klassId)
                .then(response=>{
                    this.promotion = response.data;
                    this.promotion.nextStudents=[];
                    this.activeKey='students';
                });
        },
        selectNextGradeKlass(klassId){
            console.log('get Next Grade students');
        },
        promoteStudent(klassId, student){
            student.pivot.promote_to=klassId;
        },
        confirmPromotion(){
            var students=this.promotion.students.map((std)=>{
                return {
                    'id':std.pivot.klass_student_id,
                    'promote_to':std.pivot.promote_to
                }
            });
            //students._method = 'PATCH';
            axios.post('promote/updateStudents',{students:students})
                .then(response=>{
                    console.log(response.data);
                })
                .catch(error=>{
                    console.log(error);
                })

            // console.log(students);
            // students.forEach((std)=>{
            //         console.log(std.klass_student_id+" = "+std.promote_to);
            //     }

            // )
            //console.log(this.promotion.students);
        }

    },
}
</script>

