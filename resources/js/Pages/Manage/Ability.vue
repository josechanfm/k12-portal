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
                    <a-select
                        v-model:value="selectedTheme"
                        :options="themes"
                        :field-names="{value:'id',label:'title'}"
                    ></a-select>

                    <table id="abilityTable" ref="abilityTable">
                        <tr>
                            <th rowspan="2">Student name</th>
                            <template v-for="topic in topics"  >
                                <th v-if="topic.theme_id==selectedTheme" class="text-center">
                                    {{ topic.section }} 
                                </th>
                            </template>
                        </tr>
                        <tr>
                            <template v-for="topic in topics"  >
                                <th v-if="topic.theme_id==selectedTheme" class="text-center">
                                    <a-tooltip>
                                        <template #title>[{{topic.theme.title}}]<br>{{ topic.title }}</template>
                                        {{ topic.abbr }} 
                                    </a-tooltip>
                                </th>
                            </template>
                        </tr>
                        <template v-for="(ability, key) in abilities">
                            <tr>
                                <td>{{ ability.student_name }}</td>
                                <template v-for="topic in topics">
                                    <td v-if="topic.theme_id==selectedTheme">
                                        <a-input v-model:value="ability.topics[topic.id]" 
                                            @keyup.arrow-keys="onKeypressed" 
                                            @click="onFocusInput($event)"
                                        />
                                    </td>
                                </template>
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
            selectedTheme:this.themes[0].id,
            abilities:[],
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
            let temp={}
            student.abilities.forEach(ability=>{
                temp[ability.topic_id]=ability.credit
            })
            this.abilities.push({
                klass_student_id:student.pivot.klass_student_id,
                student_name:student.name_zh,
                topics:temp
            })
        })
        // console.log(this.abilities);
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
            this.abilities.forEach((ability)=>{
                Object.entries(ability.topics).forEach(([k,v])=>{
                    data.push({
                        'klass_student_id':ability.klass_student_id,
                        'topic_id':k,
                        'credit':v
                    });
                })   
            })
            // console.log(data);
            axios.post   (route('manage.klass.abilities.update',this.klass.id),data)
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
        },
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