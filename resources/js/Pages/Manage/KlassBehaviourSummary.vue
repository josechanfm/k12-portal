<template>
  <AdminLayout title="Dashboard">
    <template #header>
      <h2 class="font-semibold text-xl text-gray-800 leading-tight">操作</h2>
    </template>
    <div>
      <a-radio-group v-model:value="selectedGradeId" button-style="solid">
        <a-radio-button v-for="grade in year.grades" :value="grade.id">
            {{grade.tag}}
        </a-radio-button>
      </a-radio-group>
      <p></p>
      <a-radio-group v-model:value="selectedKlassId" button-style="solid">
        <template v-for="klass in year.klasses">
          <a-radio-button v-if="klass.grade_id == selectedGradeId" :value="klass.id">
            <inertia-link :href="route('manage.klass.behaviours.summary', klass.id)">
              {{ klass.tag }}
            </inertia-link>
          </a-radio-button>
        </template>
      </a-radio-group>

      <a-divider type="vertical"/>

      <a-radio-group v-model:value="selectedTermId" button-style="solid">
        <template v-for="term in yearTerms">
            <a-radio-button :value="term.value">{{term.label}}</a-radio-button>
        </template>
      </a-radio-group>

      <a-typography-title :level="4">{{ staff.name_zh }}</a-typography-title>
      <div v-if="course">
        <p>{{ course.klass.tag }}</p>
        <p>{{ course.code }}-{{ course.title_zh }}</p>
      </div>
      <div v-else-if="klass">
        <p>{{ klass.tag }}</p>
      </div>

      <div class="ant-table">
        <div class="ant-table-container">
          <div class="ant-table-content">
            <table style="table-layout: auto" id="dataTable" ref="dataTable">
              <thead class="ant-table-thead">
                <tr>
                  <th>Student Name</th>
                  <th>班主任</th>
                  <th>訓導</th>
                  <th>調整</th>
                  <th>加總</th>
                  <th v-for="c in klass.courses">
                    {{ c.code }}-{{ c.title_zh }}
                  </th>
                </tr>
              </thead>
              <tr v-for="student in behaviours">
                <td width="200px">{{ student.name_zh }}</td>
                <td class="text-center">
                    <span v-if="student.klassHeads[selectedTermId]">
                        {{ student.klassHeads[selectedTermId].score_total }}
                    </span>
                </td>
                <td width="80px">
                    <span v-if="student.director[selectedTermId]">
                        <a-input 
                            v-model:value="student.director[selectedTermId].score"
                            @blur="onBlurScoreInput(student.director[selectedTermId])"
                            @focus="onFocusScoreInput(student.director[selectedTermId])"
                            @keyup.arrow-keys="onKeypressed"
                             class="text-center"
                        />
                        {{ student.director[selectedTermId].score_total }}
                    </span>
                </td>
                <td width="80px">
                    <span v-if="student.adjust[selectedTermId]">
                        <a-input 
                            v-model:value="student.adjust[selectedTermId].score"
                            @blur="onBlurScoreInput(student.adjust[selectedTermId])"
                            @focus="onFocusScoreInput(student.adjust[selectedTermId])"
                            @keyup.arrow-keys="onKeypressed"
                            class="text-center"
                        />
                    </span>
                </td>
                <td class="text-center">
                  {{getScoreTotal(student)}}
                </td>
                <td v-for="c in klass.courses" class="text-center">
                    <span v-if="student.courseTeachers[c.id][selectedTermId]">
                      {{ student.courseTeachers[c.id][selectedTermId].score_total }}
                    </span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<script>
import AdminLayout from "@/Layouts/AdminLayout.vue";
import BehaviourTable from "@/Components/BehaviourTable.vue";

export default {
  components: {
    AdminLayout,
    BehaviourTable,
  },
  props: [
    "year",
    "yearTerms",
    "currentTerm",
    "staff",
    "course",
    "klass",
    "behaviours",
  ],
  data() {
    return {
      tempBehaviour: null,
      selectedGradeId: 0,
      selectedKlassId: 0,
      selectedTermId:0,
      keypressed: "",
      tableCell: {
          row: 0,
          col: 0,
          maxRow: this.behaviours.length,
          maxCol: 2
      },
    };
  },
  mounted() {
    this.selectedGradeId = this.klass.grade_id;
    this.selectedKlassId = this.klass.id;
    this.selectedTermId = this.currentTerm.value;
        //add Click EventListenter to dataTable
        this.$refs.dataTable.addEventListener('click', (e) => {
            this.tableCell.row = e.target.closest('tr').rowIndex;
            this.tableCell.col = e.target.closest('td').cellIndex;
        })
        //add KeyDown (ArrowKeys) EventListenter to dataTable
        this.$refs.dataTable.addEventListener('keydown', (e) => {
            switch (e.key) {
                case 'ArrowUp':
                    this.tableCell.row > 1 ? this.tableCell.row-- : '';
                    break;
                case 'ArrowDown':
                    this.tableCell.row < (this.$refs.dataTable.rows.length - 1) ? this.tableCell.row++ : '';
                    //this.tableCell.row<this.tableCell.maxRow?this.tableCell.row++:'';
                    break;
                case 'ArrowLeft':
                    this.tableCell.col > 1 ? this.tableCell.col-- : '';
                    break;
                case 'ArrowRight':
                    this.tableCell.col < (this.$refs.dataTable.rows[0].cells.length - 1) ? this.tableCell.col++ : '';
                    break;
            }
            var input = this.$refs.dataTable.rows[this.tableCell.row].cells[this.tableCell.col].getElementsByTagName("input");
            if (input.length > 0) {
                input[0].focus();
            }
        })
        //onclick of input box, calebrate the row, col values
        //only apply for multiple table in the same page
        const inputs = this.$refs.dataTable.getElementsByTagName("input");
        for (var i = 0; i < inputs.length; i++) {
            inputs[i].addEventListener("focus", (e) => {
                this.tableCell.row = e.target.closest('tr').rowIndex;
                this.tableCell.col = e.target.closest('td').cellIndex;
            })
        }

  },
  methods: {
    onKeypressed(event) {
        this.keypressed = event.keyCode;
    },
    onFocusScoreInput(behaviour) {
      this.tempBehaviour = { ...behaviour };
    },
    onBlurScoreInput(behaviour) {
      if (this.tempBehaviour.score === behaviour.score) { return false }
      axios.post(route("teacher.course.behaviours.store", behaviour.reference_id),behaviour)
           .then((resp) => console.log(resp.data) );
    },
    getScoreTotal(student) {
      var courseScore=0;
      var headScore=0;
      var directScore=;
      Object.values(student.courseTeachers).forEach(s=>{
        if(s[this.selectedTermId]){
          courseScore+=eval(s[this.selectedTermId].score_total);
        }
      })
      courseScore=(courseScore /Object.keys(student.courseTeachers).length) *this.klass.grade.behaviour_scheme['SUBJECT']
      if(student.klassHeads[this.selectedTermId]){
        headScore=student.klassHeads[this.selectedTermId].score_total
      }
      
      console.log(student.klassHeads[this.selectedTermId])
      sum=courseScore
      return sum
    }
  }
};
</script>

