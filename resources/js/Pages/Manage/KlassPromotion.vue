<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Year Plan Dashboard
            </h2>
        </template>
        <div class="py-5">
            <KlassSelector routePath="manage.klass.promotes.index" :currentKlass="klass"/>
        </div>
        <!-- <p>Year: {{year}}</p>
        <p>Grades: {{grades}}</p>
        <p>Next Year: {{nextYear}}</p>
        <p>Grade: {{grade}}</p>
        <p>Next Grade: {{nextGrade}}</p>
        <p>Klass: {{klass}}</p>
        <p>Next Klasses: {{nextKlasses}}</p> -->
<!-- 
        <p>Year: {{year}}</p>
        
        <p>Grades:{{grades}}</p>
        <hr>
        <p>{{klassesSubjects}}</p> 
 -->
       <div>
        Selected Item promote to:
        <a-select v-model:value="batchPromoteTo" style="width: 120px">
            <a-select-option :value="0">Reset all</a-select-option>
            <template v-for="klass in nextKlasses">
                <a-select-option :value="klass.id">{{klass.tag}}</a-select-option>
            </template>
        </a-select>
        <a-button @click="confirmBatchPromote">Confirm</a-button>
       </div>
       <div class="float-right">
        <a-button type="primary" @click="confirmPromote">Promote</a-button>
       </div>
       
        
        <table width="100%">
            <thead>
                <tr>
                    <th class="text-left">
                        <a-checkbox @change="selectAll"/> Selection
                    </th>
                    <th class="text-left">Name</th>
                    <th class="text-left">Gender</th>
                    <th class="text-left">Stream</th>
                    <th class="text-left">State</th>
                    <th class="text-left">Promote</th>
                    <th class="text-left">Promote to</th>
                    <th class="text-left">Operation</th>
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
                        actions
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
            batchPromoteTo:null,
            // activeKey:"1",
            // klassColumns: [
            //     {
            //         title: 'Grade',
            //         dataIndex:'grade',
            //     },
            //     {
            //         title: 'Initial',
            //         dataIndex:'initial',
            //     }
            // ],
            // subjectColumns: [
            //     {
            //         title: 'Abbr',
            //         dataIndex:'abbr',
            //     },
            //     {
            //         title: 'Title Zh',
            //         dataIndex:'title_zh',
            //     }
            // ]
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
        }
    },
}
</script>
