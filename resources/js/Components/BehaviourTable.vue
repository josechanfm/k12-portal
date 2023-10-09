<template>
  <div class="ant-table">
    <div class="ant-table-container">
      <div class="ant-table-content">
        <table style="table-layout: auto">
          <thead class="ant-table-thead">
            <tr>
              <th>學生姓名</th>
              <template v-for="term in yearTerms">
                <th>{{ term.label }}操行分</th>
              </template>
            </tr>
          </thead>

          <tbody class="ant-table-tbody">
            <tr v-for="student in behaviours">
              <td>
                {{ student.name_zh }}
              </td>
              <template v-for="term in yearTerms">
                <td>
                  <template v-if="term.value == currentTerm.value">
                    <a-input-number
                      v-model:value="student.behaviours[term.value].score"
                      :min="0"
                      :max="100"
                      @blur="onBlurScoreInput(student.behaviours[term.value])"
                      @focus="onFocusScoreInput(student.behaviours[term.value])"
                    />
                  </template>
                  <template v-else>
                    {{ getBehaviourScore(student.behaviours, term.value) }}
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
  props: ["yearTerms", "currentTerm", "behaviours"],
  data() {
    return {
      tempBehaviour: null,
    };
  },
  mounted() {},
  methods: {
    onFocusScoreInput(behaviour) {
      this.tempBehaviour = { ...behaviour };
    },
    onBlurScoreInput(behaviour) {
      console.log(behaviour);
      if (this.tempBehaviour.score === behaviour.score) {
        console.log("same");
        return false;
      } else {
        console.log(behaviour);
        axios
          .post(
            route("teacher.course.behaviours.store", behaviour.reference_id),
            behaviour
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

