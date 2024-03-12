<template>
    <AdminLayout title="主控台" :breadcrumb="breadcrumb">
        <div>
            <inertia-link :href="route('manage.klass.behaviours.index',defaultKlass.id)" class="ant-btn">操行</inertia-link>
            <inertia-link :href="route('manage.klass.behaviour.adjust',defaultKlass.id)" class="ant-btn">操行調整</inertia-link>
            <inertia-link :href="route('manage.klass.finalScores',defaultKlass.id)" class="ant-btn">期末成績</inertia-link>
            <inertia-link :href="route('manage.klass.transcripts',defaultKlass.id)" class="ant-btn">成積大表</inertia-link>
            <inertia-link :href="route('manage.klass.transcripts',[defaultKlass.id,{type:'summary'}])" class="ant-btn">成積總表</inertia-link>
            <p>The collection of route "manage" is for the general operation management such as serach and preview, which not included setup of year, class or subject etc.</p>
        </div>

    <a-row :gutter="16">
      <a-col :span="8">
        <a-card title="幼稚園" :bordered="false">
          <inertia-link :href="route('manage.grades.index',{'gradeScope':'kindergarten'})" class="ant-btn">班別</inertia-link>
        </a-card>
      </a-col>
      <a-col :span="8">
        <a-card title="小學" :bordered="false">
            <inertia-link :href="route('manage.grades.index',{'gradeScope':'primary'})" class="ant-btn">班別</inertia-link>
        </a-card>
      </a-col>
      <a-col :span="8">
        <a-card title="中學" :bordered="false">
          <inertia-link :href="route('manage.grades.index',{'gradeScope':'secondary'})" class="ant-btn">班別</inertia-link>
        </a-card>
      </a-col>
    </a-row>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['defaultKlass'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台" ,url:null},
            ],
        }
    },
    methods: {
    },
}
</script>

