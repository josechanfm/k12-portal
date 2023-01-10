<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Score for {{ klass.tag }}
            </h2>
        </template>
        <a-button type="primary" @click="onClickScoreModal">Score</a-button>
        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-table :dataSource="score_columns" :columns="columns">
                        <template #bodyCell="{ column, text, record, index }">
                            <template v-if="column.dataIndex == 'operation'">
                                <a-button @click="onClickEditScoreColumn(record)">Edit</a-button>
                                <a-button @click="onClickDeleteScoreColumn(record.id)">Delete</a-button>
                            </template>
                            <template v-else>
                                {{ record[column.dataIndex]}}
                            </template>
                        </template>
                    </a-table>
                </div>
            </div>
        </div>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-button type="primary" @click="saveScores">Save</a-button>
                    <table id="scoreTable" ref="scoreTable">
                        <tr>
                            <th>Name</th>
                            <td v-for="column in score_columns">{{ column.name }}</td>
                        </tr>
                        <tr v-for="(score, key) in scores">
                            <td>{{ score.student_name }}</td>
                            <td v-for="column in score_columns">
                                <a-input  v-model:value="score['score_'+key+'_'+column.id]" @keyup.arrow-keys="onKeypressed"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <a-modal v-model:visible="modal.isOpen" :title="modal.title" @ok="handleOk">
            <a-form 
                :model="modal.data"
                name="score_column"
                ref="modalScoreColumn"
                @finish="onModalFinish"
            >
                <a-form-item label="Name" :name="['name']" :rules="[{required:true, message:'Please input score column name'}]">
                    <a-input v-model:value="modal.data.name"/>
                </a-form-item>
                <a-form-item label="Class" :name="['klass_id']" :rules="[{required:true, message:'Please input score column name'}]">
                    <a-input v-model:value="modal.data.klass_id"/>
                </a-form-item>
                <a-form-item label="Term" :name="['term_id']" :rules="[{required:true, message:'Please input score column name'}]">
                    <a-input v-model:value="modal.data.term_id"/>
                </a-form-item>
                <a-form-item label="sequence" :name="['sequence']" >
                    <a-input v-model:value="modal.data.sequence"/> 
                </a-form-item>
                <a-form-item label="Scheme" :name="['scheme']">
                    <a-input v-model:value="modal.data.scheme" /> 
                </a-form-item>
                <a-form-item label="Description" :name="['description']">
                    <a-input v-model:value="modal.data.description"/> 
                </a-form-item>
            </a-form>
        </a-modal>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['score_columns', 'klass', 'students_scores'],
    data() {
        return {
            keypressed:"",
            modal: {
                mode:null,
                isOpen: false,
                title:'Score Column',
                data:{}
            },
            tableCell:{
                row:0,
                col:0,
                maxRow:this.students_scores.length,
                maxCol:this.score_columns.length
            },
            scores:{},
            columns: [
                {
                    title: 'Term',
                    dataIndex: 'term_id',
                },{
                    title: 'Name',
                    dataIndex: 'name',
                }, {
                    title: 'Type',
                    dataIndex: 'type',
                }, {
                    title: 'Schema',
                    dataIndex: 'schema',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ]

        }
    },
    created(){
        this.students_scores.forEach(student => {
            var score={};
            score['student_name']=student.name_zh
            this.score_columns.forEach(column => {
                score['score_'+student.pivot.klass_student_id+"_"+column.id]=''
            })
            this.scores[student.pivot.klass_student_id]=score;
        })
        this.students_scores.forEach(student => {
            student.scores.forEach(score => {
                
                this.scores[student.pivot.klass_student_id]['score_'+score.klass_student_id+'_'+score.score_column_id]=score.point;
            })
        })
        //console.log(this.scores)
        
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
            if(input.length>0){
                input[0].focus();
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
        onClickScoreModal() {
            this.modal.data={};
            this.modal.title="Add Score Column";
            this.modal.mode='ADD';
            this.modal.isOpen = true;
        },
        onClickEditScoreColumn(record){
            this.modal.data=record;
            this.modal.title="Edit Score Column";
            this.modal.mode='EDIT';
            this.modal.isOpen = true;
        },
        onClickDeleteScoreColumn(recordId){
            console.log("Need to check if the column id already use in score table. need to double confirm or shows the existing score record again.");

            console.log(recordId);
        },
        onModalFinish(){
            console.log("modal finish");
        },
        saveScores(){
            var data=[];
            Object.entries(this.scores).forEach(score => {
                const temp={...score[1]};
                delete temp.student_name
                Object.entries(temp).forEach((item) => {
                    const [key, value] = item;
                    const arr = key.split("_");
                    data.push({
                        "klass_student_id":arr[1],
                        "score_column_id":arr[2],
                        "point":value
                    })
                })
            })

            axios.post('score_update',data)
                .then(resp=> 
                    console.log(resp.data)
                );
        },
        handleOk() {
            
            console.log("modal ok " + this.modal.mode);
            this.modal.mode=null;

            this.$refs.modalScoreColumn.validateFields().then(()=>{
                console.log("valid");
            }).catch(err => {
                console.log(err);
            })
        }
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
</style>