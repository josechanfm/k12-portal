<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                課外活動
            </h2>
        </template>
        <a-button @click="saveScores">Save</a-button>
        <inertia-link :href="route('director.activities.index')" class="ant-btn">Back</inertia-link>
        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;" id="dataTable" ref="dataTable">
                        <thead class="ant-table-thead">
                            <tr>
                                <th>Klass</th>
                                <th>Student Name</th>
                                <th>Score</th>
                            </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <tr v-for="student in activity.students" class="ant-table-row ant-table-row-level-0">
                                <td class="ant-table-cell">{{ student.klass.tag }}</td>
                                <td class="ant-table-cell">{{ student.name_zh }}</td>
                                <td class="ant-table-cell">
                                    <a-input v-model:value="student.pivot.score"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { affixProps } from 'ant-design-vue/lib/affix';
import dayjs from 'dayjs';

export default {
    components: {
        AdminLayout,
        dayjs,
    },
    props: ['klasses', 'grades','activity'],
    data() {
        return {
            tableCell: {
                row: 0,
                col: 0,
                maxRow: this.activity.students.length,
                maxCol: 1
            },
            columns: [
                {
                    title: 'Klass',
                    dataIndex: 'klass',
                }, {
                    title: 'name',
                    dataIndex: 'name_zh',
                }, {
                    title: 'score',
                    dataIndex: 'score',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ],

        }
    },
    created() {
        // dayjs.locale('en');
    },
    mounted(){
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
    methods:{
        saveScores(){
            var data=[];
            this.activity.students.forEach(std=>{
                data.push({activity_id:this.activity.id,student_id:std.id,klass_id:std.klass.id,score:std.pivot.score});
            })
            console.log(data)
            this.$inertia.put(route('director.activity.students.scores.update', this.activity.id), data, {
                onSuccess: (page) => {
                    console.log(page);
                },
                onError: (error) => {
                    console.log(error);
                }
            });

        }

    }
}
</script>

