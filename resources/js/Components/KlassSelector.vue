<template>
    {{ param }}
    <p>Klass Selector</p>
    {{ routePath }}
        <a-radio-group v-model:value="selectedGradeId" button-style="solid">
            <a-radio-button v-for="grade in currentYear.grades" :value="grade.id">{{grade.tag}}</a-radio-button>
        </a-radio-group>
        <p></p>
        <a-radio-group v-model:value="selectedKlassId" button-style="solid">
            <template v-for="klass in currentYear.klasses">
                <a-radio-button v-if="klass.grade_id==selectedGradeId" :value="klass.id">
                    <inertia-link :href="route(route, param)">{{klass.tag}}</inertia-link>
                </a-radio-button>
            </template>
        </a-radio-group>
        <hr>

</template>

<script>
export default {
  components: {},
  props: ['routePath','param'],
  data() {
    return {
        selectedGradeId:0,
        selectedKlassId:0,
        currentYear:{},
        defaultGrade:{}
    };
  },
  mounted() {
    axios.get(route('gradesKlasses'))
        .then(resp=> {
            console.log(resp.data);
                this.currentYear=resp.data.current_year
                this.defaultGrade=resp.data.default_grade
                this.selectedGradeId=this.defaultGrade.id
                this.selectedKlassId=this.defaultGrade.klasses[0].id
                console.log(this.currentYear)
            }
        );
  },
  methods: {
  },
};
</script>

