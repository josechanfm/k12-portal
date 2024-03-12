<template>
    <AdminLayout title="期末成績" :breadcrumb="breadcrumb">
        <p>點擊紅色不合格分數批准補考</p>
        <div class="py-5">
            <KlassSelector routePath="manage.klass.finalScores" :param="{type:'summary'}" :currentKlass="klass"/>
        </div>
        <div>
            <div class="ant-table">
                <div class="ant-table-container">
                    <div class="ant-table-content">
                        <table class="table-layout: auto;">
                            <thead class="ant-table-thead">
                                <tr>
                                    <th>學生姓名</th>
                                    <th v-for="column in finalScores.score_columns">
                                        {{transcriptTemplates['SUBJECT'][column.course_code][9]['FINAL'].title_zh}}
                                    </th>
                                    <th>不合格單位數</th>
                                </tr>
                            </thead>
                            <tbody class="ant-table-tbody">
                                <template v-for="(student, ksid) in finalScores['students']">
                                    <tr class="ant-table-row ant-table-row-level-0">
                                        <td>{{ student.name_zh }}</td>
                                        <td v-for="column in finalScores.score_columns" class="text-center">
                                            <span v-if="isPassed(finalScores['scores'][ksid][column.course_code]['score'])">
                                                {{finalScores['scores'][ksid][column.course_code]['score']}}
                                            </span>
                                            <span v-else>
                                                <span @click="toMakeup(student, column)" class="text-red-500 font-bold">
                                                    <span :class="column.makeups[ksid] ? 'p-1 rounded-full border-2 border-rose-300' : ''">
                                                            {{finalScores['scores'][ksid][column.course_code]['score']}}
                                                        <span v-if="column.makeups[ksid] && column.makeups[ksid]['point']!==null">
                                                            / {{ column.makeups[ksid]['point'] }}
                                                        </span>
                                                        
                                                    </span>
                                                </span>
                                            </span>
                                        </td>
                                        <td class="text-center">{{ finalScores['scores'][ksid]['fail_units'] }}</td>
                                    </tr>
                                </template>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" 
            :title="modal.title" width="60%" 
        >
        
            <p>班級：{{ klass.tag }}</p>
            <p>學生姓名：{{ modal.data.student.student_name}}</p>{{ modal.data.student.student_id }}
            <p>課目：{{ modal.data.column.course_title}}</p>
            
            <p>學年總分：{{ finalScores['scores'][modal.data.student.pivot.klass_student_id][modal.data.column.id].score }}</p>

            <p>補考分數：

                <span v-if="modal.data.column.makeups[modal.data.student.student_id]">
                    <span v-if="modal.data.column.makeups[modal.data.student.student_id]['point']===null">
                        --
                        <a-button @click="makeupCancel">Cancel</a-button>
                    </span>
                    <span v-else>
                        {{ modal.data.column.makeups[modal.data.student.student_id]['point'] }}
                    </span>
                </span>
                <span v-else>
                    未批准補考
                    <a-button @click="makeupApprove">Apporve</a-button>
                </span>
            
            </p>
            <template #footer>
                <a-button key="back" @click="modalCancel">返回</a-button>
            </template>
        </a-modal>    
        <!-- Modal End-->
        

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import KlassSelector from '@/Components/KlassSelector.vue';

export default {
    components: {
        AdminLayout,
        KlassSelector
    },
    props: ['year','klass', 'transcriptTemplates', 'finalScores'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('manage')},
                {label:"年級班別", url:route('manage.grades.index',{'type':'secondary'})},
                {label:this.klass.tag+'年級' ,url:route('manage.klasses.show', this.klass.id)},
                {label:'期末成績' ,url:null}
            ],
            modal: {
                mode:null,
                isOpen: false,
                title:'補考',
                data:{}
            },
        }
    },
    created() {

    },
    mounted() {
    },
    methods: {
        isPassed(value){
            return value >= parseInt(this.transcriptTemplates['PASSING']['passing'].value)
        },
        migrateTranscripts() {
            if (this.klass.transcript_migrated == 1) {
                if (!confirm('成積表分數已經轉換，是不確定重新轉換？')) {
                    return false;
                }
            } else {
                if (!confirm('是不確定轉換成積表分數？')) {
                    return false;
                }
            }
            this.$inertia.get(route("manage.klass.migrateTranscripts",this.klass.id), {
                onSuccess: (page) => {
                        this.modal.isOpen=false;
                        console.log('Cancelled')
                    },
                    onError: (error) => {
                        console.log(error);
                    }
            })
        },
        toMakeup(student, column) {
            this.modal.data.student=student;
            this.modal.data.column=column;
            this.modal.isOpen = true;
        },
        modalCancel(){
            // this.modal.data.student={};
            // this.modal.data.column={};
            this.modal.isOpen=false;
        },
        makeupCancel(){
            this.$inertia.post(route("manage.makeup.createOrCancel"),{
                mode:'cancel',
                student_id:this.modal.data.student.student_id,
                course_id:this.modal.data.column.course_id
            }, {
                onSuccess: (page) => {
                        this.modal.isOpen=false;
                        console.log('Cancelled')
                    },
                    onError: (error) => {
                        console.log(error);
                    }
            })
        },
        makeupApprove(){
            this.$inertia.post(route("manage.makeup.createOrCancel"),{
                mode:'approve',
                student_id:this.modal.data.student.id,
                course_id:this.modal.data.column.course_id
            }, {
                onSuccess: (page) => {
                    this.modal.isOpen=false;
                        console.log("approved")
                    },
                    onError: (error) => {
                        console.log(error);
                    }

            })
        }
    }
}
</script>

<style>
.dataTable,
.dataTable td,
.dataTable th {
    border: 1px solid;
}

.dataTable {
    width: 100%;
    border-collapse: collapse;
}

.dataTable input {
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