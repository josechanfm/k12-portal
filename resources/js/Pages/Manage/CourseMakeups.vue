<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                 {{ course.klass.tag }} {{ course.title_zh }}科 補考名單
                <br/>
                <span v-for="teacher in course.teachers">
                    {{ teacher.name_zh }} 
                    &nbsp;
                </span>
            </h2>
        </template>
        <div class="py-6">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-button type="primary" @click="saveMakups">更新並保存</a-button>
                    <div class="ant-table" >
                        <!-- <div class="ant-table-container">
                            <div class="ant-table-content"> -->
                                <table ref="dataTable" style="table-layout: auto; width:auto">
                                    <thead class="ant-table-thead">
                                        <tr>
                                            <th class="w-64">學生姓名</th>
                                            <th class="w-24">Point</th>
                                        </tr>
                                    </thead>
                                    <tbody class="ant-table-tbody">
                                        <template v-for="(student,sid) in students_makeups">
                                            <tr>
                                                <td>{{ student['student_name'] }}</td>
                                                <td>
                                                    <a-input v-model:value="student['point']"/>
                                                </td>
                                            </tr>
                                        </template>
                                    </tbody>
                                </table>
                                <p>*可在期末成績人設不合格學生進入補考名單</p>
                            <!-- </div>
                        </div> -->
                    </div>

                </div>
            </div>
        </div>

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
    props: ['course','students_makeups'],
    data() {
        return {
            tableCell:{
                row:0,
                col:0,
                maxRow:this.students_makeups,
                maxCol:2
            },

        }
    },
    created(){
        
    },
    mounted() {
        this.$refs.dataTable.addEventListener('click', (e) => {
            this.tableCell.row=e.target.closest('tr').rowIndex;
            this.tableCell.col=e.target.closest('td').cellIndex;
        })

        this.$refs.dataTable.addEventListener('keydown', (e) => {
            console.log(this.tableCell.row)
            console.log(this.tableCell.col)
            switch(e.key){
                case 'ArrowUp':
                    this.tableCell.row>1?this.tableCell.row--:'';
                    break;
                case 'ArrowDown':
                    this.tableCell.row<(this.$refs.dataTable.rows.length-1)?this.tableCell.row++:'';
                    //this.tableCell.row<this.tableCell.maxRow?this.tableCell.row++:'';
                    break;
                case 'ArrowLeft':
                    this.tableCell.col>1?this.tableCell.col--:'';
                    break;
                case 'ArrowRight':
                    this.tableCell.col<(this.$refs.dataTable.rows[0].cells.length-1)?this.tableCell.col++:'';
                    break;
            }
            var input =this.$refs.dataTable.rows[this.tableCell.row].cells[this.tableCell.col].getElementsByTagName("input");
            if(input.length>0){
                input[0].focus();
            }
        })

    },
    methods: {
        onKeypressed(event){
            this.keypressed=event.keyCode;
        },
        saveMakups() {
            console.log(this.students_makeups);
            var data=[];
            Object.entries(this.students_makeups).forEach(([idx,student])=>{
                data.push({'course_student_id':student.course_student_id,'point':student.point})
            });
            this.$inertia.post(route("manage.makeup.update"), {
                'klass_id':this.course.klass_id,
                'data':data
            }, {
                onSuccess: (page) => {
                    console.log(page);
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