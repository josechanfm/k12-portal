<template>
<AdminLayout title="年級班別" >

    <a-table :dataSource="viewGrades" class="w-1/2">
        <a-table-column title="年級">
            <template #default="{record}">
                {{ record.tag}}
            </template>
        </a-table-column>
        <template v-for="aph in 'a'.toUpperCase().split('')" :key="aph">
            <a-table-column :title="aph">
                <template #default="{record}">
                    <div v-if="record.klasses[aph]">
                        <a-button as="link" :href="route('director.klasses.show',record.klasses[aph].id)" class="ant-btn">
                            <div class="flex  gap-1">
                                <div>{{ record.klasses[aph].tag }}</div>
                                <a-tag> {{ record.klasses[aph].student_count}} 人</a-tag>
                            </div>
                        </a-button>
                    </div>
                </template>
            </a-table-column>
        </template>
    </a-table>

    <!-- <div class="">
        <div class="">
            <div class="">
                <table style="table-layout: auto">
                    <thead class="">
                        <tr>
                            <th class="text-left">班別學生數目</th>
                            <th class="text-left">A</th>
                            <th class="text-left">B</th>
                            <th class="text-left">C</th>
                            <th class="text-left">D</th>
                            <th class="text-left">E</th>
                            <th class="text-left">F</th>
                        </tr>
                    </thead>
                    <tbody class="">
                        <tr v-for="(grade, gradeKey) in grades" :grade_id="grade.id" class="ant-table-row">
                            <td class="ant-table-cell text-left">{{ grade.tag }}</td>
                            <template v-for="klass in grade.klasses">
                                <td class="ant-table-cell text-left">
                                    <template v-if="klass.grade_year <= 3">
                                        <a-button as="link" :href="route('director.pre.klasses.show', klass.id)" class="ant-btn">{{ klass.tag }}</a-button>
                                        {{ klass.student_count }}
                                    </template>
                                    <template v-else>

                                        {{ klass.student_count }}
                                    </template>
                                </td>
                            </template>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div> -->
</AdminLayout>
</template>

<script>
import AdminLayout from "@/Layouts/AdminLayout.vue";
import {
    TeamOutlined,
    ArrowRightOutlined
} from "@ant-design/icons-vue";
import ButtonLink from "@/Components/ButtonLink.vue";

export default {
    components: {
        AdminLayout,
        TeamOutlined,
        ButtonLink,
        ArrowRightOutlined,
    },
    props: ["year", "grades"],
    data() {
        return {
            breadcrumb: [{
                    label: "主控台",
                    url: route("director.dashboard")
                },
                {
                    label: "年級",
                    url: null
                },
            ],

            // activeKey:'grade',
            //courses:[],
            //students:[],
            // selectedKlass:{
            //     tag:"--"
            // }
        };
    },
    mounted() {
        // const urlParams=new URLSearchParams(window.location.search);
        // const klassId=urlParams.get('kid');
        // this.grades.map(grade=>{
        //     grade.klasses.map(klass=>{
        //         if(klass.id==klassId){
        //             this.selectKlass(klass,'course')
        //         }
        //     });
        // });
    },

    methods: {

        // selectKlass(klass,activeKey){
        //     this.selectedKlass=klass;
        //     axios.get('/director/students/get_by_klass_id/'+klass.id)
        //         .then(response=>{
        //             this.students = response.data;
        //             //this.courses = [];
        //         });
        //     this.selectCourse(klass);
        //     this.activeKey=activeKey;
        //     //this.activeKey='student';
        // },
        // selectCourse(klass){
        //     this.selectedKlass=klass;
        //     axios.get('/director/courses/get_by_klass_id/'+klass.id)
        //         .then(response=>{
        //             this.courses = response.data;
        //             console.log(this.courses);
        //             //console.log(reponse.data);
        //             //this.students = [];
        //         });
        // }
    },
    computed: {
        viewGrades() {
            let grades = this.grades;
            grades.forEach(g => {
                g.klasses = Object.fromEntries(g.klasses.map(k => [k.letter, k]))
            })
            return grades
        }
    },
};
</script>
