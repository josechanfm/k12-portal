<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Teacher
            </h2>
        </template>
        <p></p>
        <div>
            <div class="ant-table">
                <div class="ant-table-container">
                    <div class="ant-table-content">
                        <table class="table-layout: auto;">
                            <thead class="ant-table-thead">
                                <tr>
                                    <th>調整</th>
                                    <th>學生姓名</th>
                                    <th v-for="column in additives.templates">{{ column.title_zh }}</th>
                                </tr>
                            </thead>
                            <tbody class="ant-table-tbody">
                                <tr v-for="student in additives.students">
                                    <td class="w-24"><a-button @click="onClickStudent(student)">變更</a-button></td>
                                    <td>
                                        {{ student.name_zh }}
                                    </td>
                                    <td v-for="column in additives.templates">
                                        {{ student.additives[column.reference_code] }}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="800px" >
            <a-form :model="modal.data.newItem" layout="vertical" @finish="onFinish">
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
                <div class="flex">
                    <a-button type="default" html-type="submit">Add</a-button>
                    <span class="pull-right">
                        <a-button @click="onClickSubmitAdditive" class="primary">Submit</a-button>
                    </span>
                    
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
                        <li v-for="record in this.modal.data.student.records">
                            {{ getRecordItem(record) }}
                            <!-- {{ additives.templates[record.reference_code].title_zh }} : {{ record.value }} - {{ record.submit_at }} -->
                        </li>
                    </ol>
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
    props: ['additives'],
    data() {
        return {
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
    methods: {
        onClickStudent(student){
            this.modal.isOpen = true
            this.modal.data.student = student
            this.modal.data.list = []
            this.initModalNewItem()
        },
        initModalNewItem(student){

            this.modal.data.newItem = {max:null,value:1}
            this.modal.data.newItem.selection=Object.keys(this.additives.templates)[0]
        },
        onClickSubmitAdditive(){
            this.$inertia.post(route("manage.additives.store"),this.modal.data.list, {
                onSuccess: (page) => {
                    this.modal.newItem={max:null,value:1};
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
            this.modal.data.list.push({
                'klass_student_id':this.modal.data.student.klass_student_id,
                'reference_code':values.selection,
                'value':values.value,
                'remark':values.remark,
            })
            this.initModalNewItem()
        },
        onChangeSelection(event){
            this.modal.data.newItem.value=1;
            var item=this.additives.templates[this.modal.data.newItem.selection]
            return this.modal.data.newItem.max=parseInt(item.max)

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

