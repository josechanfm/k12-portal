<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                生活習慣和態度
            </h2>
        </template>
        {{ klassStudent }}
        <a-typography-title :level="3">{{ klassStudent.klass.tag }} : {{ klassStudent.student.name_zh }}</a-typography-title>
        <a-button type="primary" @click="createBehaviour">更新並保存</a-button>
        
        <div class="py-12">
            <div>
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <table id="scoreTable" ref="scoreTable">
                        <tr>
                            <th style="width:100px">
                                學生姓名
                            </th>
                            <th v-for="row in terms">
                                {{ row.label }}
                            </th>
                        </tr>
                        <tr v-for="row in behaviours">
                           <td>{{ row.label }}</td> 
                           <th v-for="row in terms">
                                -
                            </th>
                        </tr>
                    </table>
                </div>
            </div>
        </div>


        <a-modal v-model:visible="modal.isOpen" :title="modal.title" ok-text="保存" cancel-text="取消" @ok="saveBehaviour">
            {{ modal.data }}
            <a-form 
                :model="modal.data"
                name="behaviour"
                ref="modalBehaviour"
                v-bind="layout"
                :rules="rules"
            >
                <a-form-item label="獎徵類別" :name="['term_id']">
                    <a-select
                        v-model:value="modal.data.term_id"
                        :options="terms"
                        style="width:100px"
                    />
                </a-form-item>
                <a-form-item label="獎徵類別" :name="['genre']">
                    <a-select
                        v-model:value="modal.data.genre"
                        :options="behaviours"
                        style="width:100px"
                    />
                </a-form-item>
                <a-form-item label="數目" :name="['qty']">
                    <a-input-number v-model:value="modal.data.qty" :min="1" :max="100"/> 
                </a-form-item>
                <a-form-item label="日期" :name="['date']">
                    <a-date-picker v-model:value="modal.data.date" format="YYYY-MM-DD"/> 
                </a-form-item>
                <a-form-item label="描述" :name="['description']">
                    <a-input v-model:value="modal.data.description"/> 
                </a-form-item>
                <a-form-item label="備註" :name="['remark']" >
                    <a-textarea v-model:value="modal.data.remark"/> 
                </a-form-item>
            </a-form>
        </a-modal>

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
    props: ['klassStudent','behaviours','terms'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Score Column',
                data:{}
            },
            rules:{
                klass_student_id:{
                    required:true,
                },
                genre:{
                    required:true,
                },
                term_id:{
                    required:true,
                },
                qty:{
                    required:true,
                },
                date:{
                    required:true,
                }
            },
            layout: {
                labelCol: {
                    span: 8,
                },
                wrapperCol: {
                    span: 16,
                },
            }
        }
    },
    created(){
        dayjs.locale('en');
    },
    mounted() {

    },
    methods: {
        createBehaviour(){
            this.modal.data={klass_student_id:this.klassStudent.id};
            this.modal.isOpen=true;
            this.modal.title='獎徴遲缺';
            this.modal.mode='CREATE';
            console.log(this.klassStudent.student.name_zh);
        },
        saveBehaviour(){
            this.$inertia.post('/manage/behaviours',this.modal.data, {
                onSuccess: (page) => {
                    console.log(page);
                },
                onError: (error) => {
                    console.log(error);
                }
            })
            console.log(this.modal.data);
        }
    },
}
</script>


<style>
#scoreTable, #scoreTable td, #scoreTable th {
  border: 1px solid;
  border-color: gray

}

#scoreTable {
  width: 100%;
  border-collapse: collapse;
}
table td.crossed, table th.crossed
{
   background-image: linear-gradient(to top right,  transparent calc(50% - 0.5px), black, transparent calc(50% + 1px)); 
}
#scoreTable input{
    text-transform: uppercase;
    text-align: center;
}
</style>

