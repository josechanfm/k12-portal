<script>
export default {
  props: ['stream'],
  data(){
    return {
      studyStream:{"ART":"文科","SCI":"理科"},
    }
  },
  created(){
  }
}
</script>

<template>
  <button v-show="(stream=='ART')" class="bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded">
    {{studyStream[stream]}}
  </button>
  <button v-show="(stream=='SCI')" class="bg-transparent hover:bg-green-500 text-green-700 font-semibold hover:text-white py-2 px-4 border border-green-500 hover:border-transparent rounded">
    {{studyStream[stream]}}
  </button>
</template>