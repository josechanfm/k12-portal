<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別管理
            </h2>
        </template>
        <p>Klass: {{ klass.tag }}</p>
        <p>Students: {{ klass.student_count }}</p>
        <p>Current Term: {{currentTerm.label}}</p>
        
        <inertia-link :href="route('manage.pre.klass.habits', klass.id)" class="ant-btn">生活習摜</inertia-link>
        <inertia-link :href="route('manage.pre.klass.abilities', klass.id)" class="ant-btn">學習主題</inertia-link>
        <inertia-link :href="route('manage.pre.klass.finalScores', klass.id)" class="ant-btn">期末成績</inertia-link>
        
        <a-divider type="vertical" />
        <inertia-link :href="route('manage.klass.behaviours.index', klass.id)" class="ant-btn">操行</inertia-link>

        <a-divider type="vertical" />
        <template v-if="additiveStyle=='default'">
            <template v-for="group in additiveGroups">
                <inertia-link :href="route('manage.klass.additive',[klass.id,group.category.toLowerCase()])" class="ant-btn">{{group.label}}</inertia-link>
            </template>
        </template>
        <template v-else-if="additiveStyle=='page'">
            <inertia-link :href="route('manage.klass.additive.page', klass.id)" class="ant-btn">單頁模式</inertia-link>
        </template>
        <template v-else-if="additiveStyle=='direct'">
            <inertia-link :href="route('manage.klass.additive.direct', klass.id)" class="ant-btn">直接輸入</inertia-link>
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
                                <th>Operation</th>
                            </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <tr v-for="student in klass.students">
                                <td class="text-left">{{ student.name_zh }}</td>
                                <td>{{student.display_name}}</td>
                                <td>{{student.gender}}</td>
                                <td>{{student.dob}}</td>
                                <td>Personal records </td>
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
    props: ['currentTerm','klass','additiveTemplates','additiveStyle','additiveGroups'],
    data() {
        return {
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




