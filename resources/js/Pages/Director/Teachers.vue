<template>
    <AdminLayout title="老師" :breadcrumb="breadcrumb">
        <div>
            <a-table :dataSource="teachers" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <a-button as="link" :href="route('director.teachers.show',record.id)">任教</a-button>
                    </template>
                    <template v-else-if="column.dataIndex=='courses'">
                        <ul>
                            <li v-for="course in record.courses">
                                {{ course.klass.tag }} - {{ course.code }}-{{ course.title_zh }}
                                <a-button as="link" :href="route('teacher.course.scores.index', course.id)" class="ant-btn">學分</a-button>
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
    props: ['teachers'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台" ,url:route('director.dashboard')},
                {label:"老師" ,url:null},
            ],
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

