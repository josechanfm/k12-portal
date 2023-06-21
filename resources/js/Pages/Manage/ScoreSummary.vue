<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Summary
            </h2>
        </template>
        <table width="100%" border="1" id="bigTable">
            <tr>
                <td rowspan="2">Student Name</td>
                <td v-for="course in courses" :colspan="year_terms.length">
                    {{course.title_zh}}
                </td>
            </tr>
            <tr>
                <template v-for="course in courses">
                    <td v-for="term in course.terms" >
                        {{term.label}}
                    </td>
                </template>
            </tr>
            <tr v-for="score in scores">
                <td>{{score.name_zh}}</td>
                <template v-for="course in courses">
                    <template v-for="column in course.score_columns">
                        <td v-if="column.is_total==1">
                            {{score[course.id][column.id]['point']}}
                        </td>
                    </template>
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
    props: ['year_terms','students_courses_scores','courses','scores'],
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