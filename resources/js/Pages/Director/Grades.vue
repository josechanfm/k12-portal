<template>
    <AdminLayout title="年級班別" :breadcrumb="breadcrumb">

        <div class="flex flex-wrap font-bold text-sm gap-1">
            <div class="flex bg-gray-300 rounded-lg p-1 px-2 items-center gap-1">
                <div class="text-gray-600 font-black rounded-l-lg bg-gray-100  p-1 ">學年代號</div>
                <div class=" ">{{ year.code }}</div>
            </div>
            <div class="flex bg-gray-300 rounded-lg p-1 items-center gap-1">
                <div class="text-gray-600 font-black rounded-l-lg bg-gray-100  p-1 ">學年全稱</div>
                <div class=" ">{{ year.title }}</div>
            </div>
            <div class="flex bg-gray-300 rounded-lg p-1 items-center gap-1 ">
                <div class="text-gray-600 font-black rounded-l-lg bg-gray-100  p-1 ">日期</div>
                <div>{{ year.start }}</div>
               <ArrowRightOutlined/>
                <div>{{ year.end }}</div>
            </div>
        </div>

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
                                            <inertia-link :href="route('director.pre.klasses.show', klass.id)"
                                                class="ant-btn">{{klass.tag}}</inertia-link>
                                            {{ klass.student_count }}
                                        </template>
                                        <template v-else>
                                            <inertia-link :href="route('director.klasses.show', klass.id)"
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
import { TeamOutlined ,ArrowRightOutlined } from '@ant-design/icons-vue';
import ButtonLink from '@/Components/ButtonLink.vue';


export default {
    components: {
        AdminLayout, TeamOutlined, ButtonLink,ArrowRightOutlined
    },
    props: ['year', 'grades'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台" ,url:route('director.dashboard')},
                {label:"年級" ,url:null},
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
}
</script>

