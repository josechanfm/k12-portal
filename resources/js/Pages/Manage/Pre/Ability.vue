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
                    <a-divider type="vertical" />
                    <a-select
                        v-model:value="selectedThemeId"
                        :options="klass.themes.filter(theme=>theme.term_id==selectedTermId)"
                        :field-names="{value:'id',label:'title'}"
                    ></a-select>
                    
                    <a-divider type="vertical" />
                    <a-radio-group v-model:value="selectedTermId" button-style="solid" @change="onChangeTerm">
                        <template v-for="term in yearTerms">
                            <a-radio-button :value="term.value">{{term.label}}</a-radio-button>
                        </template>
                    </a-radio-group>
                    <a-divider type="vertical" />
                    <a :href="route('manage.pre.klass.abilities.pdf',klass.id)" class="ant-btn">報告</a>
                    <table id="abilityTable" ref="abilityTable">
                        <thead>
                            <tr>
                                <th rowspan="2">Student name</th>
                                <template v-for="topic in klass.themes.find(theme=>theme.id==selectedThemeId).topics"  >
                                    <th class="text-center">
                                        {{ topic.section }} 
                                    </th>
                                </template>
                                <td rowspan="2">Report</td>
                            </tr>
                            <tr>
                                <template v-for="topic in klass.themes.find(theme=>theme.id==selectedThemeId).topics"  >
                                    <th class="text-center">
                                        {{ topic.abbr }}
                                        <!-- <a-tooltip>
                                            <template #title>[{{topic.theme.title}}]<br>{{ topic.title }}</template>
                                            {{ topic.abbr }} 
                                        </a-tooltip> -->
                                    </th>
                                </template>
                            </tr>

                        </thead>
                        <tbody>
                            <template v-for="(student, ksid) in abilities['students']">
                                <tr>
                                    <td>{{ student.name_zh }}{{ ksid }}</td>
                                    <template v-for="topic in klass.themes.find(theme=>theme.id==selectedThemeId).topics"  >
                                        <td>
                                            <a-input v-model:value="abilities['scores'][ksid][topic.id].credit" 
                                                @keyup.arrow-keys="onKeypressed" 
                                                @click="onFocusInput($event)"
                                                class="text-center"
                                            />
                                        </td>
                                    </template>
                                <td>
                                    <template v-for="theme in klass.themes">
                                        <span v-if="theme.id==selectedThemeId">
                                            <a :href="route('manage.pre.theme.student',{theme:theme.id,klassStudent:ksid})" target="_blank">Pdf</a>
                                        </span>
                                    </template>
                                    
                                </td>
                                </tr>
                            </template>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="page-break"></div>
        page 2
        <div class="page-break"></div>
        page 3
        <div class="page-break"></div>
        page 4
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['yearTerms','klass','themes', 'topics','students_abilities','abilities'],
    data() {
        return {
            keypressed:"",
            selectedTermId:1,
            selectedThemeId:this.klass.themes[0].id,
            tableCell:{
                row:0,
                col:0,
                maxRow:this.students_abilities.length,
                maxCol:this.klass.topics.length
            },
        }
    },
    created(){
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
        onChangeTerm(target){
            this.selectedThemeId=this.klass.themes.find(theme=>theme.term_id==this.selectedTermId).id
        },
        saveAbilities(){
            var data=[];
            var topicList=[];
            var topicList=this.klass.themes.find(theme=>theme.id==this.selectedThemeId).topics.map(topic=>topic.id)
            Object.values(this.abilities.scores).forEach((std)=>{
                Object.entries(std).forEach(([termId,scores])=>{
                    if(termId==this.selectedTermId){
                        Object.values(scores).forEach(score=>{
                            if(topicList.includes(score.topic_id)){
                                delete score['created_at']
                                delete score['updated_at']
                                data.push(score)
                            }
                        })
                    }
                })
            })
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