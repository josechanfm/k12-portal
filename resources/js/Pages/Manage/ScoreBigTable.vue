<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                成積表
            </h2>
        </template>
        <div class="py-5">
            <KlassSelector routePath="manage.klass.transcript" :param="[]" :currentKlass="klass" />
        </div>
        <div class="py-12">
            <div class="mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-auto shadow-xl">
                    <table width="100%" border="1" id="bigTable">
                        <thead>
                            <tr>
                                <td rowspan="3">Student Name</td>
                                <td v-for="course in courses" :colspan="course.score_columns.length" class="text-center">
                                    {{ course.title_zh }}
                                </td>
                                <td colspan="2">
                                    操行
                                </td>
                            </tr>
                            <tr>
                                <template v-for="course in courses">
                                    <td v-for="term in course.terms" :colspan="term.column_count" class="text-center">
                                        {{ term.label }}
                                    </td>
                                    <td></td>
                                </template>
                                <td v-for="term in year_terms" rowspan="2" class="text-center">
                                    {{ term.label}}
                                </td>
                            </tr>
                            <tr>
                                <template v-for="course in courses">
                                    <td v-for="column in course.score_columns"  class="text-center">
                                        {{ column.field_label }}
                                    </td>
                                </template>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="score in scores">
                                <td>{{ score.name_zh }}</td>
                                <template v-for="course in courses">
                                    <td v-for="column in course.score_columns" class="text-center">
                                        {{ score[course.id][column.id]['point'] }}
                                    </td>
                                </template>
                                <template v-for="student in behaviours">
                                    <template v-for="term in year_terms">
                                        <td v-if="student.id==score.id" class="text-center">
                                            {{ student.sumTerms[term.value] }}
                                        </td>
                                    </template>
                                </template>
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
import ButtonLink from '@/Components/ButtonLink.vue';
import KlassSelector from '@/Components/KlassSelector.vue';

export default {
    components: {
        AdminLayout, ButtonLink, KlassSelector
    },
    props: ['year', 'klass','year_terms', 'students_courses_scores', 'courses', 'scores', 'behaviours'],
    data() {
        return {
            columns: [
                {
                    title: 'Staff #',
                    dataIndex: 'staff_code',
                }, {
                    title: 'Name',
                    dataIndex: 'name_zh',
                }, {
                    title: 'Subject',
                    dataIndex: 'subject_ara',
                }, {
                    title: 'Courses',
                    dataIndex: 'courses',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ]
        }
    },
    mounted() {
    },

    methods: {
    },
}
</script>

<style>
#bigTable,
#bigTable td,
#bigTable tr {
    border: 1px solid;
}
</style>