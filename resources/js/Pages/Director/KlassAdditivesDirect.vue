<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別管理...
            </h2>
        </template>
        <p>Klass: {{ klass.tag }}</p>
        <p>Students: {{ klass.student_count }}</p>
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
                                    <th  class="text-center">{{ student.student_number }}</th>
                                    <th>{{student.name_zh}}</th>
                                    <template v-for="additive in additives.templates">
                                        <td v-if="additive.category==additiveSelected">
                                            <a-input 
                                                v-model:value="additives.additives[ksid][additive.reference_code][selectedTermId]" 
                                                @blur="inputOnBlue(ksid,additive.reference_code,additives.additives[ksid])"
                                            />
                                        </td>
                                    </template>
                                </tr>
                            </template>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';


export default {
    components: {
        AdminLayout
    },
    props: ['yearTerms','klass','additives','additiveGroups'],
    data() {
        return {
            selectedTermId:null,
            currentTerm:null,
            additiveSelected:null,
        }
    },
    created(){
        this.currentTerm=this.yearTerms.find(t=>t.value==this.klass.current_term)
        this.selectedTermId=this.klass.current_term
    },
    mounted() {
        this.additiveSelected=this.additiveGroups[0].category
    },
    methods: {
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
        inputOnBlue(ksid,reference_code,additive){
            this.$inertia.post(route("director.klass.additive.directInput",this.klass),{
                klass_student_id:ksid,
                reference_code:reference_code,
                value:additive[reference_code]
            }, {
                onSuccess: (page) => {
                    console.log('input update success!');
                },
                onError: (error) => {
                    console.log(error);
                }
            })


        },
        handleOk() {

        }
    },
}
</script>




