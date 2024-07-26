<template>
    <AdminLayout title="班別管理" :breadcrumb="breadcrumb">
        <p>Klass: {{ klass.tag }}</p>
        <p>Students: {{ klass.student_count }}</p>
        <p>Current Term: {{currentTerm.label}}</p>
        
        <template v-if="klass.grade_year<=3">
            <a-button as="link" :href="route('director.klass.students.index', klass.id)" class="ant-btn">學生名單</a-button>
            <a-button as="link" :href="route('director.klass.habits', klass.id)" class="ant-btn">生活習摜</a-button>
            <a-button as="link" :href="route('director.klass.abilities', klass.id)" class="ant-btn">學習主題</a-button>
            <a-button as="link" :href="route('director.pre.klass.finalScores', klass.id)" class="ant-btn">期末成績</a-button>
        </template>
        <template v-else>
            <a-button as="link" :href="route('director.klass.students.index', klass.id)" class="ant-btn">學生名單</a-button>
            <a-button as="link" :href="route('director.klass.avatars',klass.id)" class="ant-btn ant-btn-default">學生照片</a-button>
            <a-button as="link" :href="route('director.klass.finalScores', klass.id)" class="ant-btn">期末成績</a-button>
            <a-button as="link" :href="route('director.klass.transcripts', {'klass':klass.id,'type':'summary'})" class="ant-btn">成績總表</a-button>
            <a-button as="link" :href="route('director.klass.transcripts', klass.id)" class="ant-btn">成績大表</a-button>
        </template>
        <a-divider type="vertical" />
            <a-button as="link" :href="route('director.klass.behaviours.index', klass.id)" class="ant-btn">操行</a-button>
            <a-button as="link" :href="route('director.klass.behaviour.adjust', klass.id)" class="ant-btn">操行調整</a-button>
        <a-divider type="vertical" />
        <template v-if="additiveStyle=='default'">
            <template v-for="group in additiveGroups">
                <a-button as="link" :href="route('director.klass.additive',[klass.id,group.category.toLowerCase()])" class="ant-btn">{{group.label}}</a-button>
            </template>
        </template>
        <template v-else-if="additiveStyle=='direct'">
            <a-button as="link" :href="route('director.klass.additive.direct', klass.id)" class="ant-btn">紀律行為</a-button>
        </template>
        <template v-else-if="additiveStyle=='page'">
            <a-button as="link" :href="route('director.klass.additive.page', klass.id)" class="ant-btn">紀律行為</a-button>
        </template>
        <a-divider type="vertical" />
        <a-button as="link" :href="route('director.klass.promotes.index',klass.id)" class="ant-btn">升留班預處理</a-button>

        <p>&nbsp;</p>

        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="ant-table-thead">
                            <tr>
                                <th class="text-left">Abbr</th>
                                <th class="text-left">Title Zh</th>
                                <th class="text-left">Stream</th>
                                <th class="text-left">Elective</th>
                                <th class="text-left">Active</th>
                                <th class="text-left">Units</th>
                                <th class="text-left">Score</th>
                                <th class="text-left">Subject Head</th>
                                <th class="text-left">Teacher</th>
                            </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <tr v-for="(course, courseKey) in klass.courses" :course_id="course.id">
                                <td class="text-left">{{ course.code }}</td>
                                <td class="text-left">{{ course.title_zh }}</td>
                                <td class="text-left">{{ course.stream }}</td>
                                <td class="text-left">{{ course.elective }}</td>
                                <td class="text-left">{{ course.active }}</td>
                                <td class="text-left">{{ course.unit }}</td>
                                <td class="text-left">
                                    <ol>
                                        <li v-for="staff in course.subject_heads">{{ staff.name_zh }}</li>
                                    </ol>
                                </td>

                                <td class="text-left">
                                    <ol>
                                        <li v-for="staff in course.staffs">{{ staff.name_zh }}</li>
                                    </ol>
                                </td>
                                <th class="text-left">
                                    <a-button as="link" :href="route('director.course.scores.index', course.id)"
                                        class="ant-btn">學分</a-button>
                                    <a-button as="link" :href="route('director.course.makeups', course.id)"
                                        class="ant-btn">補考</a-button>
                                </th>
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


export default {
    components: {
        AdminLayout
    },
    props: ['currentTerm','klass','additiveTemplates','additiveStyle','additiveGroups'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('director.dashboard')},
                {label:"年級班別", url:route('director.grades.index',{'type':'secondary'})},
                {label:this.klass.grade.initial+'年級' ,url:null},
            ],
            course: {}
        }
    },
    mounted() {
    },
    methods: {
        showModal(){
            console.log('showmodal')
            this.modal.isOpen=true
        },
        handleOk() {

        }
    },
}
</script>




