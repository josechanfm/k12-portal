<template>
    <AdminLayout title="分班">

        選擇學年
        <a-select style="width: 120px">
            <a-select-option value="2025">2025</a-select-option>
        </a-select>
        選擇年級
        <a-select style="width: 120px">
            <a-select-option value="p1">P1</a-select-option>
        </a-select>
        選擇𤥦別
        <a-select style="width: 120px">
            <a-select-option value="p1A">P1A</a-select-option>
        </a-select>
        <a-button @click="onClickEnroll">Enroll Selected students</a-button>
        
        <a-table 
            :row-selection="{ onChange: onChangeSelection, selectedRowKeys: selectedItems }" 
            :rowKey="(record) => record.id"
            :dataSource="students.data" 
            :columns="columns" 
            :pagination="pagination" 
            @change="onPaginationChange"
        >
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='operation'">
                    <inertia-link :href="route('admin.enrollments.create',{student_id:record.id})" class="ant-btn">Enroll</inertia-link>
                </template>
                <template v-else>
                    {{record[column.dataIndex]}}
                </template>
            </template>
        </a-table>

        <!-- Modal Start-->
        <a-modal :model="modal.data" v-model:visible="modal.isOpen" :title="modal.title" width="60%" okText="Save" @ok="onFinish">
            <a-form ref="modalForm" :model="modal.data" layout="vertical" @finish="onFinish" id="modalForm">
                <a-form-item label="活動主題" name="title_zh" :rules="[{required:true}]" >
                    <a-input v-model:value="modal.data.title_zh" />
                </a-form-item>
                <a-form-item label="活動簡介" name="description">
                    <a-textarea v-model:value="modal.data.description" placeholder="textarea with clear icon" allow-clear />
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

export default {
    components: {
        AdminLayout,
    },
    props: ['students'],
    data() {
        return {
            pagination:{
                total: this.students.total,
                current:this.students.current_page,
                pageSize:this.students.per_page,
            },
            modal: {
                mode: null,
                isOpen: false,
                title: '課外活動',
                data: {}
            },
            columns:[
                {
                    title: 'Name',
                    dataIndex: 'name_zh',
                },{
                    title: 'Gender',
                    dataIndex: 'gender',
                },{
                    title: 'DOB',
                    dataIndex: 'dob',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],
            selectedItems:[]
        }
    },
    methods: {
        onPaginationChange(page, filters, sorter){
            this.$inertia.get(route('admin.enrollments.index'),{
                page:page.current,
                per_page:page.pageSize,
                //filter:filters,
                //sorter:sorter
            },{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        },

        closeModal() {
            this.isOpen = false;
            this.reset();
            this.editMode = false;
        },
        createRecord() {
            this.modal.data = {};
            this.modal.mode = 'CREATE';
            this.modal.title = "新增課外活動";
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
            this.$inertia.post(route('admin.extracurriculars.store'),this.modal.data, {
                onSuccess: (page) => {
                    this.modal.isOpen = false;
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
        onChangeSelection(a, b) {
            this.selectedItems = a;
        },
        onClickEnroll(){
            console.log(this.selectedItems)
        }
    },
}
</script>