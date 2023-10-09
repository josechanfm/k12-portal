<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Teacher
            </h2>
        </template>

        <a-radio-group v-model:value="selectedGradeId" button-style="solid">
            <a-radio-button v-for="grade in year.grades" :value="grade.id">{{grade.tag}}</a-radio-button>
        </a-radio-group>
        <p></p>
        <a-radio-group v-model:value="selectedKlassId" button-style="solid">
            <template v-for="klass in year.klasses">
                <a-radio-button v-if="klass.grade_id==selectedGradeId" :value="klass.id">
                    <inertia-link :href="route('manage.klass.transcript',klass.id)">{{klass.tag}}</inertia-link>
                </a-radio-button>
            </template>
        </a-radio-group>



        <div class="py-12">
            <div class="mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">

        <table width="100%" border="1" id="bigTable">
            <tr>
                <td rowspan="3">Student Name</td>
                <td v-for="course in courses" :colspan="course.score_columns.length">
                    {{course.title_zh}}
                </td>
            </tr>
            <tr>
                <template v-for="course in courses">
                    <td v-for="term in course.terms" :colspan="term.column_count">
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
                        {{score[course.id][column.id]['point'] }}
                    </td>
                </template>
            </tr>

        </table>
                </div>
            </div>
        </div>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';

export default {
    components: {
        AdminLayout, ButtonLink
    },
    props: ['year','klass','students_courses_scores','courses','scores'],
    data() {
        return {
            selectedGradeId:0,
            selectedKlassId:0,
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
    mounted() {
        this.selectedGradeId=this.klass.grade_id
        this.selectedKlassId=this.klass.id
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