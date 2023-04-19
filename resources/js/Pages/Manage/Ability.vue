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
            <div class="mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-button type="primary" @click="saveAbilities">更新並保存</a-button>
                    <a-button v-for="term in terms" @click="selectedTerm=term.value" class="ml-4" :type="selectedTerm==term.value?'primary':''">{{term.label}}</a-button>
                    <table id="abilityTable" ref="abilityTable">
                        <tr>
                            <th width="100px" rowspan="2" class="text-center">學生姓名</th>
                            <th v-for="theme in themes" :colspan="theme.topic_count" class="text-center">
                                {{ theme.title_zh }}
                            </th>
                        </tr>
                        <tr>
                            <th v-for="topic in topics"  class="text-center">
                                <a-tooltip>
                                    <template #title>[{{topic.theme.title_zh}}]<br>{{ topic.title_zh }}</template>
                                    {{ topic.abbr_zh }} 
                                </a-tooltip>
                            </th>
                            <th></th>
                        </tr>
                        <template v-for="(student, key) in abilities">
                            <tr>
                                <td>{{ student.student_name }}</td>
                                <td v-for="topic in topics">
                                    <template v-for="(ability, term_id) in student">
                                        <template v-if="term_id==selectedTerm">
                                            <a-input v-model:value="ability['ability_'+topic.id]" 
                                                @keyup.arrow-keys="onKeypressed" 
                                                @click="onFocusInput($event)"
                                            />
                                        </template>
                                    </template>
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
    props: ['terms','klass','themes', 'topics','students_abilities'],
    data() {
        return {
            keypressed:"",
            selectedTerm:1,
            abilities:{},
            tableCell:{
                row:0,
                col:0,
                maxRow:this.students_abilities.length+1,
                maxCol:this.topics.length
            },
        }
    },
    created(){
        this.students_abilities.forEach(student=>{
            this.abilities[student.pivot.klass_student_id]={}
            this.abilities[student.pivot.klass_student_id]={student_name:student.name_zh,terms:[]};
                this.terms.forEach(term=>{
                this.abilities[student.pivot.klass_student_id][term.value]={};
                    this.topics.forEach(topic=>{
                        this.abilities[student.pivot.klass_student_id][term.value]['ability_'+topic.id]='';
                    })
                }) 
                
        })
        this.students_abilities.forEach(student=>{
            this.terms.forEach(term=>{
                this.topics.forEach(topic=>{
                    student.abilities.forEach(ability=>{
                        if(ability.term_id==term.value){
                            this.abilities[student.pivot.klass_student_id][term.value]['ability_'+ability.topic_id]=ability.credit;
                        }
                    })
                })
            })
        })
        console.log(this.abilities);
    },
    mounted() {
        this.$refs.abilityTable.addEventListener('keydown', (e) => {
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
            
            var input =this.$refs.abilityTable.rows[this.tableCell.row].cells[this.tableCell.col].getElementsByTagName("input");
            if(input.length>0){
                input[0].select();
            }
        })
        const inputs=this.$refs.abilityTable.getElementsByTagName("input");
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
            Object.entries(this.abilities).forEach(([klass_student_id,student])=>{
                this.terms.forEach(term=>{
                    Object.entries(student[term.value]).forEach(([key,value])=>{
                        const arr = key.split("_");
                        data.push({
                            'term_id':term.value,
                            'klass_student_id':klass_student_id,
                            'topic_id':arr[1],
                            'credit':value
                        });
                    })
                })
            })
            console.log(data);
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
            
        },
        onFocusInput(event){
            this.tableCell.row=event.target.closest('tr').rowIndex;
            this.tableCell.col=event.target.closest('td').cellIndex;
        }
    },
}
</script>

<style>
#abilityTable, #abilityTable td, #abilityTable th {
  border: 1px solid;
}

#abilityTable {
  width: 100%;
  border-collapse: collapse;
}
</style>