<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別管理
            </h2>
        </template>
        <p>Klass: {{ klass.tag }}</p>
        <p>Students: {{ klass.student_count }}</p>
        <template v-if="klass.grade_year<=3">
            <inertia-link :href="route('manage.klass.habits', klass.id)" class="ant-btn">生活習摜</inertia-link>
            <inertia-link :href="route('manage.klass.abilities', klass.id)" class="ant-btn">學習主題</inertia-link>
        </template>
        <inertia-link :href="route('manage.klass.students', klass.id)" class="ant-btn">學生名單</inertia-link>
        <inertia-link :href="route('manage.klass.finalScores', klass.id)" class="ant-btn">期末成績</inertia-link>
        <inertia-link :href="route('manage.klass.transcript', klass.id)" class="ant-btn">成積總表</inertia-link>
        <a-divider type="vertical" />
        <inertia-link :href="route('manage.klass.additive', [klass.id, 'attendance'])" class="ant-btn">考勤</inertia-link>
        <inertia-link :href="route('manage.klass.additive', [klass.id, 'perform'])" class="ant-btn">獎懲</inertia-link>
        <inertia-link :href="route('manage.klass.additive', [klass.id, 'conduct'])" class="ant-btn">操行</inertia-link>
        <inertia-link :href="route('manage.klass.additive', [klass.id, 'comments'])" class="ant-btn">評語</inertia-link>
        <inertia-link :href="route('manage.klass.additive', [klass.id, 'violation'])" class="ant-btn">違規</inertia-link>
        <a-divider type="vertical" />
        <inertia-link :href="route('manage.klass.additive.page', klass.id)" class="ant-btn">行為</inertia-link>
        <p>&nbsp;</p>

        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="ant-table-thead">
                            <tr>
                                <th class="text-left">Abbr</th>
                                <th class="text-left">Title Zh</th>
                                <th class="text-left">Stream</th>
                                <th class="text-left">Elective</th>
                                <th class="text-left">Active</th>
                                <th class="text-left">Units</th>
                                <th class="text-left">Score</th>
                            </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <tr v-for="(course, courseKey) in klass.courses" :course_id="course.id">
                                <td class="text-left">{{ course.code }}</td>
                                <td class="text-left">{{ course.title_zh }}</td>
                                <td class="text-left">{{ course.stream }}</td>
                                <td class="text-left">{{ course.elective }}</td>
                                <td class="text-left">{{ course.active }}</td>
                                <td class="text-left">{{ course.unit }}</td>
                                <th class="text-left">
                                    <inertia-link :href="route('manage.course.scores', course.id)"
                                        class="ant-btn">學分</inertia-link>
                                    <inertia-link :href="route('manage.course.makeups', course.id)"
                                        class="ant-btn">補考</inertia-link>
                                </th>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';


export default {
    components: {
        AdminLayout
    },
    props: ['klass','additiveTemplates'],
    data() {
        return {
            course: {}
        }
    },
    mounted() {
    },
    methods: {
        showModal(){
            console.log('showmodal')
            this.modal.isOpen=true
        },
        handleOk() {

        }
    },
}
</script>




