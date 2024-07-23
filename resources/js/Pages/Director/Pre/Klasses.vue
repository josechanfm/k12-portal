<template>
    <AdminLayout title="班別管理" :breadcrumb="breadcrumb">
        <p>Klass: {{ klass.tag }}</p>
        <p>Students: {{ klass.student_count }}</p>
        <p>Current Term: {{currentTerm.label}}</p>
        
        <a-button as="link" :href="route('director.pre.klass.habits', klass.id)" class="ant-btn">生活習摜</a-button>
        <a-button as="link" :href="route('director.pre.klass.abilities', klass.id)" class="ant-btn">學習主題</a-button>
        
        <a-divider type="vertical" />
        <a-button as="link" :href="route('director.pre.klass.behaviours.index', klass.id)" class="ant-btn">操行</a-button>

        <a-divider type="vertical" />
        <template v-if="additiveStyles=='default'">
            <template v-for="group in additiveGroups">
                <a-button as="link" :href="route('director.pre.klass.additive',[klass.id,group.category.toLowerCase()])" class="ant-btn">{{group.label}}</a-button>
            </template>
        </template>
        <template v-else-if="additiveStyles=='page'">
            <a-button as="link" :href="route('director.pre.klass.additive.page', klass.id)" class="ant-btn">單頁模式</a-button>
        </template>
        <template v-else-if="additiveStyles=='direct'">
            <a-button as="link" :href="route('director.pre.klass.additive.direct', klass.id)" class="ant-btn">直接輸入</a-button>
        </template>


        <p>&nbsp;</p>

        <div class="ant-table">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="ant-table-thead">
                            <tr>
                                <th class="text-left">學生姓名</th>
                                <th>別名</th>
                                <th>性別</th>
                                <th>出生日期</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <tr v-for="student in klass.students">
                                <td class="text-left">{{ student.name_zh }}</td>
                                <td>{{student.display_name}}</td>
                                <td>{{student.gender}}</td>
                                <td>{{student.dob}}</td>
                                <td><a-button as="link" :href="route('director.students.show',student.id)">學生檔案</a-button></td>
                            </tr>
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
    props: ['currentTerm','klass','additiveTemplates','additiveStyles','additiveGroups'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('director.dashboard')},
                {label:"小學", url:route('director.grades.index',{'type':'primary'})},
                {label:this.klass.tag+'班' ,url:null},
            ],
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




