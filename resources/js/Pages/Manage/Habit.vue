<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                 科 學分管理
                <br/>
            </h2>
        </template>
        {{selectedTerm}}
        <a-button v-for="term in terms" @click="selectedTerm=term.value">{{term.label}}</a-button>
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-button type="primary" @click="saveScores">更新並保存</a-button>
                    <table id="scoreTable" ref="scoreTable">
                        <tr>
                            <th style="width:100px" rowspan="2" class="crossed">
                                <span class="float-right">評分</span><br>
                                <span class="float-left">學生姓名</span>
                            </th>
                            <td colspan="5">健康與</td>
                            <td colspan="6">健康與</td>
                            <td colspan="5">健康與</td>
                        </tr>
                        <tr>
                            <td v-for="column in habitColumns">
                                <a-tooltip>
                                    <template #title>{{ column.label }}</template>
                                    {{ column.short }}
                                </a-tooltip>
                            </td>
                        </tr>
                        <tr v-for="student in klass.students" >
                            <td>{{ student.name_zh }}</td>
                            <td v-for="column in habitColumns">
                                <a-input v-model:value="scores[student.pivot.klass_student_id][selectedTerm][column.name]"  maxlength="1"/>
                            </td>
                        </tr>
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
    props: ['klass','terms','habitColumns','habits'],
    data() {
        return {
            keypressed:"",
            tableCell:{
                row:0,
                col:0,
                maxRow:this.klass.students.length,
                maxCol:this.habitColumns.length
            },
            selectedTerm:1,
            scores:{},
        }
    },
    created(){
        this.klass.students.forEach(student=>{
            this.scores[student.pivot.klass_student_id]={};
            this.terms.forEach(term=>{
                this.scores[student.pivot.klass_student_id][term.value]={klass_student_id:student.pivot.klass_student_id, term_id:term.value};
                this.habitColumns.forEach(column=>{
                    this.scores[student.pivot.klass_student_id][term.value][column.name]='';
                });
            })
        });
        this.habits.forEach(habit=>{
            this.habitColumns.forEach(column=>{
                this.scores[habit.klass_student_id][habit.term_id][column.name]=habit[column.name];
            });
            //console.log(habit);

            //console.log(this.scores[habit.klass_student_id][1]);
        })
        console.log(this.scores);
    },
    mounted() {
        this.$refs.scoreTable.addEventListener('keydown', (e) => {
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
            var input =this.$refs.scoreTable.rows[this.tableCell.row].cells[this.tableCell.col].getElementsByTagName("input");
            console.log(input);
            if(input.length>0){
                //input[0].focus();
                input[0].select();
            }
        })
        const inputs=this.$refs.scoreTable.getElementsByTagName("input");
        for(var i=0; i<inputs.length; i++){
            inputs[i].addEventListener("focus", (e) => {
                this.tableCell.row=e.target.closest('tr').rowIndex;
                this.tableCell.col=e.target.closest('td').cellIndex;
            })
        }
    },
    methods: {
        onKeypressed(event){
            console.log("press");
            this.keypressed=event.keyCode;
            console.log(event.keyCode);
        },
        saveScores(){
            var data=[];
            Object.entries(this.scores).forEach(([klass_student_id,term])=>{
                Object.entries(term).forEach(([term_id,habits])=>{
                    if(term_id==this.selectedTerm){
                        data.push(habits)
                    }
                })
            })
            this.$inertia.put('/manage/habits/'+this.klass.id, data, {
                onSuccess: (page) => {
                        console.log(page);
                    },
                    onError: (error) => {
                        console.log(error);
                    }
            })
        },
    },
}
</script>


<style>
#scoreTable, #scoreTable td, #scoreTable th {
  border: 1px solid;
}

#scoreTable {
  width: 100%;
  border-collapse: collapse;
}
table td.crossed, table th.crossed
{
   background-image: linear-gradient(to top right,  transparent calc(50% - 0.5px), black, transparent calc(50% + 1px)); 
}
#scoreTable input{
    text-transform: uppercase;
    text-align: center;
}
</style>

