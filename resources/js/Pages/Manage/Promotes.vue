<template>
    <AdminLayout :title="klass.tag+'班升班預處理.'" :breadcrumb="breadcrumb ">
        <div class="py-5">
            <KlassSelector routePath="manage.klass.promotes.index" :currentKlass="klass"/>
        </div>
       <div>
        升班至:
        <a-select v-model:value="batchPromoteTo" style="width: 120px">
            <a-select-option :value="0">Reset all</a-select-option>
            <template v-for="klass in nextKlasses">
                <a-select-option :value="klass.id">{{klass.tag}}</a-select-option>
            </template>
        </a-select>
        <a-button @click="confirmBatchPromote">選擇</a-button>
        <p>須要先建立新學年以、班級以及班別.</p>
       </div>
       <div class="float-right">
          <a-popconfirm
            title="是否確定進行升班處理?"
            ok-text="是"
            cancel-text="否"
            @confirm="confirmPromote"
            @cancel="cancelPromote"
            >
            <a-button type="primary" >確認升班處理</a-button>
          </a-popconfirm>
       </div>
       
        <table width="100%">
            <thead>
                <tr>
                    <th class="text-left">
                        <a-checkbox @change="selectAll"/> 選擇
                    </th>
                    <th class="text-left">姓名</th>
                    <th class="text-left">性別</th>
                    <th class="text-left">文理科</th>
                    <th class="text-left">學籍籍狀態</th>
                    <th class="text-left">升班狀態</th>
                    <th class="text-left">升至</th>
                    <th class="text-left">操作</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="student in students">
                    <td class="text-left">
                        <a-checkbox v-model:checked="student.selected"/>
                    </td>
                    <td class="text-left">
                        {{student.name_zh}}
                    </td>
                    <td class="text-left">
                        {{student.gender}}
                    </td>
                    <td class="text-left">
                        <StudyStream :stream="student.pivot.stream"/>
                    </td>
                    <td class="text-left">
                        {{student.pivot.state}}
                    </td>
                    <td class="text-left">
                        <PromoteState :state="student.pivot.promote"/>
                    </td>
                    <td class="text-left">
                        <a-radio-group v-model:value="student.pivot.promote_to" button-style="solid" @change="student.selected=true">
                            <template v-for="klass in nextKlasses">
                                <a-radio-button :value="klass.id">
                                    {{ klass.tag}}
                                </a-radio-button>
                            </template>
                        </a-radio-group>
                    </td>
                    <td>
                        <inertia-link :href="route('manage.students.show',student.pivot.klass_student_id)" class="ant-btn ant-btn-primary">學生檔案</inertia-link>
                    </td>
                </tr>
            </tbody>
        </table>

        <p></p>
        <div>
            <PromoteState :state="-1"/>
            <PromoteState :state="0"/>
            <PromoteState :state="1"/>
            <PromoteState :state="2"/>
       </div>

       

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';
import PromoteState from '@/Components/PromoteState.vue';
//import PromoteLetters from '@/Components/PromoteLetters.vue';
import StudyStream from '@/Components/StudyStream.vue'
import KlassSelector from '@/Components/KlassSelector.vue';

export default {
    components: {
        AdminLayout,
        PromoteState,
        //PromoteLetters,
        StudyStream,
        KlassSelector
    },
    props: ['year','grades','grade','klass','nextYear','nextGrade','nextKlasses','students'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('manage')},
                {label:"年級班別", url:route('manage.grades.index',{'type':'secondary'})},
                {label:this.klass.tag+'年級' ,url:route('manage.klasses.show', this.klass.id)},
                {label:'升班預處理' ,url:null}
            ],
            batchPromoteTo:null,
        }
    },
    methods: {
        confirmPromote(){
            var data=[]
            this.students.forEach(student=>{
                if(student.selected){
                    data.push({
                        klass_student_id:student.pivot.klass_student_id, 
                        promote_to:student.pivot.promote_to
                    })
                }
            })
            this.$inertia.put(route('manage.klass.promotes.update',this.klass.id), {klassStudents:data}, {
                onSuccess: (page) => {
                    console.log(page)
                },
                onError: (error) => {
                    console.log(error);
                }
            });
            console.log(data)
        },
        cancelPromote(e) {
            console.log(e);
            message.error('Click on No');
        },
        selectAll(event){
            this.students.forEach(student=>{
                student.selected=event.target.checked;
            })
        },
        confirmBatchPromote(){
            if(this.batchPromoteTo==0){
                this.$inertia.get(route('manage.klass.promotes.index',this.klass.id));
            }else{
                var data=[]
                this.students.forEach(student=>{
                    if(student.selected){
                        student.pivot.promote_to=this.batchPromoteTo
                        data.push({
                            klass_student_id:student.pivot.klass_student_id, 
                            promote_to:student.pivot.promote_to
                        })
                    }
                })
            }
        },
    },
}
</script>
