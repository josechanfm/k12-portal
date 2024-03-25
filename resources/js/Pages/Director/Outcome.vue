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
                    <a-button type="primary" @click="saveOutcomes">更新並保存</a-button>
                    <a-button v-for="term in terms" @click="selectedTerm=term.value" class="ml-4" :type="selectedTerm==term.value?'primary':''">{{term.label}}</a-button>
                    <table id="outcomeTable" ref="outcomeTable">
                        <tr>
                            <th>學生姓名</th>
                            <td>late</td>
                            <td>Absent</td>
                            <td>reward</td>
                            <td>leisure_name</td>
                            <td>leisure_perform</td>
                            <td>comment</td>
                            <td>appraisal</td>
                        </tr>
                        <template v-for="(outcome, key) in outcomes">
                            <tr v-if="outcome && outcome.term_id==selectedTerm">
                                <td>{{ outcome.student.name_zh }}</td>
                                <td><a-input v-model:value="outcome.late" @keyup.arrow-keys="onKeypressed"/></td>
                                <td><a-input v-model:value="outcome.absent" @keyup.arrow-keys="onKeypressed"/></td>
                                <td><a-input v-model:value="outcome.reward" @keyup.arrow-keys="onKeypressed"/></td>
                                <td><a-input v-model:value="outcome.leisure_name" @keyup.arrow-keys="onKeypressed"/></td>
                                <td><a-input v-model:value="outcome.leisure_perform" @keyup.arrow-keys="onKeypressed"/></td>
                                <td><a-input v-model:value="outcome.comment" @keyup.arrow-keys="onKeypressed"/></td>
                                <td><a-input v-model:value="outcome.appraisal" @keyup.arrow-keys="onKeypressed"/></td>
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
import { VueElement } from 'vue';

export default {
    components: {
        AdminLayout
    },
    props: ['terms','klass', 'outcomes'],
    data() {
        return {
            keypressed:"",
            selectedTerm:1,
            tableCell:{
                row:0,
                col:0,
                maxRow:this.outcomes.length,
                maxCol:7
            },
        }
    },
    created(){
        
    },
    mounted() {
        this.$refs.outcomeTable.addEventListener('keydown', (e) => {
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
            var input =this.$refs.outcomeTable.rows[this.tableCell.row].cells[this.tableCell.col].getElementsByTagName("input");
            if(input.length>0){
                input[0].focus();
            }
        })
        const inputs=this.$refs.outcomeTable.getElementsByTagName("input");
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
        saveOutcomes(){
            var data=JSON.parse(JSON.stringify(this.outcomes));
            data.forEach(function (d) { 
                delete d.student;
                delete d.laravel_through_key;
                delete d.created_at;
                delete d.updated_at;
            });
            axios.post(route('director.klass.outcomes.update',this.klass.id),data)
                .then(resp=> 
                    console.log(resp.data)
                );
        },
    },
}
</script>

<style>
#outcomeTable, #outcomeTable td, #outcomeTable th {
  border: 1px solid;
}

#outcomeTable {
  width: 100%;
  border-collapse: collapse;
}
</style>