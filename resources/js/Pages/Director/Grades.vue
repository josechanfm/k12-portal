<template>
  <AdminLayout title="年級班別" :breadcrumb="breadcrumb">
    <div class="p-2 bg-white rounded-lg flex flex-col gap-1">
    <div class="flex flex-wrap font-bold text-sm gap-1">
      <div class=" capsule-outline ">
        <div class=" capsule-label ">
          學年代號
        </div>
        <div class=" ">{{ year.code }}</div>
      </div>
      <div class="capsule-outline">
        <div class=" capsule-label ">
          學年全稱
        </div>
        <div class=" ">{{ year.title }}</div>
      </div>
      <div class="capsule-outline">
        <div class=" capsule-label ">
          日期
        </div>
        <div>{{ year.start }}</div>
        <ArrowRightOutlined />
        <div>{{ year.end }}</div>
      </div>
    </div>
  
    <div class="rounded-lg border-gray-200 border p-2">
    <a-table :dataSource="viewGrades" :pagination="false"  bordered>
      <template #headerCell="{column}">
        <div class="flex itmes-center justify-center">{{ column.title }}</div>
      </template>
        <a-table-column title="年級" align="center" >
            <template #default="{record}">
                <div class="font-black">{{ record.tag}}</div>
            </template>
        </a-table-column>
        <template v-for="aph in letters" :key="aph">
            <a-table-column :title="'Class-'+aph" align="center">
                <template #default="{record}">
                    <div v-if="record.klasses[aph]">
                        <a-button as="link"  type="text" class="hover-scale"
                          :href="route(routeName(record.grade_year),record.klasses[aph].id)" >
                            <div class="flex  gap-1 items-center">
                                <div  class="font-bold text-lg !text-blue-500 underline">{{ record.klasses[aph].tag }}</div>
                                <a-tag class="font-bold"> {{ record.klasses[aph].student_count}} 人</a-tag>
                            </div>
                        </a-button>
                    </div>
                </template>
            </a-table-column>
        </template>
    </a-table>
  </div>
</div>
    <a-divider />
  </AdminLayout>
</template>

<script>
import AdminLayout from "@/Layouts/AdminLayout.vue";
import { TeamOutlined, ArrowRightOutlined } from "@ant-design/icons-vue";
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
      breadcrumb: [
        { label: "主控台", url: route("director.dashboard") },
        { label: "年級", url: null },
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
    routeName(grade_year){
      return grade_year<=3?'director.pre.klasses.show':'director.klasses.show'
    }
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
        let grades = JSON.parse(JSON.stringify( this.grades) );
        grades.forEach(g => {
            g.klasses = Object.fromEntries((g?.klasses??[]).map(k => [k.letter, k]))
        })
        return grades
    },
    letters(){
      return Object.assign([],...this.grades.map(x=>x.klasses.map(k=>k.letter)))
    },
    },

};
</script>

