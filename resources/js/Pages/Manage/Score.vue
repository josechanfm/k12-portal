<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                 {{ course.klass.tag }} {{ course.title_zh }}科 學分管理
                <br/>
                <span v-for="teacher in course.teachers">
                    {{ teacher.name_zh }} 
                    <span v-if="teacher.pivot.is_head">(Head)</span>
                    &nbsp;
                </span>
            </h2>
        </template>
        <a-button :href="'grades?kid='+course.klass_id">Back</a-button>
        <a-button type="primary" @click="onClickAddScoreColumn">新增學分欄</a-button>


        <table class="itxst">
            <tbody component='VueDraggableNext' animation="500"  force-fallback="true">
                <draggable class="dragArea list-group w-full" :list="score_columns" @change="rowChange">
                      <transition-group>

                    <tr v-for="item in score_columns" :key="item.id">
                        <td style="width:50px" class="move">{{item.id}}</td>
                        <td style="width:250px">{{item.field_label}}</td>
                    </tr>
                      </transition-group>
                </draggable>
            </tbody>
        </table>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-table :dataSource="score_columns" :columns="columns" >
                        <template #bodyCell="{ column, text, record, index }">
                            <template v-if="column.dataIndex == 'operation'">
                                <a-button @click="onClickEditScoreColumn(record)">修改</a-button>
                                <span v-if="record.for_transcript==0">
                                    <a-button @click="onClickDeleteScoreColumn(record.id)">刪除</a-button>
                                </span>
                            </template>
                            <template v-else-if="column.dataIndex=='term_id'">
                                {{ year_terms.find(t=>t.value==text).label }}
                            </template>
                            <template v-else>
                                ({{ String.fromCharCode(65+index) }})
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
                    <a-button type="primary" @click="saveScores">更新並保存</a-button>
                    <table id="scoreTable" ref="scoreTable">
                        <thead>
                            <tr>
                                <th width="100px">學生姓名</th>
                                <th v-for="(column,idx) in score_columns">
                                    <span :title="column.scheme">
                                        ({{ String.fromCharCode(idx+65) }}) {{ column.field_label }}
                                        <span v-if="column.scheme">*</span>
                                    </span>
                                </th>
                            </tr>
                        </thead>
                        <tr v-for="(row, key) in scores">
                            <td>{{ row.student_name }}</td>
                            <td v-for="column in score_columns">
                                <a-input v-model:value="row.scores[column.id]" 
                                    @blur="onScoreChange(key)"
                                    @keyup.arrow-keys="onKeypressed" 
                                />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <a-modal v-model:visible="modal.isOpen" :title="modal.title" @ok="handleScoreColumnChange">
            <a-form 
                :model="modal.data"
                name="course_score"
                ref="modalScoreColumn"
                @finish="onModalFinish"
            >
                <a-form-item label="學分欄名稱 " :name="['field_label']" :rules="[{required:true, message:'Please input score column name'}]">
                    <a-input v-model:value="modal.data.field_label"/>
                </a-form-item>
                <a-form-item label="學段" :name="['term_id']">
                    <a-select v-model:value="modal.data.term_id" :options="year_terms"/>
                </a-form-item>
                <a-form-item label="序號" :name="['sequence']" >
                    <a-input v-model:value="modal.data.sequence"/> 
                </a-form-item>
                <a-form-item label="計算方式" :name="['scheme']">
                    <a-input v-model:value="modal.data.scheme" @change="()=>{modal.data.scheme=modal.data.scheme.toUpperCase()}"/> 
                </a-form-item>
                <a-form-item label="簡介" :name="['description']">
                    <a-input v-model:value="modal.data.description"/> 
                </a-form-item>
            </a-form>
        </a-modal>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { ContactsOutlined } from '@ant-design/icons-vue';
import { VueDraggableNext } from 'vue-draggable-next'

