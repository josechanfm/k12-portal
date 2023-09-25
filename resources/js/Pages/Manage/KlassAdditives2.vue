<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別管理
            </h2>
        </template>
        <p>Klass: {{ klass.tag }}</p>
        <p>Students: {{ klass.student_count }}</p>
        {{additives}}
        <a-radio-group v-model:value="modal.data.additive">
            <a-radio-button value="ATTENDANCE">考勤</a-radio-button>
            <a-radio-button value="PERFORM">獎懲</a-radio-button>
            <a-radio-button value="CONDUCT">操作</a-radio-button>
            <a-radio-button value="COMMENTS">評語</a-radio-button>
            <a-radio-button value="VIOLATION">違規</a-radio-button>
        </a-radio-group>
        <p>&nbsp;</p>
        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="ant-table-thead">
                            <tr>
                                <th width="200px">Name</th>
                                <template v-for="additive in additiveTemplates">
                                    <th v-if="additive.category==modal.data.additive">
                                        {{additive.title_zh}}
                                    </th>
                                </template>
                            </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <tr v-for="student in additives.students">
                                <td>{{student.name_zh}}</td>
                            </tr>
                                <template v-for="additive in additiveTemplates">
                                    <th v-if="additive.category==modal.data.additive">
                                        --
                                    </th>
                                </template>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="100%" >
            {{klass.tag}}
            <a-form :model="modal.data" layout="vertical" >
                <a-form-item label="Additive" name="additive" :rules="[{required:true}]">
                    <a-radio-group v-model:value="modal.data.additive">
                        <a-radio-button value="ATTENDANCE">考勤</a-radio-button>
                        <a-radio-button value="PERFORM">獎懲</a-radio-button>
                        <a-radio-button value="CONDUCT">操作</a-radio-button>
                        <a-radio-button value="COMMENTS">評語</a-radio-button>
                        <a-radio-button value="VIOLATION">違規</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <table border="1" width="100%">
                    <thead>
                        <tr>
                            <th width="200px">Name</th>
                            <template v-for="additive in additiveTemplates">
                                <th v-if="additive.category==modal.data.additive">
                                    {{additive.title_zh}}
                                </th>
                            </template>
                        </tr>
                    </thead>
                    <tr v-for="student in klass.students">
                        <td>{{student.name_zh}}</td>
                    </tr>
                </table>

                <a-form-item label="Student" name="student" :rules="[{required:true}]">
                    <a-select v-model:value="modal.data.student" :options="klass.students" :fieldNames="{value:'id',label:'name_zh'}"></a-select>
                </a-form-item>
            </a-form>
        </a-modal>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';


export default {
    components: {
        AdminLayout
    },
    props: ['klass','additiveTemplates','additives'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Additives',
                data:{additive:'ATTENDANCE'}
            },
            course: {}
            
        }
    },
    mounted() {
    },
    methods: {
        showModal(){
            console.log('showmodal')
            this.modal.isOpen=true
        },
        handleOk() {

        }
    },
}
</script>




