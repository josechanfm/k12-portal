<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Score Summary
            </h2>
        </template>
        <a-button @click="migrateTranscripts" :disabled="klass.transcript_migrated == 9">
            <span v-if="klass.transcript_migrated == 1">重新轉換成積表分數</span>
            <span v-else>轉換成積表分數</span>
        </a-button>

        <div class="py-5">
            <KlassSelector routePath="manage.klass.transcript" :param="{type:'summary'}" :currentKlass="klass"/>
        </div>
        <div class="py-12">
            <div class="mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-auto shadow-xl">
                    <table width="100%" border="1" id="bigTable">
                        <thead>
                            <tr>
                                <td rowspan="2">Student Name</td>
                                <td v-for="course in courses" :colspan="year_terms.length" class="text-center">
                                    {{course.title_zh}}
                                </td>
                                <td :colspan="year_terms.length" class="text-center">操行</td>
                            </tr>
                            <tr>
                                <template v-for="course in courses">
                                    <td v-for="term in year_terms" class="text-center">
                                        {{term.label}}
                                    </td>
                                </template>
                                <td v-for="term in year_terms" class="text-center">
                                    {{term.label}}
                                </td>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="score in scores">
                                <td>{{score.name_zh}}</td>
                                <template v-for="course in courses">
                                    <template v-for="column in course.score_columns">
                                        <td v-if="column.is_total==1" class="text-center">
                                            {{score[course.id][column.id]['point']}}
                                        </td>
                                    </template>
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
    props: ['year','klass','year_terms','students_courses_scores','courses','scores','behaviours'],
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
    mounted() {
    },
    methods: {
        migrateTranscripts() {
            if (this.klass.transcript_migrated == 1) {
                if (!confirm('成積表分數已經轉換，是不確定重新轉換？')) {
                    return false;
                }
            } else {
                if (!confirm('是否確定轉換成積表分數？')) {
                    return false;
                }
            }
            this.$inertia.get(route("manage.klass.transcript.migrate",this.klass.id), {
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
#bigTable, #bigTable td, #bigTable tr{
    border: 1px solid;
}
</style>