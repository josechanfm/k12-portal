<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                升班操作
            </h2>
        </template>
        <p>代　　號: {{year.abbr}}</p>
        <p>名　　稱: {{year.title}}</p>
        <p>備　　注: {{year.description}}</p>
        <p>關始日期: {{year.start}}</p>
        <p>結束日期: {{year.end}}</p>
        <p>有　　效: {{year.active}}</p>
        <p>
            小學年級數目：<br>
            中學年級數目：

            <ul>
                <li v-for="group in year.grade_group">
                   {{group.initial}} : {{group.count}}
                </li>
            </ul>
        </p>
        <p class="text-red-500">To process specific GRADE, provide parameter with &gradeId=&ltgradeId&gt</p>
        <hr>
        <a-tabs v-model:activeKey="activeKey">
            <a-tab-pane key="grade" :tab="`Grade (`+year.abbr+`)`">
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
                        <tr v-for="(grade, gradeKey) in grades" :grade_id="grade.id">
                            <td class="text-left">{{grade.level}}</td>
                            <td class="text-left">{{grade.initial}}</td>
                            <td class="text-left">{{grade.tag}}</td>
                            <td class="text-left">{{grade.title_zh}}</td>
                            <td class="text-left">{{grade.version}}</td>
                            <td class="text-left">{{grade.active}}</td>
                            <td class="text-left">
                                <ul>
                                    <li v-for="(klass, klassKey) in grade.klasses" :klass_id="klass.id">
                                        <span @click="selectGradeKlass(klass.id,grade.tag+klass.letter)">
                                            {{grade.tag}}{{klass.letter}}
                                            ({{klass.student_count}})
                                            <team-outlined :style="{ fontSize: '24px' }"/>
                                        </span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <h3>Data directly from PromotionController@getStudents, query data while select Class on current Year's grade table</h3>
                <ul>
                    <li>所有同班同學 students</li>
                    <li>所屬的年級記錄 currentGrade</li>
                    <li>所屬的學年記錄 currentYear</li>
                    <li>所升的學年記錄 nextYear</li>
                    <li>所升的年級記錄 nextGrade</li>
                    <li>所升的可選的所有班別 nextGradeKlasses</li>
                </ul>

            </a-tab-pane>
            <a-tab-pane key="students" tab="Students" :disabled="(promotion.students.length==0)">
                <p>Promote: {{selectedKlassTag}} to {{promotion.nextGrade.tag}}</p>
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
            <a-tab-pane key="next_grade" :tab="`Next Grade (`+nextYear.abbr+`)`">
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
                        <tr v-for="(grade, gradeKey) in nextGrades" :grade_id="grade.id">
                            <td class="text-left">{{grade.level}}</td>
                            <td class="text-left">{{grade.initial}}</td>
                            <td class="text-left">{{grade.tag}}</td>
                            <td class="text-left">{{grade.title_zh}}</td>
                            <td class="text-left">{{grade.version}}</td>
                            <td class="text-left">{{grade.active}}</td>
                            <td class="text-left">
                                <ul>
                                    <li v-for="(klass, klassKey) in grade.klasses" :klass_id="klass.id">
                                        <span @click="selectPromotedGradeKlass(gradeKey, klass.id, klass.letter)">
                                            {{grade.tag}}{{klass.letter}} ({{klass.promoted_count}})
                                        </span>
                                        
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <h3>Data directly from PromotionController@getPromotedStudents, query data while select Class on NEXT Year's grade table</h3>
                <p>Update promoted.Students</p>
                <ul>
                    <li>所有同班同學 students</li>
                </ul>

            </a-tab-pane>
            <a-tab-pane key="promoted_students" tab="Promoted Students" :disabled="(promotedStudents.length==0)">
                <p>Promote to: {{promotedKlassTag}}</p>
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
                        <tr v-for="student in promotedStudents">
                            <td class="text-left">{{(student.pivot.student_number)}}</td>
                            <td class="text-left">{{(student.name_zh)}}</td>
                            <td class="text-left">{{(student.pivot.stream)}}</td>
                            <td class="text-left">{{(student.pivot.state)}}</td>
                            <td class="text-left">
                                <a-tag v-for="klass in promotedKlasses" :color="klass.letter==student.pivot.letter?'blue':''">
                                    {{klass.letter}}
                                </a-tag>
                            </td>
                            <td class="text-left"><span>ss</span></td>
                        </tr>
                    </tbody>
                </table>
            </a-tab-pane>
        </a-tabs>
                
        <p></p>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';
import { TeamOutlined } from '@ant-design/icons-vue';


export default {
    components: {
        AdminLayout,
        TeamOutlined
    },
    props: ['year','grades','nextYear','nextGrades'],
    data() {
        return {
            activeKey:"grade",
            promotion:{
                'students':[],
                'currentGrade':{},
                'currentYear':{},
                'nextGrade':{},
                'nextYear':{}
            },
            promotedStudents:[],
            selectedKlassTag:'',
            promotedKlassTag:'',
            promotedKlasses:[]
        }
    },
    methods: {
        selectGradeKlass(klassId,tag){
            this.selectedKlassTag=tag;
            axios.get('/promote/getStudents/'+klassId)
                .then(response=>{
                    this.promotion = response.data;
                    this.activeKey='students';
                });
        },
        selectPromotedGradeKlass(gradeKey, klassId,klassTag){
            //klassId for query Promoted students
            //GradeKey for gathering klass letters
            this.promotedKlassTag=this.nextGrades[gradeKey].tag+klassTag;
            this.promotedKlasses=this.nextGrades[gradeKey].klasses;
            axios.get('/promote/getPromotedStudents/'+klassId)
                .then(response=>{
                    this.promotedStudents = response.data;
                    this.activeKey='promoted_students';
                });
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
            axios.post('promote/updateStudents',{students:students})
                .then(response=>{
                    console.log(response.data);
                })
                .catch(error=>{
                    console.log(error);
                })
        }

    },
}
</script>

