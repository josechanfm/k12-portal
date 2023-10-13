<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                成積表
            </h2>
        </template>
        <a-button @click="migrateTranscripts" :disabled="klass.transcript_migrated == 9">
            <span v-if="klass.transcript_migrated == 1">重新轉換成積表分數</span>
            <span v-else>轉換成積表分數</span>
        </a-button>

        <div class="py-5">
            <KlassSelector routePath="manage.klass.transcripts" :param="[]" :currentKlass="klass" />
        </div>
        <div class="py-12">
            <div class="mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-auto shadow-xl">
                    <table width="100%" border="1" id="bigTable">
                        <thead>
                            <tr>
                                <td rowspan="3">Student Name</td>
                                <td v-for="course in transcripts['courses']" :colspan="course.score_columns.length" class="text-center">
                                    {{ course.title_zh }}
                                </td>
                                <td colspan="2">
                                    操行
                                </td>
                            </tr>
                            <tr>
                                <template v-for="course in transcripts['courses']">
                                    <td v-for="term in year_terms" :colspan="3" class="text-center">
                                        {{ term.label }}
                                    </td>
                                    <td></td>
                                </template>
                                <td v-for="term in year_terms" rowspan="2" class="text-center">
                                    {{ term.label}}
                                </td>
                            </tr>
                            <tr>
                                <template v-for="course in transcripts['courses']">
                                    <td v-for="column in course.score_columns"  class="text-center">
                                        {{ column.field_label }}
                                    </td>
                                </template>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(student,ksid) in transcripts['students']">
                                <td>{{ student.name_zh}}</td>
                                <template v-for="course in transcripts['courses']">
                                    <td v-for="column in course.score_columns"  class="text-center">
                                        <span v-if="transcripts['scores'][ksid][course.id]">
                                            <span v-if="transcripts['scores'][ksid][course.id][column.id]==null">
                                                --
                                            </span>
                                            <span v-else>
                                                {{ transcripts['scores'][ksid][course.id][column.id].point}}
                                            </span>
                                        </span>
                                    </td>
                                </template>
                                <template v-for="term in year_terms">
                                    <td>
                                        {{ transcripts['behaviours'][ksid][term.value] }}
                                    </td>
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
    props: ['year', 'klass','year_terms', 'transcripts', 'students_courses_scores', 'courses', 'scores', 'behaviours'],
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
        migrateTranscripts() {
            if (this.klass.transcript_migrated == 1) {
                if (!confirm('成積表分數已經轉換，是不確定重新轉換？')) {
                    return false;
                }
            } else {
                if (!confirm('是不確定轉換成積表分數？')) {
                    return false;
                }
            }
            this.$inertia.get(route("manage.klass.transcripts.migrate",this.klass.id), {
                onSuccess: (page) => {
                        this.modal.isOpen=false;
                        console.log('Cancelled')
                    },
                    onError: (error) => {
                        console.log(error);
                    }
            })
        },

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