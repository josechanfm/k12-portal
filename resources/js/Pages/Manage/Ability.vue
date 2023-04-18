<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Year: {{ klass.year_code }}
            </h2>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Class: {{ klass.tag }}
            </h2>
        </template>
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-button type="primary" @click="saveAbilities">更新並保存</a-button>
                    <a-button v-for="term in terms" @click="selectedTerm=term.value" class="ml-4" :type="selectedTerm==term.value?'primary':''">{{term.label}}</a-button>
                    <table id="topicTable" ref="topicTable">
                        <tr>
                            <th width="100px">學生姓名</th>
                            <td v-for="topic in topics">
                                <a-tooltip>
                                    <template #title>{{ topic.title_zh }}</template>
                                    {{ topic.abbr_zh }} 
                                </a-tooltip>
                            </td>
                        </tr>
                        <template v-for="(ability, key) in abilities">
                            <tr>
                                <td>{{ ability.student_name }}</td>
                                <td v-for="topic in topics">
                                    <a-input v-model:value="ability['ability_'+key+'_'+topic.id]" 
                                        @keyup.arrow-keys="onKeypressed" 
                                    />
                                </td>
                            </tr>
                        </template>
                    </table>
                </div>
            </div>
        </div>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['terms','klass', 'topics','students_abilities'],
    data() {
        return {
            keypressed:"",
            selectedTerm:1,
            abilities:{},
            tableCell:{
                row:0,
                col:0,
                maxRow:this.students_abilities.length,
                maxCol:this.topics.length
            },
        }
    },
    created(){
        this.students_abilities.forEach(student=>{
            var ability={};
            ability['student_name'] = student.name_zh;
            this.topics.forEach(topic=>{
                ability['ability_'+student.pivot.klass_student_id+'_'+topic.id]='';
            })
            this.abilities[student.pivot.student_id]=ability;
        })
        this.students_abilities.forEach(student=>{
            student.abilities.forEach(ability => {
                //console.log(ability);
                this.abilities[student.pivot.student_id]['ability_'+student.pivot.klass_student_id+'_'+ability.topic.id]=ability.credit;
            })
        })
    },
    mounted() {
        this.$refs.topicTable.addEventListener('keydown', (e) => {
            switch(e.key){
                case 'ArrowUp': 
                    this.tableCell.row>1?this.tableCell.row--:'';
                    break;
                case 'ArrowDown':
                    this.tableCell.row<this.tableCell.maxRow?this.tableCell.row++:'';
                    break;
                case 'ArrowLeft':
                    this.tableCell.col>1?this.tableCell.col--:'';
                    break;
                case 'ArrowRight':
                    this.tableCell.col<this.tableCell.maxCol?this.tableCell.col++:'';
                    break;
            }
            var input =this.$refs.topicTable.rows[this.tableCell.row].cells[this.tableCell.col].getElementsByTagName("input");
            if(input.length>0){
                input[0].focus();
            }
        })
        const inputs=this.$refs.topicTable.getElementsByTagName("input");
        for(var i=0; i<inputs.length; i++){
            inputs[i].addEventListener("focus", (e) => {
                this.tableCell.row=e.target.closest('tr').rowIndex;
                this.tableCell.col=e.target.closest('td').cellIndex;
            })
        }
    },
    methods: {
        onKeypressed(event){
            this.keypressed=event.keyCode;
        },
        saveAbilities(){
            var data=[];
            Object.entries(this.abilities).forEach(ability => {
                const temp={...ability[1]};
                delete temp.student_name
                Object.entries(temp).forEach((item) => {
                    const [key, value] = item;
                    const arr = key.split("_");
                    console.log("value: "+value);
                    if(value!=null){
                        data.push({
                            "klass_student_id":arr[1],
                            "topic_id":arr[2],
                            "credit":value
                        })
                    }
                })
            })
            axios.post(route('manage.klass.abilities.update',this.klass.id),data)
                .then(resp=> 
                    console.log(resp.data)
                );
        },
        getAbilityName(abilities, topic){
            if(abilities.length==0){
                return '';
            }
            var ability=abilities.find(a=>a.topic_id==topic.id);
            if(ability===undefined){
                return '';
            }
            return ability.credit
            
        }
    },
}
</script>

<style>
#topicTable, #topicTable td, #topicTable th {
  border: 1px solid;
}

#topicTable {
  width: 100%;
  border-collapse: collapse;
}
</style>