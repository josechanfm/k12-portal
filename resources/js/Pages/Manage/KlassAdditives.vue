<template>
    <AdminLayout title="Additives" :breadcrumb="breadcrumb">
        <p>當前學段: {{currentTerm.label}}</p>
        <p></p>
        <div>
            {{ selectedTermId }}
            <a-radio-group v-model:value="selectedTermId" button-style="solid">
                <template v-for="term in yearTerms">
                    <a-radio-button :value="term.value">{{term.label}}</a-radio-button>
                </template>
            </a-radio-group>
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
                                        {{ additives['additives'][ksid][column.reference_code] }}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="800px" cancel-text="返回" :ok-button-props="{style:{ display:'none' }}">
            <p>Current Term: {{currentTerm.label}}</p>
            <a-form :model="modal.data.newItem" layout="vertical" @finish="onFinish">
                <a-form-item name="term_id">
                    <a-input v-model:value="modal.data.newItem.term_id" :defaultValue="currentTerm.value" type="hidden"/>
                </a-form-item>
                <a-form-item name="selection" :rules="[{required:true}]">
                    <a-radio-group v-model:value="modal.data.newItem.selection" option-type="button" @change="onChangeSelection">
                        <a-radio-button v-for="column in additives.templates" :value="column.reference_code">{{ column.title_zh }}</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <div v-if="additives.templates[this.modal.data.newItem.selection].format=='TEXT'">
                    <a-form-item label="備註" name="remark" :rules="[{required:true}]"  >
                        <a-textarea v-model:value="modal.data.newItem.remark" :rows="3" />
                    </a-form-item>
                </div>
                <a-row v-else>
                    <a-col :span="3" v-if="!modal.data.disabledVolumn">
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
                            <!-- {{ additives.templates[record.reference_code].title_zh }} : {{ record.value }} - {{ record.submit_at }} -->
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

export default {
    components: {
        AdminLayout, ButtonLink
    },
    props: ['yearTerms','klass','additiveTemplates','additives'],
    data() {
        return {
            breadcrumb:[
                {label:"Manage", url:route('manage')},
                {label:"年級班別", url:route('manage.grades.index',{'type':'secondary'})},
                {label:this.klass.tag+'年級' ,url:route('manage.klasses.show', this.klass.id)},                
                {label:'操行' ,url:null}
            ],
            selectedTermid:null,
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
            this.modal.data.newItem.selection=Object.keys(this.additives.templates)[0]
            console.log(this.modal.data.newItem);
            console.log(this.modal.data.newItem.selection);
        },
        onClickSubmitAdditive(){
            this.$inertia.post(route("manage.additives.store"),this.modal.data.list, {
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
        //add item to modal.data.list
        onFinish(values){
            console.log(this.modal.data);
            this.modal.data.list.push({
                'term_id':this.modal.data.newItem.term_id,
                'klass_student_id':this.modal.data.student.klass_student_id,
                'reference_code':values.selection,
                'value':values.value,
                'remark':values.remark,
            })
            console.log(this.modal.data.list);
            this.initModalNewItem()
        },
        onChangeSelection(){
            this.modal.data.newItem.value=1;
            var item=this.additives.templates[this.modal.data.newItem.selection]
            this.modal.data.disabledVolumn=true;
            this.modal.data.newItem.max=parseInt(item.max)
            return true;

        },
        getRecordItem(record){
            if(this.additives.templates[record.reference_code].format=='TEXT'){
                //return record
                return this.additives.templates[record.reference_code].title_zh + " : " + record.remark + " @" + record.submit_at    
            }
            return this.additives.templates[record.reference_code].title_zh + " : " + record.value + " @" + record.submit_at
        }
    },
}
</script>

