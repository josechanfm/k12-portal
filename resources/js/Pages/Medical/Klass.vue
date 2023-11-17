<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                健康記錄
            </h2>
        </template>
        <div class="py-5">
            <KlassSelector routePath="medical.klass" :param="[]" :currentKlass="klass" />
            <p></p>
            <inertia-link :href="route('medical.klass.medicnotes.index',klass)" class="ant-btn">健康記錄</inertia-link>    
        </div>
        
        {{klass.tag}}
        <p>Physicals</p>
        <a-button @click="createRecord" class="ant-btn ant-btn-primary">Create </a-button>
        <a-table :dataSource="klass.healthcares" :columns="columns">
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

export default {
    components: {
        AdminLayout,
        dayjs,
        KlassSelector
    },
    props: ['klass'],
    data() {
        return {
            dateFormat: 'YYYY-MM-DD',
            categories:[{
                'value':'FITNESS',
                'label':'Fitness',
                'dataFields':'[{"value":"field_1","label":"Field 1"},{"value":"field_2","label":"Field 2"}]'
            },{
                'value':'WEIGHT',
                'label':'Weight',
                'dataFields':'[{"value":"field_11","label":"Field 11"},{"value":"field_22","label":"Field 22"}]'
            }],
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
                }, {
                    title: '標題',
                    dataIndex: 'title',
                }, {
                    title: '日期',
                    dataIndex: 'date',
                }, {
                    title: '負責人',
                    dataIndex: 'responsible',
                }, {
                    title: '資料欄',
                    dataIndex: 'data_fields',
                }, {
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],
            rules:{
            },

        }
    },
    created() {
    },
    mounted(){
    },
    methods: {
        createRecord() {
            this.modal.data = { 
                klass_id:this.klass.id
            }
            this.modal.mode = 'CREATE'
            this.modal.title = '新增'
            this.modal.isOpen = true
        },
        editRecord(record) {
            this.modal.data = { ...record }
            this.modal.data.data_fields=JSON.stringify(record.data_fields);
            this.modal.mode = 'EDIT'
            this.modal.title = "修改"
            this.modal.isOpen = true
        },
        onChangeCategory(){
            this.modal.data.data_fields=this.categories.find(c=>c.value==this.modal.data.category).dataFields;
            console.log(this.categories.find(c=>c.value==this.modal.data.category));

        },
        onFormSubmit(){
            console.log(this.modal.mode)
            if(this.modal.mode=='CREATE'){
                this.$inertia.post(route("medical.healthcares.store"), this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen=false
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                })

            }else{
                this.$inertia.put(route("medical.healthcares.update",this.modal.data.id), this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen=false
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                })
            }
        }

    },
}
</script>
