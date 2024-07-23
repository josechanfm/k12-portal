<template>
    <AdminLayout title="主控台" :breadcrumb="breadcrumb">
        <div v-if="defaultKlass">
            <a-button as="link" :href="route('director.klass.behaviours.index',defaultKlass.id)" class="ant-btn">操行</a-button>
            <a-button as="link" :href="route('director.klass.behaviour.adjust',defaultKlass.id)" class="ant-btn">操行調整</a-button>
            <a-button as="link" :href="route('director.klass.finalScores',defaultKlass.id)" class="ant-btn">期末成績</a-button>
            <a-button as="link" :href="route('director.klass.transcripts',defaultKlass.id)" class="ant-btn">成積大表</a-button>
            <a-button as="link" :href="route('director.klass.transcripts',[defaultKlass.id,{type:'summary'}])" class="ant-btn">成積總表</a-button>
            <a-button as="link" :href="route('director.student.finder')" class="ant-btn">查找學生</a-button>
            <p>The collection of route "Director" is for the general operation management such as serach and preview, which not included setup of year, class or subject etc.</p>
        </div>

    <a-row :gutter="16">
      <a-col :span="8">
        <a-card title="幼稚園" :bordered="false">
          <a-button as="link" :href="route('director.grades.index',{'gradeScope':'kindergarten'})" class="ant-btn">班別</a-button>
        </a-card>
      </a-col>
      <a-col :span="8">
        <a-card title="小學" :bordered="false">
            <a-button as="link" :href="route('director.grades.index',{'gradeScope':'primary'})" class="ant-btn">班別</a-button>
        </a-card>
      </a-col>
      <a-col :span="8">
        <a-card title="中學" :bordered="false">
          <a-button as="link" :href="route('director.grades.index',{'gradeScope':'secondary'})" class="ant-btn">班別</a-button>
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

