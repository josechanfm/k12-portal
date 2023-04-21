<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                年級管理
            </h2>
        </template>
        <a-typography-title :level="4">學年代號: {{ year.code }}</a-typography-title>
        <a-typography-title :level="4">學年全稱: {{ year.title }}</a-typography-title>
        <a-typography-title :level="4">學年開始: {{ year.start }}</a-typography-title>
        <a-typography-title :level="4">學年結束: {{ year.end }}</a-typography-title>
        <a-typography-title :level="4">當前年級號別: {{ selectedKlass.tag }}</a-typography-title>
        <a-tabs v-model:activeKey="activeKey">
            <a-tab-pane key="grade" tab="年級">
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">年級代號</th>
                            <th class="text-left">年級名稱</th>
                            <th class="text-left">班別代號</th>
                            <th class="text-left">班別學生數目</th>
                            <th class="text-left">科目</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(grade, gradeKey) in grades" :grade_id="grade.id">
                            <td class="text-left">{{ grade.tag }}</td>
                            <td class="text-left">{{ grade.title_zh }}</td>
                            <td class="text-left">
                                <ul>
                                    <li v-for="(klass, klassKey) in grade.klasses" :klass_id="klass.id">
                                        <span @click="selectKlass(klass,'student')">
                                            {{ grade.tag }}{{ klass.letter }}
                                        </span>
                                    </li>
                                </ul>
                            </td>
                            <td class="text-left">
                                <ul>
                                    <li v-for="(klass, klassKey) in grade.klasses" :klass_id="klass.id">
                                        <span @click="selectKlass(klass,'student')">
                                            {{ klass.student_count }}
                                        </span>
                                    </li>
                                </ul>
                            </td>
                            <td class="text-left">
                                <ul>
                                    <li v-for="klass in grade.klasses" :klass_id="klass.id">
                                        <span @click="selectKlass(klass,'course')">
                                            Courses
                                            <inertia-link :href="route('manage.klasses.show',klass.id)" class="ant-btn" >Panel</inertia-link>
                                        </span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </a-tab-pane>
            <a-tab-pane key="course" :tab="'科目列表 ('+selectedKlass.tag+')'" :disabled="courses.length<=0">
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">科目</th>
                            <th class="text-left">科目名稱</th>
                            <th class="text-left">專業方向</th>
                            <th class="text-left">教師</th>
                            <th class="text-left">班主任</th>
                            <th class="text-left">學分</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="course in courses" :course_id="course.id">
                            <td class="text-left">{{ course.code }}</td>
                            <td class="text-left">{{ course.title_zh }}</td>
                            <td class="text-left">{{ course.stream }}</td>
                            <td class="text-left">
                                <ul>
                                    <li v-for="teacher in course.teachers">
                                        {{ teacher.name_zh }} ({{ teacher.staff_id }} )
                                    </li>
                                </ul>
                            </td>
                            <td class="text-left">
                                <template v-for="teacher in course.teachers" >
                                    <span v-if="teacher.pivot.is_head">{{teacher.name_zh}}</span>
                                </template>
                            </td>
                            <td class="text-left">
                                <inertia-link :href="route('manage.klass.habits',course.klass_id)" :style="'Link'" type="Link">生活</inertia-link>
                                <inertia-link :href="route('manage.course.scores',course.id)" :style="'Link'" type="Link">學分</inertia-link>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </a-tab-pane>
            <a-tab-pane key="student" :tab="'學生列表 ('+selectedKlass.tag+')'" :disabled="students.length<=0">
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">學生姓名</th>
                            <th class="text-left">性別</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="student in students" :student_id="student.id">
                            <td class="text-left">{{ student.name_zh }}</td>
                            <td class="text-left">{{ student.gender }}</td>
                        </tr>
                    </tbody>
                </table>

            </a-tab-pane>
        </a-tabs>

        <h2 id="section2">Section 2</h2>
        <p>adsfadsfadsf</p>


    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { TeamOutlined } from '@ant-design/icons-vue';
import ButtonLink from '@/Components/ButtonLink.vue';


export default {
    components: {
        AdminLayout, TeamOutlined, ButtonLink
    },
    props: ['year','grades'],
    data() {
        return {
            activeKey:'grade',
            courses:[],
            students:[],
            selectedKlass:{
                tag:"--"
            }
        }
    },
    mounted(){
        const urlParams=new URLSearchParams(window.location.search);
        const klassId=urlParams.get('kid');
        this.grades.map(grade=>{
            grade.klasses.map(klass=>{
                if(klass.id==klassId){
                    this.selectKlass(klass,'course')
                }
            });
        });
    }, 
    methods: {
        selectKlass(klass,activeKey){   
            this.selectedKlass=klass;
            axios.get('/manage/students/get_by_klass_id/'+klass.id)
                .then(response=>{
                    this.students = response.data;
                    //this.courses = [];
                });
            this.selectCourse(klass);
            this.activeKey=activeKey;
            //this.activeKey='student';
        },
        selectCourse(klass){
            this.selectedKlass=klass;
            axios.get('/manage/courses/get_by_klass_id/'+klass.id)
                .then(response=>{
                    this.courses = response.data;
                    console.log(this.courses);
                    //console.log(reponse.data);
                    //this.students = [];
                });
        }
    },
}
</script>

