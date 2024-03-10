<template>
    <AdminLayout :title="course.klass.tag+'科學分管理'" :breadcrumb="breadcrumb">
        <div class="py-6">
            <div class="mx-auto sm:px-6 lg:px-8">
                <div>學段狀態: {{ showCurrentTerm() }}</div>
                <inertia-link :href="route('manage.klasses.show', course.klass_id)" class="ant-btn mr-4">Back</inertia-link>
                <a-button v-for="term in yearTerms" @click="selectedTerm = term.value" class="mr-4"
                    :type="selectedTerm == term.value ? 'primary' : ''">{{ term.label }}</a-button>
                <a-button type="secondary" @click="onClickAddScoreColumn" :disabled="disabledByTerm()">新增學分欄</a-button>
            </div>
        </div>
        <div class="py-6">
            <div class="mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <table class="itxst" component='VueDraggableNext' animation="500" force-fallback="true" width="100%">
                        <thead>
                            <tr>
                                <td width="20px">#</td>
                                <th>代號</th>
                                <th>學段</th>
                                <th>學分欄名稱</th>
                                <th>計算方式</th>
                                <th>成積表分數</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <draggable tag="tbody" class="dragArea list-group w-full" :list="scoreColumns" @change="rowChange">
                            <transition-group v-for="(record, idx) in scoreColumns" :key="record.id">
                                <tr v-if="record.term_id == selectedTerm">
                                    <td>
                                        <svg width="16px" height="16px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M8 6.5C9.38071 6.5 10.5 5.38071 10.5 4C10.5 2.61929 9.38071 1.5 8 1.5C6.61929 1.5 5.5 2.61929 5.5 4C5.5 5.38071 6.61929 6.5 8 6.5Z" fill="#000000"></path> <path d="M15.5 6.5C16.8807 6.5 18 5.38071 18 4C18 2.61929 16.8807 1.5 15.5 1.5C14.1193 1.5 13 2.61929 13 4C13 5.38071 14.1193 6.5 15.5 6.5Z" fill="#000000"></path> <path d="M10.5 12C10.5 13.3807 9.38071 14.5 8 14.5C6.61929 14.5 5.5 13.3807 5.5 12C5.5 10.6193 6.61929 9.5 8 9.5C9.38071 9.5 10.5 10.6193 10.5 12Z" fill="#000000"></path> <path d="M15.5 14.5C16.8807 14.5 18 13.3807 18 12C18 10.6193 16.8807 9.5 15.5 9.5C14.1193 9.5 13 10.6193 13 12C13 13.3807 14.1193 14.5 15.5 14.5Z" fill="#000000"></path> <path d="M10.5 20C10.5 21.3807 9.38071 22.5 8 22.5C6.61929 22.5 5.5 21.3807 5.5 20C5.5 18.6193 6.61929 17.5 8 17.5C9.38071 17.5 10.5 18.6193 10.5 20Z" fill="#000000"></path> <path d="M15.5 22.5C16.8807 22.5 18 21.3807 18 20C18 18.6193 16.8807 17.5 15.5 17.5C14.1193 17.5 13 18.6193 13 20C13 21.3807 14.1193 22.5 15.5 22.5Z" fill="#000000"></path> </g></svg>
                                    </td>
                                    <td>{{ record.column_letter }}</td>
                                    <td>{{ yearTerms.find(t => t.value == record.term_id).label }}</td>
                                    <td>{{ record.field_label }}</td>
                                    <td>{{ record.formular }}</td>
                                    <td><span v-if="record.for_transcript">是</span></td>
                                    <td style="width:250px">
                                        <a-button @click="onClickEditScoreColumn(record)" :disabled="disabledByTerm()">修改</a-button>
                                        <span v-if="record.for_transcript == 0">
                                            <a-popconfirm
                                                title="是否確定刪除？刪除後不可返回。"
                                                ok-text="Yes"
                                                cancel-text="No"
                                                @confirm="onClickDeleteScoreColumn(record.id)"
                                            >
                                                <a-button :disabled="disabledByTerm()">刪除</a-button>
                                            </a-popconfirm>
                                        </span>
                                    </td>
                                </tr>
                            </transition-group>
                        </draggable>
                    </table>
                    <p class="float-right pr-5">學年總分計算方式：{{ yearFinalFormular() }}</p>
                </div>
            </div>
        </div>

        <div class="py-6">
            <div class="mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-button type="primary" @click="storeAllScores" :disabled="disabledByTerm()">更新並保存</a-button>
                    <a-button @click="sampleData" :disabled="disabledByTerm()">Sample Data</a-button>
                    <table id="dataTable" ref="dataTable">
                        <thead>
                            <tr>
                                <th>學生編號</th>
                                <th>學生姓名</th>
                                <template v-for="(column, idx) in scoreColumns">
                                    <th v-if="column.term_id == selectedTerm">
                                        <span :title="column.formular">
                                            ( {{ column.column_letter }} ) {{ column.field_label }}
                                            <span v-if="column.formular">*</span>
                                        </span>
                                    </th>
                                </template>
                                <td>全年總平均分</td>
                            </tr>
                        </thead>
                        <template v-for="(student, sid) in studentsScores">
                            <tr>
                                <td class="text-center">{{ student.student_number }}</td>
                                <td>{{ student.student_name }}</td>
                                <template v-for="column in scoreColumns">
                                    <template v-for="(score, cid) in student.scores">
                                        <td v-if="column.term_id == selectedTerm && column.id == cid" class="text-center">
                                            <span v-if="column.merge || column.formular">
                                                {{ score.point }} 
                                            </span>
                                            <span v-else>
                                                <a-input v-if="!disabledByTerm()"
                                                    v-model:value="score.point" 
                                                    @blur="onScoreCellChange(student)"
                                                    @keyup.arrow-keys="onKeypressed"
                                                />
                                                <span v-else>
                                                    {{score.point}}
                                                </span>
                                            </span>

                                        </td>
                                    </template>
                                </template>
                                <template v-for="column in scoreColumns">
                                    <td v-if="column.term_id == 9" class="text-center">{{ student.scores[column.id].point }}</td>
                                </template>
                            </tr>
                        </template>
                    </table>
                </div>
            </div>
        </div>

        <a-modal v-model:visible="modal.isOpen" :title="modal.title" @ok="handleScoreColumnChange">
            <a-form :model="modal.data" name="course_score" ref="modalScoreColumn" @finish="onModalFinish" :label-col="{span:6}">
                <a-form-item label="學段" :name="['term_id']" >
                    <a-select v-model:value="modal.data.term_id" :options="yearTerms" :disabled="true"/>
                </a-form-item>
                <a-form-item label="學分欄名稱 " :name="['field_label']"
                    :rules="[{ required: true, message: 'Please input score column name' }]">
                    <a-input v-model:value="modal.data.field_label" />
                </a-form-item>
                <a-form-item label="序號" :name="['sequence']">
                    <a-input v-model:value="modal.data.sequence" />
                </a-form-item>
                <a-form-item label="計算公式" :name="['formular']">
                    <a-input v-model:value="modal.data.formular"
                        @change="() => { modal.data.formular = modal.data.formular.toUpperCase() }" />
                </a-form-item>
                <a-form-item label="簡介" :name="['description']">
                    <a-input v-model:value="modal.data.description" />
                </a-form-item>


                <div v-if="modal.data.can_merge">
                    <a-divider style="height: 2px; background-color: #7cb305" />

                    <label>分數合計欄</label>
                    <ol class="ml-5">
                        <li v-for="(item, idx) in modal.data.merge" class="list-disc">
                            <div class="flow-root">
                                {{ mergeItem(item) }}
                                <a @click="deleteMerge(idx)" class="float-right"
                                    v-if="$page.props.currentUserRoles.includes('admin')">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                        stroke-width="1.5" stroke="red" class="w-4 h-4">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                            d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                                    </svg>
                                </a>
                            </div>
                        </li>
                    </ol>
                    <a-collapse v-if="$page.props.currentUserRoles.includes('admin')">
                    <a-collapse-panel key="1" header="新增分數合計">
                        <a-form-item label="科目">
                            <a-select v-model:value="merge.course_id"
                                :options="klassCourses.map(c => ({ value: c.id, label: c.code + '-' + c.title_zh }))"
                                @change="onChangeMergeCourse"></a-select>
                        </a-form-item>
                        <a-form-item label="分數欄">
                            <a-select v-model:value="merge.score_column_id"
                                :options="modal.data.scoreColumnOptions"></a-select>
                        </a-form-item>
                        <a-form-item label="比例">
                            <a-input v-model:value="merge.percentage" />
                            <span>(%，百份比)</span>
                        </a-form-item>
                        <a-button @click="addMerge">Add</a-button>
                    </a-collapse-panel>
                </a-collapse>

                </div>

            </a-form>
        </a-modal>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { ContactsOutlined } from '@ant-design/icons-vue';
