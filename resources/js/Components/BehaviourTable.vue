<template>
  <div class="ant-table">
    <div class="ant-table-container">
      <div class="ant-table-content">
        <div v-role="['director']">
          is director
        </div>
        <table style="table-layout: auto" ref="behaviourTable" border="1">
          <thead class="ant-table-thead">
            <tr>
              <th>學生編號</th>
              <th>學生姓名</th>
              <template v-for="term in yearTerms">
                <th>{{ term.label }}操行分</th>
              </template>
              <th>全年總分</th>
              <th v-role="['master','admin','director']">Control</th>
            </tr>
          </thead>
          <tbody class="ant-table-tbody">
            <tr v-for="(student, ksid) in behaviours['students']">
              <td>{{ student.pivot.student_number}}</td>
              <td>
                {{ student.name_zh }}
              </td>
              <template v-for="term in yearTerms">
                <td width="200px">
                  <template v-if="term.value == currentTermId">
                    <a-input-number
                      v-model:value="behaviours['scores'][ksid][term.value]['staff'].score"
                      :min="0"
                      :max="100"
                      style="width:50px"
                      @focus="onFocusScoreInput(behaviours['scores'][ksid][term.value]['staff'])"
                      @blur="onBlurScoreInput(behaviours['scores'][ksid][term.value]['staff'])"
                    />
                  </template>
                  <template v-else>
                    <div>{{ behaviours['scores'][ksid][term.value]['staff'].score }}</div>
                    <!-- {{ getBehaviourScore(student.behaviours, term.value) }} -->
                  </template>
                  <template v-if="behaviours['scores'][ksid][term.value]['total']>0">
                    / {{ behaviours['scores'][ksid][term.value]['total'] }}
                  </template>
                  <!-- Adjust behaviour score -->
                  <template v-if="term.value == currentTermId">
                    <a-input-number
                      v-model:value="behaviours['scores'][ksid][term.value]['adjust'].score"
                      :min="0"
                      :max="100"
                      style="width:50px"
                      @blur="onBlurAdjustInput(behaviours['scores'][ksid][term.value]['adjust'])"
                    >
                    </a-input-number>
                  </template>
                </td>
              </template>
              <td>
                {{ sumYearTotal(behaviours['scores'][ksid]) }}
              </td>
              <td v-role="['master','admin','director']">
                control
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  components: {},
  props: ["yearTerms", "currentTermId", "behaviours"],
  data() {
    return {
      tempBehaviour: null,
      temp:null,
    };
  },
  mounted() {},
  methods: {
    onFocusScoreInput(temp) {
      this.temp = { ...temp };
    },
    onBlurScoreInput(temp) {
      if (this.temp.score === temp.score) {
        return false;
      } else {
        console.log(temp)
        axios.post(
          route("teacher.behaviours.store", temp),
          temp
        ).then((resp) =>{
          console.log(resp.data)
        });
      }
    },
    onBlurAdjustInput(score){
      console.log(score)
      axios.post(route("teacher.behaviours.store"),score)
      .then((resp) =>{
        console.log(resp.data)
      });
    },
    getBehaviourScore(behaviours, termId) {
      //var behaviour=behaviours.find(b=>b.term_id==termId)
      var behaviour = behaviours[termId];
      if (behaviour) {
        return behaviour.score;
      } else {
        return null;
      }
    },
    sumYearTotal(scores){
      let sum=0;
      Object.values(scores).forEach(s=>{
        sum+=parseInt(s.total)
      }) 
      return sum
    }
  },
};
</script>

