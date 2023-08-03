<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Teacher Dashboard
            </h2>
        </template>
        <div>
            <p>The collection of route "teacher" is for the general operation management such as serach and preview, which
                not included setup of year, class or subject etc.</p>
            <a-typography-title :level="4">{{ teacher.name_zh }}</a-typography-title>
            <div class="ant-table">
                <div class="ant-table-container">
                    <div class="ant-table-content">
                        <table style="table-layout: auto;">
                            <thead class="ant-table-thead">
                                <tr>
                                    <td>班級代號</td>
                                    <td>科目名稱</td>
                                    <td>班主任</td>
                                    <td>科代表</td>
                                    <td>學生人數</td>
                                </tr>
                            </thead>
                            <tbody class="ant-table-tbody">
                                <tr v-for="course in teacher.courses">
                                    <td>{{ course.klass.tag }}</td>
                                    <td>{{ course.code }}{{ course.title_zh }}</td>
                                    <td>
                                        <ol>
                                            <li v-for="head in course.klass.klass_heads">{{ head.name_zh }}</li>
                                        </ol>
                                    </td>
                                    <td>
                                        <ol>
                                            <li v-for="head in course.subject_heads">{{ head.name_zh }}</li>
                                        </ol>
                                    </td>
                                    <td>{{ course.student_count }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
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
    props: ['teacher'],
    data() {
        return {
        }
    },
    methods: {
    },
}
</script>