export default {
    components: {
        AdminLayout,
        draggable: VueDraggableNext,
    },
    props: ['year_terms','course', 'score_columns', 'students_scores'],
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
            scores:[],
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
                    dataIndex: 'scheme',
                },{
                    title: '排序',
                    dataIndex: 'sequence',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                }
            ]

        }
    },
    created(){
        this.students_scores.forEach(student => {
            let temp={}
            student.scores.forEach(score=>{
                temp[score.score_column_id]=score.point
            })
            this.scores.push({
                course_student_id:student.pivot.course_student_id,
                student_name:student.name_zh,
                scores:temp
            });
        })        
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
            this.keypressed=event.keyCode;
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
            //this.$inertia.put('/manage/score_column/'+data.id, data, {
                
            this.$inertia.put(route("manage.score_column.update",data.id), data, {
                    onSuccess: (page) => {
                        this.modal.mode=null;
                        this.modal.isOpen=false;
                        this.updateAllScores();
                    },
                    onError: (error) => {
                        console.log(error);
                    }
            });
        },
        onModalFinish(){
            console.log("modal finish");
        },
        saveScores(){
            var data=[];
            this.scores.forEach(row => {
                Object.entries(row.scores).forEach(([score_column_id,value]) => {
                    data.push({
                        course_student_id:row.course_student_id,
                        score_column_id:score_column_id,
                        point:value
                    })
                })
            })
            axios.post(route('manage.score.update'),data)
                .then(resp=> 
                    console.log("update "+resp.data+" records")
                );
        },
        handleScoreColumnChange() {
            this.$refs.modalScoreColumn.validateFields().then(()=>{
                if(this.modal.mode=='ADD'){
                    this.createScoreColumn(this.modal.data);
                    this.modal.mode=null;
                }else if(this.modal.mode=='EDIT'){
                    this.updateScoreColumn(this.modal.data);
                }

            }).catch(err => {
                console.log(err);
            })
        },
        onScoreChange(key){
            this.runFormular(this.score_columns, this.scores[key], key);
        },
        updateAllScores(){
            this.scores.forEach(row=>{
                console.log(row);
            })
            // for(const [key, obj] of Object.entries(this.scores)){
            //     this.runFormular(this.score_columns, obj, key);
            // }
        },
        runFormular(columns, row, courseStudentId){
            var fields={};
            var letter=65;
            columns.forEach(column=>{
                if (row.scores[column.id] === undefined) {
                    fields[String.fromCharCode(letter++)] = '';
                }else{
                    fields[String.fromCharCode(letter++)] = row.scores[column.id];
                }
            })
            //loop through all score columns
            columns.forEach((column, idx)=>{
                //if column scheme is not empty, meaning with formular
                if(column.scheme!=null){
                    var fieldName=column.id;
                    var formular=column.scheme;
                    //remove "=" from the origianl formular
                    formular=formular.replace("=","");
                    //replace round as Math.round in the formular
                    formular=formular.replace("round","Math.round");
                    //replace values to formular, according to the fields values
                    Object.entries(fields).forEach(([key,value])=>{
                        console.log(key);
                        console.log(value);
                        if(value=='') value=0; //escape formular calculation if any field is empty
                        formular=formular.replace(key,value);
                    });
                    console.log(formular)
                    try{
                        row.scores[fieldName]=eval(formular);
                    }catch(error){
                        console.log("("+courseStudentId+")"+row.student_name+", formular incurrect");
                    }
                }
            });                
        },
        rowChange(event){
            console.log(event);
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
#scoreTable input{
    text-align: center; 
}

        /*定义要拖拽元素的样式*/
        table.itxst {
            color: #333333;
            border: #ddd solid 1px;
            border-collapse: collapse;
        }

            table.itxst th {
                border: #ddd solid 1px;
                padding: 8px;
                background-color: #dedede;
            }

            table.itxst td {
                border: #ddd solid 1px;
                padding: 8px;
                background-color: #ffffff;
            }

            table.itxst tr {
                cursor: pointer;
            }

            table.itxst td.move:hover {
                cursor: move;
            }
</style>