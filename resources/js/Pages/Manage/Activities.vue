<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                課外活動
            </h2>
        </template>
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
        <a-modal :model="modal.data" v-model:visible="modal.isOpen" :title="modal.title" width="100%" okText="Save" @ok="onFinish">
            <template v-for="grade in grades">
                <a-button :value="grade.id" type="primary" class="mr-3 w-15" @click="selectedGrade=grade.id">{{ grade.tag }}</a-button>
            </template>
            <p>&nbsp;</p>
            <template v-for="klass in klasses">
                <a-button v-if="klass.grade_id==selectedGrade" :value="klass.id" type="primary" class="mr-3 w-15" @click="getStudents(klass)">{{ klass.tag }}</a-button>
            </template>
            <table>
                <tr v-for="student in students">
                    <td>{{student.name_zh}}</td>
                    <td>{{student.pivot.score}}</td>
                </tr>
            </table>
            <a-form ref="modalForm" :model="modal.data" layout="vertical" @finish="onFinish" id="modalForm">
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
import { affixProps } from 'ant-design-vue/lib/affix';
import dayjs from 'dayjs';

export default {
    components: {
        AdminLayout,
        dayjs,
    },
    props: ['terms','staffs','extracurriculars','activities','klasses','grades'],
    data() {
        return {
            dateFormat:'YYYY-MM-DD',
            selectedGrade:4,
            students:[],
            modal: {
                mode: null,
                isOpen: false,
                title: '課外活動',
                data: {}
            },
            columns:[
                {
                    title: '學期',
                    dataIndex: 'term_id',
                },{
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
        getStudents(klass){
            axios.get(route('manage.students.getByKlassId',klass.id),{
                klass:klass.id
            }).then(res=>{
                this.students=res.data;
            })
            // this.$inertia.get(route('manage.getByKlassId',klass.id), {
            //     onSuccess: (students) => {
            //         console.log(students)
            //     },
            //     onError: (error) => {
            //         console.log(error);
            //     }
            // });
        },
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
        onFinish(values){
            if(this.modal.mode=='EDIT'){
                this.$inertia.put(route('admin.activities.update',this.modal.data.id),this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }
            if(this.modal.mode=='CREATE'){
                this.$inertia.post(route('admin.activities.store'),this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }
        },
    },
}
</script>
