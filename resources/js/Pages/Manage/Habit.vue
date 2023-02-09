<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                 {{ klass.tag }}科 學分管理
                <br/>
            </h2>
        </template>
        <a-button type="primary" @click="onClickAddScoreColumn">新增學分欄</a-button>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-button type="primary" @click="saveScores">更新並保存</a-button>
                    <table id="scoreTable" ref="scoreTable">
                        <tr>
                            <th style="width:100px">學生姓名</th>
                            <td v-for="column in habitColumns">{{ column.short }}</td>
                        </tr>
                        <tr v-for="student in klass.students" >
                            <td>{{ student.name_zh }}</td>
                            <td v-for="column in habitColumns">
                                <a-input v-model="scores[student.pivot.klass_student_id][selectedTerm][column.name]"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" @ok="handleScoreColumnChange">
            <a-form 
                :model="modal.data"
                name="score_column"
                ref="modalScoreColumn"
                @finish="onModalFinish"
            >
            
                <a-form-item label="Field Name" :name="['field_label']" :rules="[{required:true, message:'Please input score column name'}]">
                    <a-input v-model:value="modal.data.field_label"/>
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
                <a-form-item label="Course" :name="['course_id']" :rules="[{required:true, message:'Please input score column course_id'}]" :hidden="true">
                    <a-input v-model:value="modal.data.course_id"/>
                </a-form-item>
                <a-form-item label="Type" :name="['type']"  :rules="[{required:true, message:'Please input score column type'}]" :hidden="true">
                    <a-input v-model:value="modal.data.type" /> 
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
    props: ['klass','terms','habitColumns','habits'],
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
                maxRow:10,
                maxCol:10
            },
            selectedTerm:1,
            scores:{},
            columns: [
                {
                    title: '學段',
                    dataIndex: 'term_id',
                },{
                    title: '學分欄名稱',
                    dataIndex: 'field_label',
                },{
                    title: '分類',
                    dataIndex: 'type',
                },{
                    title: '計算方式',
                    dataIndex: 'schema',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                }
            ]
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
        onClickAddScoreColumn() {
            this.modal.data={};
            this.modal.data.course_id=this.course.id;
            this.modal.data.type='SUB';
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
        handleScoreColumnChange() {
            this.$refs.modalScoreColumn.validateFields().then(()=>{
                if(this.modal.mode=='ADD'){
                    this.createScoreColumn(this.modal.data);
                    console.log("??modal ok " + this.modal.mode);
                    this.modal.mode=null;
                }else if(this.modal.mode=='EDIT'){
                    console.log("to update");
                    this.updateScoreColumn(this.modal.data);
                }

            }).catch(err => {
                console.log(err);
            })

        },
        createScoreColumn(data){
            this.$inertia.post('/manage/score_column/', data, {
                    onSuccess: (page) => {
                        this.modal.mode=null;
                        this.modal.isOpen=false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
            });
        },
        updateScoreColumn(data){
            console.log("in update");
            this.$inertia.put('/manage/score_column/'+data.id, data, {
                    onSuccess: (page) => {
                        this.modal.mode=null;
                        this.modal.isOpen=false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
            });
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