import { defaultsDeep } from 'lodash';
import { VueDraggableNext } from 'vue-draggable-next'

export default {
    components: {
        AdminLayout,
        draggable: VueDraggableNext,
    },
    props: ['yearTerms', 'course', 'scoreColumns', 'studentsScores', 'klassCourses'],
    data() {
        return {
            breadcrumb:[
                {label:"Manage", url:route('manage')},
                {label:"年級班別", url:route('manage.grades.index',{'type':'secondary'})},
                {label:this.course.klass.tag+'科學分管理' ,url:null},
            ],
            merge: {
                course_id: null,
                score_column_id: null,
                percentage: null,
            },
            selectedTerm: 1,
            keypressed: "",
            modal: {
                mode: null,
                isOpen: false,
                title: 'Score Column',
                data: {}
            },
            tableCell: {
                row: 0,
                col: 0,
                maxRow: this.studentsScores.length,
                maxCol: this.scoreColumns.length
            },
            scores: [],
            columns: [
                {
                    title: 'Lette',
                    dataIndex: 'letter',
                }, {
                    title: '學段',
                    dataIndex: 'term_id',
                }, {
                    title: '學分欄名稱',
                    dataIndex: 'field_label',
                }, {
                    title: '分類',
                    dataIndex: 'type',
                }, {
                    title: '計算方式',
                    dataIndex: 'formular',
                }, {
                    title: '排序',
                    dataIndex: 'sequence',
                }, {
                    title: '操作',
                    dataIndex: 'operation',
                }
            ]

        }
    },
    created() {

    },
    mounted() {
        //add Click EventListenter to dataTable
        this.$refs.dataTable.addEventListener('click', (e) => {
            this.tableCell.row = e.target.closest('tr').rowIndex;
            this.tableCell.col = e.target.closest('td').cellIndex;
        })
        //add KeyDown (ArrowKeys) EventListenter to dataTable
        this.$refs.dataTable.addEventListener('keydown', (e) => {
            switch (e.key) {
                case 'ArrowUp':
                    this.tableCell.row > 1 ? this.tableCell.row-- : '';
                    break;
                case 'ArrowDown':
                    this.tableCell.row < (this.$refs.dataTable.rows.length - 1) ? this.tableCell.row++ : '';
                    //this.tableCell.row<this.tableCell.maxRow?this.tableCell.row++:'';
                    break;
                case 'ArrowLeft':
                    this.tableCell.col > 1 ? this.tableCell.col-- : '';
                    break;
                case 'ArrowRight':
                    this.tableCell.col < (this.$refs.dataTable.rows[0].cells.length - 1) ? this.tableCell.col++ : '';
                    break;
            }
            var input = this.$refs.dataTable.rows[this.tableCell.row].cells[this.tableCell.col].getElementsByTagName("input");
            if (input.length > 0) {
                input[0].focus();
            }
        })
        //onclick of input box, calebrate the row, col values
        //only apply for multiple table in the same page
        const inputs = this.$refs.dataTable.getElementsByTagName("input");
        for (var i = 0; i < inputs.length; i++) {
            inputs[i].addEventListener("focus", (e) => {
                this.tableCell.row = e.target.closest('tr').rowIndex;
                this.tableCell.col = e.target.closest('td').cellIndex;
            })
        }
    },
    methods: {
        onKeypressed(event) {
            this.keypressed = event.keyCode;
        },
        onClickAddScoreColumn() {
            this.modal.data = {};
            this.modal.data.course_id = this.course.id;
            this.modal.data.type = 'SUB';
            this.modal.data.term_id=this.selectedTerm;
            this.modal.data.merge=[];
            this.modal.title = "Add Score Column";
            this.modal.mode = 'ADD';
            this.modal.isOpen = true;
        },
        onClickEditScoreColumn(record) {
            this.modal.data = record;
            if (record.merge == null || record.merge == '') {
                this.modal.data.merge = [];
            } else if (!Array.isArray(record.merge)) {
                this.modal.data.merge = record.merge;
            }
            this.modal.title = "Edit Score Column";
            this.modal.mode = 'EDIT';
            this.modal.isOpen = true;
        },
        onClickDeleteScoreColumn(recordId) {
            this.$inertia.delete(route("manage.course.scoreColumns.destroy",{course:this.course.id,score_column:recordId}), {
                onSuccess: (page) => {
                    console.log(page)
                },
                onError: (error) => {
                    console.log(error);
                }
            });

            console.log("Need to check if the column id already use in score table. need to double confirm or shows the existing score record again.");
            console.log(recordId);
        },
        createScoreColumn(data) {
            this.$inertia.post(route("manage.course.scoreColumns.store",this.course), data, {
                onSuccess: (page) => {
                    this.modal.mode = null;
                    this.modal.isOpen = false;
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
        updateScoreColumn(data) {
            //this.$inertia.put('/manage/score_column/'+data.id, data, {
            console.log(data);
            this.$inertia.put(route("manage.course.scoreColumns.update", {course:this.course,score_column:data.id}), data, {
                onSuccess: (page) => {
                    this.modal.mode = null;
                    this.modal.isOpen = false;
                    this.storeAllScores();
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
        onModalFinish() {
            console.log("modal finish");
        },
        storeAllScores() {
            var data = [];
            Object.entries(this.studentsScores).forEach(([sid, student]) => {
                this.onScoreCellChange(student);
                Object.entries(student.scores).forEach(([cid, score]) => {
                    data.push({
                        course_student_id: score.course_student_id,
                        score_column_id: score.score_column_id,
                        student_id: student.student_id,
                        point: score.point
                    })
                })
            })
            this.$inertia.post(route("manage.course.scores.batchUpdate",this.course), data, {
                onSuccess: (page) => {
                    console.log("update " + page)
                },
                onError: (error) => {
                    console.log(error);
                }

            })
        },
        handleScoreColumnChange() {
            this.$refs.modalScoreColumn.validateFields().then(() => {
                if (this.modal.mode == 'ADD') {
                    this.createScoreColumn(this.modal.data);
                    this.modal.mode = null;
                } else if (this.modal.mode == 'EDIT') {
                    this.updateScoreColumn(this.modal.data);
                }

            }).catch(err => {
                console.log(err);
            })

        },
        onScoreCellChange(student) {
            var fields = [];
            //change year total formular formular
            var termTotals = [];
            this.scoreColumns.forEach((column, idx) => {
                if (column.is_total == 1) {
                    termTotals.push(column.column_letter);
                }
                if (column.term_id == 9) {
                    termTotals.forEach((t, i) => {
                        if(column.formular){
                            column.formular = column.formular.replace('T' + (i + 1), termTotals[i])
                        }
                        
                    })
                }
            })


            this.scoreColumns.forEach(column => {
                var formular = '';
                fields[column.id] = { 'point': '', 'letter': column.column_letter };
                if (column.formular !== null) {
                    formular = column.formular;
                    Object.entries(student.scores).forEach(([columnId, score]) => {
                        formular = formular.replace(score.column_letter, score.point);
                    })
                    try {
                        formular = formular.replace("=", "");
                        student.scores[column.id].point = Math.round(eval(formular) * 100) / 100
                    } catch (error) {
                        console.log('error');
                    }
                }
            })


            //init column letters
            //this.runFormular(this.score_columns, this.scores[key], key);
        },
        runFormular(columns, row, courseStudentId) {
            //console.log(this.studentsScores);
            var fields = {};
            var termTotals = [];
            //init column letters
            columns.forEach(column => {
                if (row.scores[column.id] === undefined) {
                    fields[column.column_letter] = '';
                } else {
                    fields[column.column_letter] = row.scores[column.id];
                }
            })

            //change year total formular formular
            columns.forEach((column, idx) => {
                if (column.is_total == 1) {
                    termTotals.push(column.column_letter);
                }
                if (column.term_id == 9) {
                    termTotals.forEach((t, i) => {
                        //column.formular=column.formular.replace('T'+(i+1),termTotals[i])
                    })
                }
            })

            //loop through all score columns
            columns.forEach((column, idx) => {
                //if column formular is not empty, meaning with formular
                if (column.formular != null) {
                    var fieldName = column.id;
                    var formular = column.formular;
                    //remove "=" from the origianl formular
                    formular = formular.replace("=", "");
                    //replace round as Math.round in the formular
                    formular = formular.replace("ROUND", "Math.round");
                    //replace values to formular, according to the fields values
                    Object.entries(fields).forEach(([key, value]) => {
                        if (value == '') value = 0; //escape formular calculation if any field is empty
                        formular = formular.replace(key, value);
                    });
                    try {
                        row.scores[fieldName] = eval(formular);
                    } catch (error) {
                        console.log("(" + courseStudentId + ")" + row.student_name + ", formular incurrect");
                        console.log(formular);
                    }
                }
            });
        },
        rowChange(event) {
            let i = 1;
            this.scoreColumns.forEach(column => {
                column.sequence = i++
            })
            this.$inertia.post(route("manage.course.scoreColumn.reorder",this.course), this.scoreColumns, {
                onSuccess: (page) => {
                    console.log(page);
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
        sampleData() {
            const total = this.scoreColumns
            Object.entries(this.studentsScores).forEach(([sid, student]) => {
                this.scoreColumns.forEach(column => {
                    student.scores[column.id]['point'] = Math.floor(Math.random() * 100) + 1
                })
            })
            this.storeAllScores();
        },
        getYearAverage(row) {
            return row.scores[this.scoreColumns.find(c => c.term_id == 9).id]
        },
        addMerge() {
            console.log(this.modal.data)
            console.log(this.merge)
            if (this.merge.course_id === null || this.merge.score_column_id === null || this.merge.percentage === null) {
                alert("Please also select Score item and input percentage")
                return false
            }

            this.modal.data.merge.push({ ...this.merge })
        },
        deleteMerge(idx) {
            const selected = this.klassCourses.find(c => c.id == this.modal.data.merge[idx].course_id).title_zh;
            if (confirm('Are you sure to delete: ' + selected)) {
                this.modal.data.merge.splice(idx, 1)
            }
        },
        onChangeMergeCourse(courseId) {
            console.log(this.merge);
            console.log(this.klassCourses)
            this.merge.score_column_id = null;
            var course = this.klassCourses.find(c => c.id == this.merge.course_id)
            if (course) {
                this.modal.data.scoreColumnOptions = course.score_columns.map(sc => ({ value: sc.id, label: sc.field_label }))
            } else {
                this.modal.data.scoreColumnOptions = []

            }
        },
        mergeItem(item) {
            var course = this.klassCourses.find(c => c.id == item.course_id)
            if (course) {
                var scoreFieldLabel = course.score_columns.find(sc => sc.id == item.score_column_id).field_label
                return course.title_zh + ": " + scoreFieldLabel + " : " + item.percentage;
            }
            return 'NaN';
        },
        yearFinalFormular() {
            const yearFinal = this.scoreColumns.find(c => c.term_id == 9)
            return yearFinal ? yearFinal.formular : 'No year final formular';
        },
        disabledByTerm(){
            return !(this.selectedTerm==this.course.current_term);
        },
        showCurrentTerm(){
            if(this.course.current_term==0){
                return '已上鎖';
            }else{
                return this.yearTerms.find(t=>t.value==this.course.current_term).label;
            }
        }

    },

}
</script>

<style>
#dataTable, #dataTable td, #dataTable th {
  border: 1px solid;
}

#dataTable {
  width: 100%;
  border-collapse: collapse;
}
#dataTable input{
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