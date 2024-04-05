<template>
    <AdminLayout title="Healthcares">
        <!-- <p>Klass: {{healthcare.klass.tag}}</p>
        <p>Title: {{healthcare.title}}</p>
        <p>Data: {{healthcare.date}}</p>
        <a-button @click="sampleData">Sample Data</a-button>
        Min: <input v-model="random.min"/>
        Max: <input v-model="random.max"/>
        <a-button @click="saveRecords">Save</a-button> -->
        {{healthcares}}
        <a-button>Create</a-button>
        <a-table :dataSource="healthcares" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <a-button @click="editRecord(record)">修改</a-button>
                    <inertia-link :href="route('medical.healthcares.show',record.id)">Link</inertia-link>
                </template>
                <template v-else>
                    {{ record[column.dataIndex] }}
                </template>
            </template>
        </a-table>
    
        <!-- Modal Start-->
        <a-modal :model="modal.data" v-model:visible="modal.isOpen" :title="modal.title" width="60%" okText="Save" @ok="onFormSubmit">
            <a-form ref="modalForm" :model="modal.data" :rules="rules" layout="vertical" @finish="onFormSubmit" id="modalForm">
                <a-form-item label="Category" name="category">
                    <a-select v-model:value="modal.data.category" :options="categories" @change="onChangeCategory" :disabled="modal.mode=='EDIT'"/>
                </a-form-item>
                <a-form-item label="Title" name="title">
                    <a-input v-model:value="modal.data.title"/>
                </a-form-item>
                <a-form-item label="Date" name="date">
                    <a-date-picker v-model:value="modal.data.date" :format="dateFormat" :valueFormat="dateFormat"/>
                </a-form-item>
                <a-form-item label="Responsible" name="responsible">
                    <a-input v-model:value="modal.data.responsible"/>
                </a-form-item>
                <a-form-item label="Data Fields" name="data_fields">
                    <a-textarea v-model:value="modal.data.data_fields"/>
                </a-form-item>
                <div>
                    <a-button type="default" html-type="submit">新增</a-button>
                </div>

            </a-form>
            
            <!-- <template #footer>
                <a-button key="back" @click="handleCancel">Return</a-button>
                <a-button v-if="modal.mode == 'EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
                <a-button v-if="modal.mode == 'CREATE'" key="Store" type="primary" @click="storeRecord()">Add</a-button>
            </template> -->
        </a-modal>
        <!-- Modal End-->
        

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
    props: ['healthcares'],
    data() {
        return {
            physicals:[],
            random:{
                min:10,
                max:30
            },
            categories:[{
                'value':'FITNESS',
                'label':'Fitness',
                'dataFields':'[{"value":"field_1","label":"Field 1"},{"value":"field_2","label":"Field 2"}]'
            },{
                'value':'WEIGHT',
                'label':'Weight',
                'dataFields':'[{"value":"field_11","label":"Field 11"},{"value":"field_22","label":"Field 22"}]'
            },{
                'value':'SIGHT',
                'label':'Sight',
                'dataFields':'[{"value":"distance","label":"Distance"},{"value":"charactor","label":"Charactor"},{"value":"level","label":"Level"}]'
            }],

            dateFormat: 'YYYY-MM-DD',
            modal: {
                mode: null,
                isOpen: false,
                title: '課外活動',
                data: {}
            },
            columns: [
                {
                    title: '分類',
                    dataIndex: 'category',
                },{
                    title: '標題',
                    dataIndex: 'title',
                },{
                    title: '開始日期',
                    dataIndex: 'start_at',
                },{
                    title: '結束日期',
                    dataIndex: 'finish_at',
                },{
                    title: '有效',
                    dataIndex: 'is_active',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],
            rules:{
            },
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
    },
    methods: {
        onKeypressed(event) {
            this.keypressed = event.keyCode;
        },
        onScoreChange(){
            console.log('value changed');
        },
        addRecord(){
            this.modal.data={}
            this.modal.isOpen=true
        },
        editRecord(record){
            this.modal.data={...record}
            this.modal.isOpen=true
        },
        onChangeCategory(){
            console.log('category changed')
        },
        onFormSubmit(){
            console.log('submit');
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
