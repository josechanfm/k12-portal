<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別管理
            </h2>
        </template>
        <p>Klass: {{ klass.tag }}</p>
        <p>Students: {{ klass.student_count }}</p>
        <a-radio-group v-model:value="additiveSelected">
            <template v-for="group in additiveGroups">
                <a-radio-button :value="group.category">{{group.label}}</a-radio-button>
            </template>
        </a-radio-group>
        <p>&nbsp;</p>
        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="ant-table-thead">
                            <tr>
                                <th width="200px">Name</th>
                                <template v-for="additive in additives.templates">
                                    <th v-if="additive.category==additiveSelected">
                                        {{additive.title_zh}}
                                    </th>
                                </template>
                            </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <template v-for="student in additives.students">
                                <tr>
                                    <th>
                                        <a @click="showHistory(student)">History
                                            {{student.name_zh}}
                                        </a>
                                    </th>
                                    <template v-for="additive in additives.templates">
                                        <td v-if="additive.category==additiveSelected">
                                            {{additiveSum(student,additive)}}
                                        </td>
                                    </template>
                                </tr>
                            </template>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="100%" >
            {{klass.tag}}
            {{modal.data.name_zh}}
            <div class="ant-table">
                <div class="ant-table-container">
                    <div class="ant-table-content">
                        <table style="table-layout: auto;">
                            <thead class="ant-table-thead">
                                <tr>
                                    <th>分類</th>
                                    <th>數量</th>
                                    <th>日期</th>
                                    <th>user</th>
                                    <th>確認</th>
                                    <th>日期</th>
                                </tr>
                            </thead>
                            <tbody class="ant-table-tbody">
                                <tr v-for="record in modal.data.records">
                                    <td>{{additives.templates[record.reference_code].title_zh}}</td>
                                    <td>{{record.value}}</td>
                                    <td>{{record.assign_at}}</td>
                                    <td>{{record.assign_user}}</td>
                                    <td>{{record.confirmed}}</td>
                                    <td>{{record.confirmed}}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <a-form :model="modal.data" layout="vertical" >
                <a-row>
                    <a-col>
                        <a-form-item label="分類" name="additive">
                            <a-select 
                                v-model:value="modal.data.additive" 
                                :options="defaultTemplates"
                                    style="width:150px"
                            />
                        </a-form-item>
                    </a-col>
                    <a-col>
                        <a-form-item label="數量" name="value">
                            <a-input-number
                                v-model:value="modal.data.value"
                                style="width:100px"
                            ></a-input-number>
                        </a-form-item>
                    </a-col>
                </a-row>
                <a-form-item label="備註" name="remark">
                    <a-input 
                        v-model:value="modal.data.remark"
                    ></a-input>
                </a-form-item>
                <a-form-item>
                    <a-button type="submit">Add</a-button>
                </a-form-item>
            </a-form>
            <p>Demo only the submission not yet implement.</p>
        </a-modal>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';


export default {
    components: {
        AdminLayout
    },
    props: ['klass','additiveTemplates','additives','additiveGroups'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Additives',
                data:{}
            },
            additiveSelected:'ATTENDANCE',
            course: {},
            students:{},
            defaultTemplates:[],
        }
    },
    created(){
            Object.values(this.additives.templates).forEach(t=>{
                this.defaultTemplates.push({
                    value:t.reference_code,
                    label:t.title_zh
                })
            })

    },
    mounted() {
    },
    methods: {
        showHistory(std){
            this.modal.data={...std}
            this.modal.isOpen=true
        },
        additiveSum(student, additive){
            //return additive.reference_code
            //return student.records
            return student.additives[additive.reference_code]
        },
        getAdditivesTemplates(){
            var templates=[];
            Object.values(this.additives.templates).forEach(t=>{
                templates.push({
                    value:t.reference_code,
                    label:t.title_zh
                })
            })
            return templates
        },
        handleOk() {

        }
    },
}
</script>




