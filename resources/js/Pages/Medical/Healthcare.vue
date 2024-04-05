<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                健康記錄
            </h2>
        </template>
        <!-- <p>Klass: {{healthcare.klass.tag}}</p>
        <p>Title: {{healthcare.title}}</p>
        <p>Data: {{healthcare.date}}</p>
        <a-button @click="sampleData">Sample Data</a-button>
        Min: <input v-model="random.min"/>
        Max: <input v-model="random.max"/>
        <a-button @click="saveRecords">Save</a-button> -->

        <ol>
            <li v-for="klass in healthcare.klasses">
                <a-button @click="clickGetByKlass(klass)">{{ klass.tag }}</a-button>
            </li>
        </ol>
        
        <ol>
            <li v-for="physical in physicals">
                {{ physical.field_name }} - {{ physical.value }} : {{ physical.klass_student.student.name_zh }}
            </li>
        </ol>
        <a-card>
            <table id="dataTable" ref="dataTable">
                <thead>
                    <tr>
                        <td>klass id</td>
                        <td>Student Name</td>
                        <template v-for="field in healthcare.data_fields">
                            <td>{{ field.label }}</td>
                        </template>
                    </tr>
                </thead>
                <template v-for="physical in physicals">
                    <tr>
                        <td>{{ physical.klass_student.klass_id }}</td>
                        <td>{{ physical.klass_student.student.name_zh }}</td>
                        <td>{{ physical.field_name }}</td>
                        <td>{{ physical.value }}</td>
                    </tr>
                </template>
            </table>
        </a-card>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import dayjs from 'dayjs';
import KlassSelector from '@/Components/KlassSelector.vue';
import axios from 'axios';

export default {
    components: {
        AdminLayout,
        dayjs,
        KlassSelector
    },
    props: ['healthcare'],
    data() {
        return {
            physicals:[],
            random:{
                min:10,
                max:30
            },
            dateFormat: 'YYYY-MM-DD',
            tableCell: {
                row: 0,
                col: 0,
                //maxRow: this.healthcare.klass.students.length,
                //maxCol: this.healthcare.data_fields.length
            },

        }
    },
    created() {
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
    methods: {
        onKeypressed(event) {
            this.keypressed = event.keyCode;
        },
        onScoreChange(){
            console.log('value changed');
        },
        saveRecords(){
            this.$inertia.put(route("medical.physicals.update",0), this.healthcare.physicals, {
                    onSuccess: (page) => {

                    },
                    onError: (error) => {
                        console.log(error);
                    }
                })

        },
        sampleData(){
            console.log(this.random);
            this.healthcare.physicals.forEach(physical => {
                physical.value=this.randomBetween(parseInt(this.random.min),parseInt(this.random.max))
            })
        },
        randomBetween(min, max){
            return Math.floor(Math.random() * (max - min + 1) + min)
        },
        clickGetByKlass(klass){
            axios.post(route('medical.healthcare.getByKlass',{healthcare:this.healthcare,klass:klass}))
                .then(response=>{
                    console.log(response.data);
                    this.physicals=response.data
                })
                .catch(error=>{
                    console.log(error);
                })

            console.log(klass);
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
