<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Teacher
            </h2>
        </template>
        {{courses}}
        <table width="100%" border="1">
            <tr>
                <td>Student Name</td>
                <td v-for="course in courses">{{course.title_zh}}</td>
            </tr>

            <tr v-for="student in students_courses_scores">
                <td>{{student.name_zh}}</td>
                <td v-for="course in courses">
                    {{course.id}}
                    <span v-for="sc in student.courses_scores">
                        <span v-if="sc.id==course.id">
                            {{ sc.scores }}                            
                        </span>
                    </span>
                </td>
            </tr>
        </table>
        <ul>
            <li v-for="student in students_courses_scores">
                <ol v-for="courses in student.courses_scores">

                        <li>{{ courses.scores }}<hr></li>
                </ol>
            </li>
        </ul>
        <div>
            <a-table :dataSource="students_courses_scores" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <ButtonLink :href="'teaching/'+record.id" :type="'Link'">任教</ButtonLink>
                        
                    </template>
                    <template v-else-if="column.dataIndex=='courses'">
                        <ul>
                            <li v-for="course in record.courses">
                                {{ course.abbr }}-{{ course.title_zh }}
                                <Link :href="'score?kid='+course.klass_id + '&cid='+course.id" method="get" as="button" type="button">Score</Link>
                            </li>
                        </ul>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>

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
    props: ['students_courses_scores','courses'],
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

