<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別管理
            </h2>
        </template>
        <p>Klass: {{ klass.tag }}</p>
        <p>Students: {{ klass.student_count }}</p>
        <p>Current Term: {{currentTerm.label}}</p>
        <template v-if="klass.grade_year<=3">
            <inertia-link :href="route('manage.klass.habits', klass.id)" class="ant-btn">生活習摜</inertia-link>
            <inertia-link :href="route('manage.klass.abilities', klass.id)" class="ant-btn">學習主題</inertia-link>
        </template>
        <inertia-link :href="route('manage.klass.students', klass.id)" class="ant-btn">學生名單</inertia-link>
        <inertia-link :href="route('manage.klass.finalScores', klass.id)" class="ant-btn">期末成績</inertia-link>
        <inertia-link :href="route('manage.klass.transcript', klass.id)" class="ant-btn">成積總表</inertia-link>
        <a-divider type="vertical" />
        <template v-if="additiveStyle=='default'">
            <template v-for="group in additiveGroups">
                <inertia-link :href="route('manage.klass.additive',[klass.id,group.category.toLowerCase()])" class="ant-btn">{{group.label}}</inertia-link>
            </template>
        </template>
        <template v-else-if="additiveStyle=='page'">
            <inertia-link :href="route('manage.klass.additive.page', klass.id)" class="ant-btn">單頁模式</inertia-link>
        </template>
        <template v-else-if="additiveStyle=='direct'">
            <inertia-link :href="route('manage.klass.additive.direct', klass.id)" class="ant-btn">直接輸入</inertia-link>
        </template>


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
    props: ['currentTerm','klass','additiveTemplates','additiveStyle','additiveGroups'],
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




