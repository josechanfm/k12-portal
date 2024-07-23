<template>
    <AdminLayout title="Additives" :breadcrumb="breadcrumb">
        <div>學段狀態: {{ currentTerm.label }}</div>
        <a-button v-for="term in yearTerms" @click="selectedTermId = term.value" class="mr-4"
                    :type="selectedTermId == term.value ? 'primary' : ''">{{ term.label }}</a-button>
        <div class="mx-auto pt-5">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div class="ant-table">
                    <div class="ant-table-container">
                        <div class="ant-table-content">
                            <table class="table-layout: auto;">
                                <thead class="ant-table-thead">
                                    <tr>
                                        <th width="60px">編號</th>
                                        <th>學生姓名</th>
                                        <th>調整</th>
                                        <th v-for="column in additives.templates">{{ column.title_zh }}</th>
                                    </tr>
                                </thead>
                                <tbody class="ant-table-tbody">
                                    <tr v-for="(student, ksid) in additives.students">
                                        <td class="text-center">{{ student.student_number }}</td>
                                        <td>{{ student.name_zh }}</td>
                                        <td class="w-24"><a-button @click="onClickStudent(student)">變更</a-button></td>
                                        <td v-for="column in additives.templates">
                                            {{ additives['additives'][ksid][column.reference_code][selectedTermId] }}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <a-modal v-model:open="modal.isOpen" :title="modal.title" width="800px" cancel-text="返回" :ok-button-props="{style:{ display:'none' }}">
            <p>學段狀態:  {{currentTerm.label}}</p>
            <a-form :model="modal.data.newItem" layout="vertical" @finish="onFinish"  v-if="!klass.course_locked && klass.current_term==selectedTermId">
                <a-form-item name="selected" :rules="[{required:true}]">
                    <a-radio-group v-model:value="modal.data.newItem.selected" option-type="button" @change="onChangeNewItemSelectioned">
                        <a-radio-button v-for="column in additives.templates" :value="column.reference_code">{{ column.title_zh }}</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <div v-if="valueInput()">
                    <a-form-item label="數量" name="value" :rules="[{required:true}]" hidden>
                            <a-input-number v-model:value="modal.data.newItem.value" :min="0" :max="modal.data.newItem.max"/>
                    </a-form-item>
                    <a-form-item label="備註" name="remark" :rules="[{required:true}]"  >
                        <a-textarea v-model:value="modal.data.newItem.remark" :rows="3" />
                    </a-form-item>
                </div>
                <a-row v-else>
                    <a-col :span="3">
                        <a-form-item label="數量" name="value" :rules="[{required:true}]">
                            <a-input-number v-model:value="modal.data.newItem.value" :min="0" :max="modal.data.newItem.max"/>
                        </a-form-item>
                    </a-col>
                    <a-col :span="21">
                        <a-form-item label="備註" name="remark">
                            <a-input v-model:value="modal.data.newItem.remark"/>
                        </a-form-item>
                    </a-col>
                </a-row>
                <div>
                    <a-button type="default" html-type="submit">新增</a-button>
                    <a-button @click="onClickSubmitAdditive" type="primary" class="ml-3">保存</a-button>
                    <a-button @click="onClickClearAdditive">Clear</a-button>
                </div>
            </a-form>
            <a-divider style="height: 2px; background-color: #7cb305" />
            <ol>
                <li v-for="item in this.modal.data.list">
                    {{ additives.templates[item.reference_code].title_zh }}
                    {{ item.value }}
                    {{ item.remark }}
                </li>
            </ol>
            <a-collapse accordion>
                <a-collapse-panel key="1" header="歷史記錄">
                    <ol>
                        <li v-for="record in additives['records'][modal.data.student.klass_student_id]">
                            {{ getRecordItem(record) }}
                        </li>
                    </ol>
                    <hr>
                </a-collapse-panel>
            </a-collapse>            
        </a-modal>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import { curry } from 'lodash';

export default {
    components: {
        AdminLayout, ButtonLink
    },
    props: ['yearTerms','klass','additiveTemplates','additives'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('director.dashboard')},
                {label:"年級班別", url:route('director.grades.index',{'type':'secondary'})},
                {label:this.klass.tag+'年級' ,url:route('director.klasses.show', this.klass.id)},                
                {label:'操行' ,url:null}
            ],
            selectedTermId:null,
            selectedTerm:null,
            modal: {
                mode:null,
                isOpen: false,
                title:'Additives',
                data:{}
            },
            columns: [
                {
                    title: 'Name',
                    dataIndex: 'name_zh',
                }, {
                    title: 'Gender',
                    dataIndex: 'gender',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ]
        }
    },
    created(){
        this.currentTerm=this.yearTerms.find(t=>t.value==this.klass.current_term)
        this.selectedTermId=this.klass.current_term
    },
    mounted(){

    },
    methods: {
        onClickStudent(student){
            this.modal.isOpen = true
            this.modal.data.student = {...student}
            this.modal.data.list = []
            this.initModalNewItem()
        },
        initModalNewItem(student){
            this.modal.data.newItem = {term_id:this.currentTerm.value,max:null,value:1}
            this.modal.data.newItem.selected=Object.keys(this.additives.templates)[0]
        },
        onClickSubmitAdditive(){
            this.$inertia.post(route("director.additives.store"),this.modal.data.list, {
                onSuccess: (page) => {
                    this.modal.newItem={term_id:this.currentTerm.value,max:null,value:1};
                    this.modal.isOpen=false;
                    console.log('Cancelled')
                },
                onError: (error) => {
                    console.log(error);
                }
            })
        },
        onClickClearAdditive(){
            this.modal.data.list=[]
        },

        //add item to modal.data.list
        onFinish(values){
            console.log(values);
            console.log(this.modal.data);
            this.modal.data.list.push({
                'term_id':this.modal.data.newItem.term_id,
                'klass_student_id':this.modal.data.student.klass_student_id,
                'reference_code':values.selected,
                'value':values.value,
                'remark':values.remark,
            })
            console.log(this.modal.data.list);
            this.initModalNewItem()
        },
        onChangeNewItemSelectioned(){
            this.modal.data.newItem.value=1;
            var item=this.additives.templates[this.modal.data.newItem.selected]
            this.modal.data.newItem.max=parseInt(item.max)
            return true;

        },
        getRecordItem(record){
            if(this.valueInput()){
                //return record
                return this.additives.templates[record.reference_code].title_zh + " : " + record.remark + " @" + record.submit_at    
            }
            return this.additives.templates[record.reference_code].title_zh + " : " + record.value + " @" + record.submit_at
        },
        valueInput(){
            var item=this.additives.templates[this.modal.data.newItem.selected]
            return item.category=='COMMENT'
        }

    },
}
</script>

