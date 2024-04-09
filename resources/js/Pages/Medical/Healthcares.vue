<template>
    <AdminLayout title="Healthcares">
        <a-button @click="onCreateRecord" class="ant-btn ant-btn-primary">Create</a-button>
        <a-table :dataSource="healthcares.data" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <a-button @click="onEditRecord(record)">修改</a-button>
                    <inertia-link :href="route('medical.healthcares.show',record.id)">Link</inertia-link>
                </template>
                <template v-else-if="column.dataIndex == 'is_active'">
                    {{ record.is_active?'有效':'無效' }}
                </template>
                <template v-else>
                    {{ record[column.dataIndex] }}
                </template>
            </template>
        </a-table>
    
        <!-- Modal Start-->
        <a-modal :model="modal.data" v-model:visible="modal.isOpen" :title="modal.title" width="60%" okText="Save" @ok="onFormSubmit">
            <a-form ref="modalForm" :model="modal.data" :rules="rules" :label-col="{ span: 4 }" @finish="onFormSubmit" id="modalForm">
                <a-form-item label="Category" name="category">
                    <a-select v-model:value="modal.data.category" :options="categories" @change="onChangeCategory" :disabled="modal.mode=='EDIT'"/>
                </a-form-item>
                <a-form-item label="Title" name="title">
                    <a-input v-model:value="modal.data.title"/>
                </a-form-item>
                <a-row>
                    <a-col :span="12">
                        <a-form-item label="Start at" name="start_at" :label-col="{ span: 8 }">
                            <a-date-picker v-model:value="modal.data.start_at" :format="dateFormat" :valueFormat="dateFormat"/>
                        </a-form-item>
                    </a-col>
                    <a-col :span="12">
                        <a-form-item label="Finish at" name="finish_at">
                            <a-date-picker v-model:value="modal.data.finish_at" :format="dateFormat" :valueFormat="dateFormat"/>
                        </a-form-item>
                    </a-col>
                </a-row>
                <a-form-item label="Responsible" name="responsible">
                    <a-input v-model:value="modal.data.responsible"/>
                </a-form-item>
                <a-form-item label="Bodycheck columns" name="bodycheck_columns" >
                    <a-select v-model:value="modal.data.bodycheck_columns" mode="multiple" :options="bodycheck_columns"  :disabled="modal.mode=='EDIT'"/>
                </a-form-item>
                <a-form-item label="klass" name="klass_id">
                    <a-select v-model:value="modal.data.klass_tags" mode="tags" :options="klasses" :fieldNames="{value:'tag'}"  :disabled="modal.mode=='EDIT'"/>
                </a-form-item>
                <a-form-item label="Active" name="is_active">
                    <a-switch v-model:checked="modal.data.is_active"/>
                </a-form-item>
            </a-form>
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
    props: ['healthcares','grades','bodycheck_columns'],
    data() {
        return {
            physicals:[],
            klasses:[],
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
                    title: '負責人',
                    dataIndex: 'responsible',
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
        this.grades.forEach(g=>{
            g.klasses.forEach(k=>{
                this.klasses.push(k)
            })
        })
    },
    mounted(){
    },
    methods: {
        onCreateRecord(){
            this.modal.data={}
            this.modal.isOpen=true
        },
        onEditRecord(record){
            this.modal.data={...record}
            // this.modal.data.klasses={...record.klasses} //not really necessary
            // delete this.modal.data.klasses //could be delete
            this.modal.data.klass_tags=record.klasses.map(k=>k.tag)
            this.modal.mode='EDIT'
            this.modal.isOpen=true
        },
        onChangeCategory(){
            console.log('category changed')
        },
        onFormSubmit(){
            this.modal.isOpen=false
            this.modal.data.klass_ids=[];
            this.modal.data.klass_tags.forEach(tag=>{
                this.modal.data.klass_ids.push(this.klasses.find(k=>k.tag==tag).id)
            })
            delete this.modal.data['klass_tags'];
            //delete this.modal.data['klasses']; //could be delete
            console.log(this.modal.data);

            if(this.modal.mode=='EDIT'){
                this.$inertia.put(route("medical.healthcares.update",this.modal.data.id), this.modal.data, {
                    onSuccess: (page) => {
                        console.log(page)
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                })
            }else{
                this.$inertia.post(route("medical.healthcares.store"), this.modal.data, {
                    onSuccess: (page) => {
                        console.log(page)
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                })

            }

        },
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
