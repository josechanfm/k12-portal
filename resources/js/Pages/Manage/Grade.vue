<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                年級管理
            </h2>
        </template>
        <a-tree
            checkable
            :tree-data="courseScores"
        >
        </a-tree>
        <a-tabs v-model:activeKey="activeKey">
            <a-tab-pane key="grade" :tab="`Grade (`+year.abbr+`)`">
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Level</th>
                            <th class="text-left">Initial</th>
                            <th class="text-left">Tag</th>
                            <th class="text-left">Titile Zh</th>
                            <th class="text-left">Version</th>
                            <th class="text-left">Active</th>
                            <th class="text-left">Students</th>
                            <th class="text-left">Courses</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(grade, gradeKey) in grades" :grade_id="grade.id">
                            <td class="text-left">{{ grade.level }}</td>
                            <td class="text-left">{{ grade.initial }}</td>
                            <td class="text-left">{{ grade.tag }}</td>
                            <td class="text-left">{{ grade.title_zh }}</td>
                            <td class="text-left">{{ grade.version }}</td>
                            <td class="text-left">{{ grade.active }}</td>
                            <td class="text-left">
                                <ul>
                                    <li v-for="(klass, klassKey) in grade.klasses" :klass_id="klass.id">
                                        <span @click="selectKlass(klass.id)">
                                            {{ grade.tag }}{{ klass.letter }}
                                            ({{ klass.student_count }})
                                            <team-outlined :style="{ fontSize: '24px' }" />

                                        </span>
                                    </li>
                                </ul>
                            </td>
                            <td class="text-left">
                                <ul>
                                    <li v-for="(klass, klassKey) in grade.klasses" :klass_id="klass.id">
                                        <span @click="selectCourse(klass.id)">Courses</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </a-tab-pane>
            <a-tab-pane key="course" tab="Courses " :disabled="courses.length<=0">
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Abbr</th>
                            <th class="text-left">Title</th>
                            <th class="text-left">Type</th>
                            <th class="text-left">Teacher</th>
                            <th class="text-left">Score</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="course in courses" :course_id="course.id">
                            <td class="text-left">{{ course.abbr }}</td>
                            <td class="text-left">{{ course.title_zh }}</td>
                            <td class="text-left">{{ course.stream }}</td>
                            <td class="text-left">{{ course.staff_id }}</td>
                            <td class="text-left">
                                <Link :href="'score?kid='+course.klass_id + '&cid='+course.id" method="get" as="button" type="button">Score</Link>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </a-tab-pane>
            <a-tab-pane key="student" tab="Students" :disabled="students.length<=0">
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Name</th>
                            <th class="text-left">Gender</th>
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

        <p></p>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { TeamOutlined } from '@ant-design/icons-vue';
import { Link } from '@inertiajs/inertia-vue3';

export default {
    components: {
        AdminLayout, TeamOutlined, Link
    },
    props: ['year','grades','courseScores'],
    data() {
        return {
            activeKey:'grade',
            courses:[],
            students:[],
        }
    },
    methods: {
        selectKlass(klassId){   
            axios.get('/manage/students/'+klassId)
                .then(response=>{
                    this.students = response.data;
                    this.courses = [];
                    this.activeKey='student';
                });
        },
        selectCourse(klassId){
            axios.get('/manage/courses/'+klassId)
                .then(response=>{
                    this.courses = response.data;
                    this.students = [];
                    this.activeKey='course';
                });
        }
    },
}
</script>

