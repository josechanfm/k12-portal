<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別管理
            </h2>
        </template>
        <p>班別: {{ klass.tag }}</p>
        <p>學生人數: {{ klass.student_count }}</p>
        <p>當前學段: {{currentTerm.label}}</p>

        <a-button v-for="term in yearTerms" @click="selectedTermId = term.value" class="mr-4"
            :type="selectedTermId == term.value ? 'primary' : ''">{{ term.label }}</a-button>

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
                                <th width="60px">編號</th>
                                <th width="200px">學生姓名</th>
                                <template v-for="additive in additives.templates">
                                    <th v-if="additive.category==additiveSelected">
                                        {{additive.title_zh}}
                                    </th>
                                </template>
                            </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <template v-for="(student,ksid) in additives.students">
                                <tr>
                                    <th class="text-center">{{ student.student_number }}</th>
                                    <th>
                                        <a @click="showHistory(student)">History
                                            {{student.name_zh}}
                                        </a>
                                    </th>
                                    <template v-for="additive in additives.templates">
                                        <td v-if="additive.category==additiveSelected">
                                            {{ additives.additives[ksid][additive.reference_code][selectedTermId] }}
                                        </td>
                                    </template>
                                </tr>
                            </template>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="100%" cancel-text="返回" :ok-button-props="{style:{ display:'none' }}">
            <p>班別:{{klass.tag}}</p>
            <p>學生名稱:{{modal.data.name_zh}}</p>
            <p>學段狀態:  {{currentTerm.label}}</p>
            <div class="ant-table">
                <div class="ant-table-container">
                    <div class="ant-table-content">
                        <table style="table-layout: auto;">
                            <thead class="ant-table-thead">
                                <tr>
                                    <th>學段</th>
                                    <th>分類</th>
                                    <th>數量</th>
                                    <th>備註</th>
                                    <th>日期</th>
                                    <th>user</th>
                                    <th>確認</th>
                                    <th>日期</th>
                                </tr>
                            </thead>
                            <tbody class="ant-table-tbody">
                                <tr v-for="record in additives.records[modal.data.klass_student_id]">
                                    <td>{{record.term_id}}</td>
                                    <td>{{additives.templates[record.reference_code].title_zh}}</td>
                                    <td>{{record.value}}</td>
                                    <td>{{record.remark}}</td>
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
            <a-form :model="modal.data" layout="vertical" @finish="onFinish" v-if="!klass.lock_courses && selectedTermId==klass.current_term">
                <a-form-item label="term_id" name="term_id" hidden>
                    <a-input v-model:value="modal.data.term_id" />
                </a-form-item>
                <a-form-item label="klass_student_id" name="klass_student_id" hidden>
                    <a-input v-model:value="modal.data.klass_student_id" />
                </a-form-item>
                <a-row>
                    <a-col>
                        <a-form-item label="分類" name="reference_code">
                            <a-select 
                                v-model:value="modal.data.reference_code" 
                                :options="defaultTemplates"
                                    style="width:150px"
                            />
                        </a-form-item>
                    </a-col>
                    <a-col>
                        <a-form-item label="數量" name="value" v-if="valueInput()">
                            <a-input-number
                                v-model:value="modal.data.value"
                                style="width:100px"
                            ></a-input-number>
                        </a-form-item>
                    </a-col>
                </a-row>
                <a-form-item label="備註" name="remark">
                    <a-input v-model:value="modal.data.remark"/>
                </a-form-item>
                <div>
                    <a-button type="default" html-type="submit">新增</a-button>
                </div>
            </a-form>
        </a-modal>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { selectProps } from 'ant-design-vue/lib/vc-select';


export default {
    components: {
        AdminLayout
    },
    props: ['yearTerms','klass','additives','additiveGroups'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Additives',
                data:{}
            },
            selectedTermId:null,
            currentTerm:null,
            additiveSelected:null,
            course: {},
            students:{},
            defaultTemplates:[],
        }
    },
    created(){
        this.currentTerm=this.yearTerms.find(t=>t.value==this.klass.current_term)
        this.selectedTermId=this.klass.current_term

            Object.values(this.additives.templates).forEach(t=>{
                this.defaultTemplates.push({
                    value:t.reference_code,
                    label:t.title_zh
                })
            })

    },
    mounted() {
        this.additiveSelected=this.additiveGroups[0].category
    },
    methods: {
        showHistory(std){
            this.modal.data={...std}
            this.modal.data.reference_code=this.defaultTemplates[0].value
            this.modal.data.term_id=this.currentTerm.value
            this.modal.data.value=1
            this.modal.isOpen=true
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
        onFinish(values){
            let data=[values];
             this.$inertia.post(route("director.additives.store"),data, {
                onSuccess: (page) => {
                    this.modal.data={}
                    this.modal.isOpen=false;
                },
                onError: (error) => {
                    console.log(error);
                }
            })
        },
        valueInput(){
            return this.additives.templates[this.modal.data.reference_code].category!='COMMENT'
        }

    },
}
</script>




