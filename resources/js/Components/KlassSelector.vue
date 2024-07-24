<template>
    <a-radio-group v-model:value="selectedGradeId" button-style="solid" @change="onGradeChange">
        <a-radio-button v-for="grade in currentYear.grades" :value="grade.id">{{grade.tag}}</a-radio-button>
    </a-radio-group>
    <p></p>
    <a-radio-group v-model:value="selectedKlassId" button-style="solid">
        <template v-for="klass in currentYear.klasses">
            <a-radio-button v-if="klass.grade_id==selectedGradeId" :value="klass.id">
                <a-button :href="route(routePath, [klass.id,routeParam])">{{klass.tag}}</a-button>
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
        klass:{},
        routeParam:null,
    };
  },
  mounted() {
    if(this.$emit.onChangeTerm){
        console.log('with emit');
    }
    if(this.param!=null){
        this.routeParam=this.param;
    }
    
    axios.get(route('api.gradesKlasses'))
        .then(resp=> {
                this.currentYear=resp.data.current_year
                if(this.currentKlass==null){
                    this.klass=this.currentYear.klasses.find(klass=>klass.grade_year>3);
                }else{
                    this.klass=this.currentKlass;
                }
                
                this.selectedKlassId=this.klass.id
                this.selectedGradeId=this.klass.grade_id
            }
        );
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

