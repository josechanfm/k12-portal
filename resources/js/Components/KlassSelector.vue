<template>
    <a-radio-group v-model:value="selectedGradeId" button-style="solid" @change="onGradeChange">
        <a-radio-button v-for="grade in currentYear.grades" :value="grade.id">{{grade.tag}}</a-radio-button>
    </a-radio-group>
    <p></p>
    <a-radio-group v-model:value="selectedKlassId" button-style="solid">
        <template v-for="klass in currentYear.klasses">
            <a-radio-button v-if="klass.grade_id==selectedGradeId" :value="klass.id">
                <inertia-link :href="route(routePath, [klass.id,param])">{{klass.tag}}</inertia-link>
            </a-radio-button>
        </template>
    </a-radio-group>
    <template v-if="showTerms">
        <a-divider type="vertical" />
        <a-radio-group v-model:value="selectedTermId" button-style="solid" v-on:change="$emit('changeTerm',selectedTermId)">
            <template v-for="term in currentYear.yearTerms">
                <a-radio-button :value="term.value">{{term.label}}</a-radio-button>
            </template>
        </a-radio-group>
    </template>
</template>

<script>
export default {
  components: {},
  //param: extra route param
  //showTerms: true:show terms selection 
  props: ['routePath','param','currentKlass','showTerms'],
  emits: ['changeTerm'],
  data() {
    return {
        selectedTermId:1,
        selectedGradeId:0,
        selectedKlassId:0,
        currentYear:{},
    };
  },
  mounted() {
    axios.get(route('gradesKlasses'))
        .then(resp=> {
                this.currentYear=resp.data.current_year
            }
        );
    this.selectedKlassId=this.currentKlass.id
    this.selectedGradeId=this.currentKlass.grade_id
  },
  methods: {
    onGradeChange(){
        var klass=this.currentYear.klasses.find(k=>
            k.grade_id==this.selectedGradeId
        )
        this.selectedKlassId=klass.id
    },
  },
};
</script>

