<template>
    <AdminLayout title="年級班別" :breadcrumb="breadcrumb">
        <a-typography-title :level="4">學年代號: {{ year.code }}</a-typography-title>
        <a-typography-title :level="4">學年全稱: {{ year.title }}</a-typography-title>
        <a-typography-title :level="4">學年開始: {{ year.start }}</a-typography-title>
        <a-typography-title :level="4">學年結束: {{ year.end }}</a-typography-title>


        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="ant-table-thead">
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
                        <tbody class="ant-table-tbody">
                            <tr v-for="(grade, gradeKey) in grades" :grade_id="grade.id">
                                <td class="text-left">{{ grade.tag }}</td>
                                <template v-for="klass in grade.klasses">
                                    <td class="text-left">
                                        <template v-if="klass.grade_year <=3">
                                            <inertia-link :href="route('manage.pre.klasses.show', klass.id)"
                                                class="ant-btn">{{klass.tag}}</inertia-link>
                                            {{ klass.student_count }}
                                        </template>
                                        <template v-else>
                                            <inertia-link :href="route('manage.klasses.show', klass.id)"
                                                class="ant-btn">{{klass.tag}}</inertia-link>
                                            {{ klass.student_count }}
                                        </template>
                                    </td>
                                </template>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <a-divider/>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { TeamOutlined } from '@ant-design/icons-vue';
import ButtonLink from '@/Components/ButtonLink.vue';


export default {
    components: {
        AdminLayout, TeamOutlined, ButtonLink
    },
    props: ['year', 'grades'],
    data() {
        return {
            breadcrumb:[
                {label:"Manage" ,url:route('manage')},
                {label:"Grades" ,url:null},
            ],

            // activeKey:'grade',
            //courses:[],
            //students:[],
            // selectedKlass:{
            //     tag:"--"
            // }
        }
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
        //     axios.get('/manage/students/get_by_klass_id/'+klass.id)
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
        //     axios.get('/manage/courses/get_by_klass_id/'+klass.id)
        //         .then(response=>{
        //             this.courses = response.data;
        //             console.log(this.courses);
        //             //console.log(reponse.data);
        //             //this.students = [];
        //         });
        // }
    },
}
</script>

