<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別管理
            </h2>
        </template>
        <p>Klass: {{ klass.tag }}</p>
        <p>Students: {{ klass.student_count }}</p>
        <inertia-link :href="route('manage.klass.habits', klass.id)" class="ant-btn">生活習摜</inertia-link>
        <inertia-link :href="route('manage.klass.abilities', klass.id)" class="ant-btn">學習主題</inertia-link>
        <inertia-link :href="route('manage.klass.outcomes', klass.id)" class="ant-btn">獎懲</inertia-link>
        <inertia-link :href="route('manage.klass.behaviours', klass.id)" class="ant-btn">行為表現</inertia-link>
        <inertia-link :href="route('manage.klass.students', klass.id)" class="ant-btn">學生名單</inertia-link>
        <inertia-link :href="route('manage.klass.finalScores', klass.id)" class="ant-btn">期末成績</inertia-link>
        <inertia-link :href="route('manage.klass.additive', [klass.id,'attendance'])" class="ant-btn">考勤</inertia-link>
        <inertia-link :href="route('manage.klass.additive', [klass.id,'perform'])" class="ant-btn">功過</inertia-link>
        <inertia-link :href="route('manage.klass.additive', [klass.id,'conduct'])" class="ant-btn">操行</inertia-link>
        <inertia-link :href="route('manage.klass.additive', [klass.id,'comments'])" class="ant-btn">評語</inertia-link>
        <p>&nbsp;</p>
        <table width="100%">
            <thead>
                <tr>
                    <th class="text-left">Abbr</th>
                    <th class="text-left">Title Zh</th>
                    <th class="text-left">Stream</th>
                    <th class="text-left">Elective</th>
                    <th class="text-left">Active</th>
                    <th class="text-left">Score</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(course, courseKey) in courses" :course_id="course.id">
                    <td class="text-left">{{ course.code }}</td>
                    <td class="text-left">{{ course.title_zh }}</td>
                    <td class="text-left">{{ course.stream }}</td>
                    <td class="text-left">{{ course.elective }}</td>
                    <td class="text-left">{{ course.active }}</td>
                    <th class="text-left">
                        <inertia-link :href="route('manage.course.scores', course.id)" class="ant-btn">學分</inertia-link>
                        <inertia-link :href="route('manage.course.makeups', course.id)" class="ant-btn">補考</inertia-link>
                    </th>
                </tr>
            </tbody>
        </table>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';


export default {
    components: {
        AdminLayout
    },
    props: ['grade', 'klass', 'courses', 'students'],
    data() {
        return {
            course: {}
        }
    },
    mounted() {
    },
    methods: {
        handleOk() {

        }
    },
}
</script>




