<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Score
            </h2>
        </template>
        <a-button type="primary" @click="onClickScoreModal">Score</a-button>
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" @ok="handleOk">
            {{ modal.data }}
            <a-form 
                :model="modal.data"
                name="score_column"
            >
                <a-form-item label="name" name="name" :rules="[{required:true, message:'Please input score column name'}]">
                    <a-input v-model:value="modal.data.name"/>
                </a-form-item>
                <a-input v-model:value="modal.data.klass_id"/>
                <a-input v-model:value="modal.data.term_id"/>
                <a-input v-model:value="modal.data.sequence"/> 
                <a-input v-model:value="modal.data.scheme"/> 
                <a-input v-model:value="modal.data.description"/> 
            </a-form>
            <p>Some contents...</p>
            <p>Some contents...</p>
            <p>Some contents...</p>
        </a-modal>
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
        console.log(this.$refs.scoreTable);
        this.$refs.scoreTable.addEventListener('keydown', (e) => {
            console.log(e.key);
            switch(e.key){
                case 'ArrowUp':
                    console.log("up");
                    break;
                case 'ArrowDown':
                    console.log("down");
                    break;
                case 'ArrowLeft':
                    console.log("left");
                    break;
                case 'ArrowRight':
                    console.log("right");
                    break;
            }
            if (e.key == 'Escape') {
                this.showModal = !this.showModal;
            }
        });
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