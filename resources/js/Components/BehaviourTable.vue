<template>
  <div class="ant-table">
    <div class="ant-table-container">
      <div class="ant-table-content">
        <table style="table-layout: auto" ref="behaviourTable">
          <thead class="ant-table-thead">
            <tr>
              <th>學生編號</th>
              <th>學生姓名</th>
              <template v-for="term in yearTerms">
                <th>{{ term.label }}操行分</th>
              </template>
            </tr>
          </thead>
          <tbody class="ant-table-tbody">
            <tr v-for="(student, ksid) in behaviours['students']">
              <td>{{ student.pivot.student_number}}</td>
              <td>
                {{ student.name_zh }}
              </td>
              <template v-for="term in yearTerms">
                <td>
                  <template v-if="term.value == currentTermId">
                    {{ behaviours['scores'][ksid][term.value] }}
                    <a-input-number
                      v-model:value="behaviours['scores'][ksid][term.value]['score']"
                      :min="0"
                      :max="100"
                      @focus="onFocusScoreInput(behaviours['scores'][ksid][term.value])"
                      @blur="onBlurScoreInput(behaviours['scores'][ksid][term.value])"
                    />
                  </template>
                  
                  <template v-else>
                    {{ behaviours['scores'][ksid][term.value]['score'] }}
                    <!-- {{ getBehaviourScore(student.behaviours, term.value) }} -->
                  </template>
                </td>
              </template>
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
      console.log('onBlurScoreInput2  ')
      if (this.temp.score === temp.score) {
        console.log("same");  
        return false;
      } else {
        axios
          .post(
            route("teacher.course.behaviours.store", temp.reference_id),
            temp
          )
          .then((resp) => console.log(resp.data));
      }
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
  },
};
</script>

