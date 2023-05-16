<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Teacher
            </h2>
        </template>
        <table width="100%" border="1" id="bigTable">
            <tr>
                <td rowspan="3">Student Name</td>
                <td v-for="course in courses" :colspan="course.score_columns.length">
                    {{course.title_zh}}
                </td>
            </tr>
            <tr>
                <template v-for="course in courses">
                    <td v-for="term in course.terms" :colspan="term.columns">
                        {{term.label}}
                    </td>
                </template>
            </tr>
            <tr>
                <template v-for="course in courses">
                    <td v-for="column in course.score_columns">
                        {{column.field_label}}
                    </td>
                </template>
            </tr>

            <tr v-for="score in scores">
                <td>{{score.name_zh}}</td>
                <template v-for="course in courses">
                    <td v-for="column in course.score_columns">
                        {{score[course.id][column.id]}}
                    </td>
                </template>
            </tr>

        </table>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';

export default {
    components: {
        AdminLayout, ButtonLink
    },
    props: ['students_courses_scores','courses','scores'],
    data() {
        return {
            columns:[
                {
                    title: 'Staff #',
                    dataIndex: 'staff_code',
                },{
                    title: 'Name',
                    dataIndex: 'name_zh',
                },{
                    title: 'Subject',
                    dataIndex: 'subject_ara',
                },{
                    title: 'Courses',
                    dataIndex: 'courses',
                },{
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ]
        }
    },
    methods: {
    },
}
</script>

<style>
#bigTable, #bigTable td, #bigTable tr{
    border: 1px solid;
}
</style>