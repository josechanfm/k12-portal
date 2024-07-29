<template>
  <AdminLayout title="年級班別" :breadcrumb="breadcrumb">
    <div class="flex flex-wrap font-bold text-sm gap-1">
      <div class="flex bg-gray-300 rounded-lg p-1 px-2 items-center gap-1">
        <div class="text-gray-600 font-black rounded-l-lg bg-gray-100 p-1">
          學年代號
        </div>
        <div class=" ">{{ year.code }}</div>
      </div>
      <div class="flex bg-gray-300 rounded-lg p-1 items-center gap-1">
        <div class="text-gray-600 font-black rounded-l-lg bg-gray-100 p-1">
          學年全稱
        </div>
        <div class=" ">{{ year.title }}</div>
      </div>
      <div class="flex bg-gray-300 rounded-lg p-1 items-center gap-1">
        <div class="text-gray-600 font-black rounded-l-lg bg-gray-100 p-1">
          日期
        </div>
        <div>{{ year.start }}</div>
        <ArrowRightOutlined />
        <div>{{ year.end }}</div>
      </div>
    </div>
    <a-table :dataSource="viewGrades" class="">
        <a-table-column title="年級">
            <template #default="{record}">
                {{ record.tag}}
            </template>
        </a-table-column>
        <template v-for="aph in 'abcdefghi'.toUpperCase().split('')" :key="aph">
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
    findKclass(record,aph){
       return record.klasses.find(x=>x.letter==aph)??false
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
    }
    },

};
</script>

