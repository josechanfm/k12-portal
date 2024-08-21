<template>
<AdminLayout title="老師主控台" :breadcrumb="breadcrumb">
    <div class="">
         <div class="flex">
            <div class="flex-1">   <p>The collection of route "teacher" is for the general operation management such as serach and preview, which
                not included setup of year, class or subject etc.</p></div>
            <div>{{ staff.name_zh }}</div>
         </div>
        <a-tabs v-model:activeKey="activeKey">
            <a-tab-pane key="1" tab="任教科目"></a-tab-pane>
            <a-tab-pane key="2" tab="班主任" ></a-tab-pane>
            <a-tab-pane key="3" tab="科代表(科組長)"></a-tab-pane>
        </a-tabs>
    
        <div class="tborder m-2">
            <table id="dataTable">
                        <thead class="">
                            <tr>
                                <th>班級代號</th>
                                <th>科目名稱</th>
                                <th>班主任</th>
                                <th>科代表</th>
                                <th>學生人數</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody class="">
                            <template v-for="course in staff.courses">
                                <tr>
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
                                    <td>
                                        <a-button as="link" :href="route('teacher.selected.behaviours', {model:'course',id:course.id})"  size="small" type="info" >操行</a-button>
                                        <a-button as="link" :href="route('teacher.course.scores.index',course.id)"  size="small" type="info" >學分</a-button>
                                        <a-button @click="course.operation=!course.operation">更多...</a-button>
                                    </td>
                                </tr>
                                <tr class="ant-table-expanded-row ant-table-expanded-row-level-1" :style="course.operation==true?'display:true':'display:none'">
                                    <td colspan="7" class="ant-table-cell text-right">
                                        <a-button as="link" :href="route('teacher.selected.students', {model:'klass',id:course.klass.id})"  size="small" type="info" >學生名單</a-button>
                                        <a-button as="link" :href="route('teacher.klass.finalScores', course.klass.id)"  size="small" type="info" >期末成績</a-button>
                                        <a-button as="link" :href="route('director.klass.additive', [course.klass.id, 'PARTICIPATION'])"  size="small" type="info" >考勤</a-button>
                                        <a-button as="link" :href="route('director.klass.additive', [course.klass.id, 'POSITIVE'])"  size="small" type="info" >功</a-button>
                                        <a-button as="link" :href="route('director.klass.additive', [course.klass.id, 'NEGATIVE'])"  size="small" type="info" >過</a-button>
                                        <a-button as="link" :href="route('director.klass.additive', [course.klass.id, 'comment'])"  size="small" type="info" >評語</a-button>

                                    </td>
                                </tr>
                            </template>
                        </tbody>
                    </table>
        </div>
        <a-divider />
        <a-typography-title :level="4">班主任</a-typography-title>
        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="">
                            <tr>
                                <th>班級代號</th>
                                <th>學生人數</th>
                                <th>班主任</th>
                                <th>科目數</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody class="">
                            <template v-for="klass in staff.headKlasses">
                                <tr>
                                    <td>{{ klass.tag }}</td>
                                    <td>{{ klass.student_count}}</td>
                                    <td>
                                        <ol>
                                            <li v-for="staff in klass.klass_heads">
                                                {{staff.name_zh}}
                                            </li>
                                        </ol>
                                    </td>
                                    <td>{{ klass.course_count}}</td>
                                    <td>
                                        <template v-if="klassHeadBehaviour">
                                            <a-button as="link" :href="route('teacher.selected.behaviours',{model:'klass',id:klass.id})"  size="small" type="info" >操行</a-button>
                                        </template>
                                    </td>
                                </tr>
                            </template>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <a-divider />
        <a-typography-title :level="4">科代表(科組長)</a-typography-title>
        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="">
                            <tr>
                                <th class="ant-table-cell">班級代號</th>
                                <th>科目名稱</th>
                                <th>學生人數</th>
                                <th>班主任</th>
                                <th>任教老師</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody class="">
                            <template v-for="course in staff.headSubjects">
                                <tr>
                                    <td>{{ course.klass.tag }}</td>
                                    <td>{{ course.code }} {{ course.title_zh }}</td>
                                    <td>{{ course.student_count }}</td>
                                    <td>
                                        <ol>
                                            <li v-for="staff in course.klass.klass_heads">
                                                {{staff.name_zh}}
                                            </li>
                                        </ol>
                                    </td>
                                    <td>
                                        <ol>
                                            <li v-for="staff in course.teaching">
                                                {{staff.name_zh}}
                                            </li>
                                        </ol>
                                    </td>
                                    <td>
                                        {{ klassHeadBehaviour }}
                                        <template v-if="klassHeadBehaviour">
                                            <!-- <a-button as="link" :href="route('teacher.klass.behaviours',course.klass.id)"  size="small" type="info" >操行</a-button> -->
                                        </template>
                                    </td>
                                </tr>
                            </template>
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
    props: ['klassHeadBehaviour', 'subjectHeadBehaviour', 'staff'],
    data() {
        return {
            activeKey:'1',
            breadcrumb: [{
                label: '教師',
                url: null
            }, ],
            columns: [{
                title: '班級代號',
                dataIndex: 'klass_tag',
            }, {
                title: '科目名稱',
                dataIndex: 'course_title',
            }, {
                title: '班主任',
                dataIndex: 'klass_heads',
            }, {
                title: '科代表',
                dataIndex: 'subject_heads',
            }, {
                title: '學生人數',
                dataIndex: 'student_count',
            }, {
                title: '操作',
                dataIndex: 'operation',
            }]

        }
    },
    methods: {
        onClickShowExpended(course) {
            course.operation = true;
            console.log(course);
        }
    },
}
</script>

<style scoped>
.tborder{
    @apply rounded-lg border overflow-hidden border-slate-400 border-solid
}
table#dataTable {
    @apply  text-center bg-slate-100 w-full text-2xl
}
table#dataTable th {
    @apply border-solid border border-collapse
        border-t-0 border-r-0 text-lg font-black 
        border-slate-400   text-slate-500/90
}
table#dataTable td {
    @apply  border-solid border border-collapse border-t-0 border-r-0
       font-black text-sky-600/90
       border-slate-400  
}
table#dataTable td:first-child {
    @apply  border-l-0 
}
table#dataTable th:first-child {
    @apply  border-l-0 
}
table#dataTable td {
    @apply bg-sky-100 
}

table#dataTable input {
    @apply font-black text-center  text-xl
}
table#dataTable input:focus {
    @apply border-4 border-indigo-600
}

</style>
