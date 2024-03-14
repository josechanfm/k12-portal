<template>
  <AdminLayout title="生活習慣和態度" :breadcrumb="breadcrumb">
    <a-typography-title :level="3">班別:{{ klass.tag }}</a-typography-title>
    <a-typography-title :level="3"
      >專業方向:{{ klass.stream }}</a-typography-title
    >
    <div class="flex gap-5">
      <a-form ref="importlRef" >
          <input type="file" name="importFile" id="import-file" hidden @change="onImport" />
          <label for="import-file" class="ant-btn ant-btn-primary mr-5">
            匯入
          </label>
      </a-form>
      <a :href="route('manage.pre.klass.habit.export', {klass: klass.id,term_id: selectedTermId,})" class="ant-btn ant-btn-primary">
        <DownloadOutlined /> 滙出
      </a>
    </div>
    <div class="py-5">
      <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
        <a-button type="primary" @click="saveScores">更新並保存</a-button>
        <a-button
          v-for="term in yearTerms"
          @click="selectedTermId = term.value"
          class="ml-4"
          :type="selectedTermId == term.value ? 'primary' : ''"
          >{{ term.label }}</a-button
        >
        <a-button @click="sampleData()">Sample Data</a-button>
        <p></p>
        <table id="scoreTable" ref="scoreTable">
          <tr>
            <th style="width: 100px" rowspan="2" class="crossed">
              <span class="float-right">評分</span><br />
              <span class="float-left">學生姓名</span>
            </th>
            <th colspan="5">個人衛生</th>
            <th colspan="6">行為習慣</th>
            <th colspan="5">社交態度</th>
          </tr>
          <tr>
            <th v-for="column in habitColumns">
              <a-tooltip>
                <template #title>{{ column.label }}</template>
                {{ column.short }}
              </a-tooltip>
            </th>
          </tr>
          <tr v-for="(student, ksid) in habits['students']">
            <td>{{ student.name_zh }}</td>
            <td v-for="column in habitColumns">
              <a-input
                v-model:value="
                  habits['scores'][ksid][selectedTermId][column.name]
                "
              />
            </td>
          </tr>
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
  props: ["klass", "yearTerms", "habitColumns", "habits"],
  data() {
    return {
      breadcrumb: [
        { label: "Manage", url: route("manage") },
        {
          label: "小學",
          url: route("manage.grades.index", { type: "primary" }),
        },
        {
          label: this.klass.tag + "班",
          url: route("manage.pre.klasses.show", this.klass.id),
        },
        { label: "生活習慣和態度", url: null },
      ],
      keypressed: "",
      tableCell: {
        row: 0,
        col: 0,
        maxRow: this.klass.students.length,
        maxCol: this.habitColumns.length,
      },
      selectedTermId: 1,
      scores: {},
    };
  },
  created() {
  },
  mounted() {
    this.$refs.scoreTable.addEventListener("keydown", (e) => {
      switch (e.key) {
        case "ArrowUp":
          this.tableCell.row > 1 ? this.tableCell.row-- : "";
          break;
        case "ArrowDown":
          this.tableCell.row < this.tableCell.maxRow
            ? this.tableCell.row++
            : "";
          break;
        case "ArrowLeft":
          this.tableCell.col > 1 ? this.tableCell.col-- : "";
          break;
        case "ArrowRight":
          this.tableCell.col < this.tableCell.maxCol
            ? this.tableCell.col++
            : "";
          break;
      }
      var input =
        this.$refs.scoreTable.rows[this.tableCell.row].cells[
          this.tableCell.col
        ].getElementsByTagName("input");
      //console.log(input);
      if (input.length > 0) {
        //input[0].focus();
        input[0].select();
      }
    });
    const inputs = this.$refs.scoreTable.getElementsByTagName("input");
    for (var i = 0; i < inputs.length; i++) {
      inputs[i].addEventListener("focus", (e) => {
        this.tableCell.row = e.target.closest("tr").rowIndex;
        this.tableCell.col = e.target.closest("td").cellIndex;
      });
    }
  },
  methods: {
    onKeypressed(event) {
      this.keypressed = event.keyCode;
    },
    saveScores() {
      var data = [];
      // Object.entries(this.scores).forEach(([klass_student_id,term])=>{
      //     Object.entries(term).forEach(([term_id,habits])=>{
      //         if(term_id==this.selectedTermId){
      //             data.push(habits)
      //         }
      //     })
      // })
      Object.values(this.habits.scores).forEach((std) => {
        Object.entries(std).forEach(([termId, scores]) => {
          if (termId == this.selectedTermId) {
            delete scores["created_at"];
            delete scores["updated_at"];
            data.push(scores);
          }
        });
      });
      // console.log(data);
      // return true;
      this.$inertia.put(
        route("manage.pre.klass.habits.update", this.klass.id),
        data,
        {
          onSuccess: (page) => {
            console.log(page);
          },
          onError: (error) => {
            console.log(error);
          },
        }
      );
    },
    onFocusInput(event) {
      this.tableCell.row = event.target.closest("tr").rowIndex;
      this.tableCell.col = event.target.closest("td").cellIndex;
    },
    onImport(e){
        this.$inertia.post(route('manage.pre.klass.habit.import',this.klass.id),{'importFile':e.target.files[0]},{
            onSuccess:(page)=>{
                console.log("import response");
                console.log(page);
            },
            onError:(err)=>{
                console.log(err);
            }
        })
    },
    sampleData(){
      const letter='ABCDFGH';
      Object.entries(this.habits['scores']).forEach(([i,std])=>{
        Object.entries(std).forEach(([j,term])=>{
          this.habitColumns.forEach(column=>{
            var num=Math.floor(Math.random() * 4)
            term[column.name]=letter.substring(num,num+1);
          })
        })
      })
    }
  },
};
</script>


<style>
#scoreTable,
#scoreTable td,
#scoreTable th {
  border: 1px solid;
  border-color: gray;
}

#scoreTable {
  width: 100%;
  border-collapse: collapse;
}
table td.crossed,
table th.crossed {
  background-image: linear-gradient(
    to top right,
    transparent calc(50% - 0.5px),
    black,
    transparent calc(50% + 1px)
  );
}
#scoreTable input {
  text-transform: uppercase;
  text-align: center;
}
</style>

