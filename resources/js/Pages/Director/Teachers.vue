<template>
    <AdminLayout title="老師" :breadcrumb="breadcrumb">
        <div>
            <a-table :dataSource="teachers" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <ButtonLink :href="'teaching/'+record.id" :type="'Link'">任教</ButtonLink>
                        
                    </template>
                    <template v-else-if="column.dataIndex=='courses'">
                        <ul>
                            <li v-for="course in record.courses">
                                {{ course.klass.tag }} - {{ course.code }}-{{ course.title_zh }}
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

