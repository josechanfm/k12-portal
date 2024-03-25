<template>
  <AdminLayout title="生活習慣和態度" :breadcrumb="breadcrumb">
    <a-typography-title :level="3">班別:{{ klass.tag }}</a-typography-title>
    <div class="flex gap-5 justify-end ">
        <a-button type="primary" @click="importConfirmed()">確定滙入</a-button>
    </div>
    <p>主題: {{ theme.title }}</p>
    <div class="py-5">
      <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
        <table class="dataTable">
            <thead>
                <tr>
                    <td v-for="column in tableHeaders">{{column}}</td>
                </tr>
            </thead>
            <tbody>
                <tr v-for="record in importData">
                    <td v-for="column in record">{{column}}</td>
                </tr>
            </tbody>
        </table>
      </div>
    </div>
  </AdminLayout>
</template>

<script>
import AdminLayout from "@/Layouts/AdminLayout.vue";
import { DownloadOutlined } from "@ant-design/icons-vue";

export default {
  components: {
    AdminLayout,
    DownloadOutlined,
  },
  props: ["klass","theme","importData","columnHeader"],
  data() {
    return {
      breadcrumb: [
        { label: "Director", url: route('director.dashboard') },
        {
          label: "小學",
          url: route("director.grades.index", { type: "primary" }),
        },
        {
          label: this.klass.tag + "班",
          url: route("director.pre.klasses.show", this.klass.id),
        },
        { label: "生活習慣和態度", url: null },
      ],
      tableHeaders: [],

    };
  },
  created() {
    this.tableHeaders=this.importData[0];
    console.log(this.importData);
    console.log(delete this.importData[0]);
  },
  mounted() {
  },
  methods: {
    importConfirmed(){
        console.log(this.importData);
        this.$inertia.post(route('director.pre.klass.ability.importConfirmed',this.klass.id),{
          'themeId':this.theme.id,
          importData:this.importData,
        },{
            onSuccess:(page)=>{
                console.log("import response");
                console.log(page);
            },
            onError:(err)=>{
                console.log(err);
            }
        })

    }
  },
};
</script>


<style>
.dataTable {
    width: 100%;
    border-collapse: collapse;
}

.dataTable, .dataTable td, .dataTable th {
    border: 1px solid;
}
</style>

