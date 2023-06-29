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
        <div class="py-6">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <inertia-link :href="route('manage.klasses.show',course.klass_id)" class="ant-btn">Back</inertia-link>
                <a-button type="primary" @click="onClickAddScoreColumn">新增學分欄</a-button>
                <a-button v-for="term in year_terms" @click="selectedTerm=term.value" class="ml-4" :type="selectedTerm==term.value?'primary':''">{{term.label}}</a-button>
            </div>
        </div>
        <div class="py-6">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <table class="itxst" component='VueDraggableNext' animation="500"  force-fallback="true" width="100%">
                        <thead>
                                <tr>
                                    <th>排序</th>
                                    <th>學段</th>
                                    <th>學分欄名稱</th>
                                    <th>分類</th>
                                    <th>計算方式</th>
                                    <th>學期總分</th>
                                    <th>操作</th>
                                </tr>
                        </thead>
                        <draggable tag="tbody" class="dragArea list-group w-full" :list="score_columns" @change="rowChange">
                            <transition-group v-for="(record,idx) in score_columns" :key="record.id">
                            <tr v-if="record.term_id==selectedTerm">
                                <td>{{record.column_letter}}</td>
                                <td>{{ year_terms.find(t=>t.value==record.term_id).label }}</td>
                                <td>{{record.field_label}}</td>
                                <td>{{ record.type }}</td>
                                <td>{{ record.scheme }}</td>
                                <td>
                                    <a-switch v-model:checked="record.is_total" :checked-value="1" :un-checked-value="0" @click="onChangeTotalColumn(record)"/>
                                </td>
                                <td style="width:250px">
                                    <a-button @click="onClickEditScoreColumn(record)">修改</a-button>
                                    <span v-if="record.for_transcript==0">
                                        <a-button @click="onClickDeleteScoreColumn(record.id)">刪除</a-button>
                                    </span>
                                </td>
                            </tr>
                            </transition-group>
                        </draggable>
                    </table>
                </div>
            </div>
        </div>

        <div class="py-6">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-button type="primary" @click="saveScores">更新並保存</a-button>
                    <a-button @click="sampleData">Sample Data</a-button>
                    <table id="scoreTable" ref="scoreTable">
                        <thead>
                            <tr>
                                <th width="100px">學生姓名</th>
                                <template v-for="(column,idx) in score_columns" >
                                    <th v-if="column.term_id==selectedTerm">
                                        <span :title="column.scheme">
                                            ( {{ column.column_letter }} ) {{ column.field_label }}
                                            <span v-if="column.scheme">*</span>
                                        </span>
                                    </th>
                                </template>
                                <td>全年總平均分</td>
                            </tr>
                        </thead>
                        <template v-for="(student,sid) in students_scores">
                            <tr>
                                <td>{{ student['student_name'] }}</td>
                                <template v-for="column in score_columns">
                                    <template v-for="(score, cid) in student.scores">
                                        <td v-if="column.term_id==selectedTerm && column.id==cid">
                                            <a-input v-model:value="score.point" 
                                                @blur="onScoreChange(student,cid)"
                                                @keyup.arrow-keys="onKeypressed" 
                                            />

                                        </td>
                                    </template>
                                </template>
                                <template v-for="column in score_columns">
                                    <td v-if="column.term_id==9">{{ student.scores[column.id].point }}</td>    
                                </template>
                                
                            </tr>
                        </template>


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
            selectedTerm:1,
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
                    title: 'Lette',
                    dataIndex: 'letter',
                },{
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
                    this.tableCell.col<(this.$refs.scoreTable.rows[0].cells.length-1)?this.tableCell.col++:'';
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
            this.students_scores.forEach(student => {
                Object.entries(student.scores).forEach(([cid,score]) => {

                    data.push({
                        course_student_id:score.course_student_id,
                        score_column_id:score.score_column_id,
                        student_id:student.student_id,
                        point: score.point
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
        onScoreChange(student,columnId){
            var fields=[];
            //change year total scheme formular
            var termTotals=[];
            this.score_columns.forEach((column, idx)=>{
                if(column.is_total==1){
                    termTotals.push(column.column_letter);
                }
                if(column.term_id==9){
                    termTotals.forEach((t,i)=>{
                        column.scheme=column.scheme.replace('T'+(i+1),termTotals[i])
                    })
                }
            })


            this.score_columns.forEach(column=>{
                var formular='';
                fields[column.id]= {'point':'','letter':column.column_letter};
                if(column.scheme!==null){
                    formular=column.scheme;
                    Object.entries(student.scores).forEach(([columnId,score])=>{
                        formular=formular.replace(score.column_letter, score.point);
                    })
                    try{
                        formular=formular.replace("=","");
                        student.scores[column.id].point=eval(formular)
                    }catch(error){
                        console.log('error');
                    }
               }
            })


            //init column letters
            //this.runFormular(this.score_columns, this.scores[key], key);
        },
        updateAllScores(){
            this.scores.forEach(row=>{
                console.log(row);
            })
            for(const [key, obj] of Object.entries(this.scores)){
                this.runFormular(this.score_columns, obj, key);
            }
        },
        runFormular(columns, row, courseStudentId){
            //console.log(this.students_scores);
            var fields={};
            var termTotals=[];
            //init column letters
            columns.forEach(column=>{
                if (row.scores[column.id] === undefined) {
                    fields[column.column_letter] = '';
                }else{
                    fields[column.column_letter] = row.scores[column.id];
                }
            })

            //change year total scheme formular
            columns.forEach((column, idx)=>{
                if(column.is_total==1){
                    termTotals.push(column.column_letter);
                }
                if(column.term_id==9){
                    termTotals.forEach((t,i)=>{
                        //column.scheme=column.scheme.replace('T'+(i+1),termTotals[i])
                    })
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
                    formular=formular.replace("ROUND","Math.round");
                    //replace values to formular, according to the fields values
                    Object.entries(fields).forEach(([key,value])=>{
                        if(value=='') value=0; //escape formular calculation if any field is empty
                        formular=formular.replace(key,value);
                    });
                    try{
                        row.scores[fieldName]=eval(formular);
                    }catch(error){
                        console.log("("+courseStudentId+")"+row.student_name+", formular incurrect");
                        console.log(formular);
                    }
                }
            });
            // //calculate year total, average terms total column
            // var sum=0;
            // var cnt=0;
            // columns.forEach((column,idx)=>{
            //     if(column.is_total==1 && column.term_id!=9){
            //         cnt++
            //         sum+=eval(row.scores[column.id])
            //     }
            // })
            // //give year total to data column, default was set by term_id==9
            // columns.forEach((column,idx)=>{
            //     if(column.term_id==9){
            //         row.scores[column.id]=sum/cnt
            //     }
            // })
        },
        countYearAverage(){
            console.log(this.scores);
        },
        rowChange(event){
            let i=1;
            this.score_columns.forEach(column=>{
                column.sequence=i++
            })
            this.$inertia.post(route("manage.score_column.reorder"), this.score_columns, {
                    onSuccess: (page) => {
                        console.log(page);
                    },
                    onError: (error) => {
                        console.log(error);
                    }
            });            
        },
        sampleData(){
            const total=this.score_columns
            this.students_scores.forEach(student=>{
                this.score_columns.forEach(column=>{
                    student.scores[column.id]['point']=Math.floor(Math.random() * 100)+1
                })
            })
            this.updateAllScores();
        },
        onChangeTotalColumn(record){
            if(confirm('Are you sure??')==false){
                record.is_total=!record.is_total;
                return false;
            }
            //set all is_total to false, according to term_id selected
            this.score_columns.map(item=>{
                if(item.term_id==this.selectedTerm)
                    item.is_total=0
            })
            //set the select score column as is_total=true
            record.is_total=1;
            this.$inertia.post(route("manage.score_column.update_is_total"), this.score_columns, {
                    onSuccess: (page) => {
                        console.log(page);
                    },
                    onError: (error) => {
                        console.log(error);
                    }
            });            
        },
        getYearAverage(row){
            return row.scores[this.score_columns.find(c=>c.term_id==9).id] 
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
                background-color: #fafafa;
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