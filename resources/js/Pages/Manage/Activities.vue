<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                課外活動
            </h2>
        </template>
        {{ staffs[0] }}
        <a-button @click="createRecord" type="primary">開設課外活動</a-button>
        <a-table :dataSource="activities" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex == 'operation'">
                    <a-button @click="editRecord(record)">Edit</a-button>
                </template>
                <template v-else>
                    {{record[column.dataIndex]}}
                </template>
                
            </template>
        </a-table>

        <!-- Modal Start-->
        <a-modal :model="modal.data" v-model:visible="modal.isOpen" :title="modal.title" width="60%" okText="Save" @ok="onFinish">
            <a-form ref="modalForm" :model="modal.data" layout="vertical" @finish="onFinish" id="modalForm">
                <a-form-item label="學期" name="term_id" :rules="[{required:true}]" >
                    <a-select v-model:value="modal.data.term_id" :options="terms"/>
                </a-form-item>
                <a-form-item label="活動主題" name="title_zh" :rules="[{required:true}]" >
                    <a-select v-model:value="modal.data.title_zh" :options="extracurriculars" :fieldNames="{value:'title_zh'}"/>
                </a-form-item>
                <a-form-item label="活動簡介" name="description">
                    <a-textarea v-model:value="modal.data.description" placeholder="textarea with clear icon" allow-clear />
                </a-form-item>
                <a-form-item label="開始日期" name="date_start" >
                    <a-date-picker v-model:value="modal.data.date_start" :format="dateFormat" :valueFormat="dateFormat"/>
                </a-form-item>
                <a-form-item label="結束日期" name="date_end"  >
                    <a-date-picker v-model:value="modal.data.date_end"  :format="dateFormat" :valueFormat="dateFormat"/>
                </a-form-item>
                <a-form-item label="負責老師" name="staff_id">
                    <a-select v-model:value="modal.data.staff_id" :options="staffs" :fieldNames="{value:'id',label:'name_zh'}"/>
                </a-form-item>
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

export default {
    components: {
        AdminLayout,
        dayjs,
    },
    props: ['terms','staffs','extracurriculars','activities'],
    data() {
        return {
            dateFormat:'YYYY-MM-DD',
            modal: {
                mode: null,
                isOpen: false,
                title: '課外活動',
                data: {}
            },
            columns:[
                {
                    title: '活動主題',
                    dataIndex: 'title_zh',
                },{
                    title: '開始日期',
                    dataIndex: 'date_start',
                },{
                    title: '結束日期',
                    dataIndex: 'date_end',
                },{
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ],

        }
    },
    created(){
        dayjs.locale('en');
    },

    methods: {
        closeModal() {
            this.isOpen = false;
            this.reset();
            this.editMode = false;
        },
        createRecord() {
            this.modal.data = {};
            this.modal.mode = 'CREATE';
            this.modal.title = "開設課外活動";
            this.modal.isOpen = true;
        },
        editRecord(record) {
            this.modal.data = { ...record };
            this.modal.mode = 'EDIT';
            this.modal.title = "修改課外活動";
            this.modal.isOpen = true;
        },
        storeRecord() {

            this.$refs.submit.click()
            //this.$refs.modalForm.submit()
            console.log('okok...')
/*            
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.post('/admin/klasses/', this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                        console.log(page);
                    },
                    onError: (err) => {
                        console.log(err);
                    }
                });
            }).catch(err => {
                console.log(err);
            });
*/
        },
        updateRecord() {
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.post('/admin/klasses/' + this.modal.data.id, this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });
        },
        onFinish(values){
            this.$inertia.post(route('manage.activities.store'),this.modal.data, {
                onSuccess: (page) => {
                    this.modal.isOpen = false;
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
    },
}
</script>
