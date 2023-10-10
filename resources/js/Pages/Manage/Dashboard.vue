<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Manage Dashboard
            </h2>
        </template>
        <div>
            <inertia-link :href="route('manage.klass.behaviours.index',defaultKlass.id)" class="ant-btn">Behaviours</inertia-link>
            <inertia-link :href="route('manage.klass.behaviour.adjust',defaultKlass.id)" class="ant-btn">Behaviour adjust</inertia-link>
            <inertia-link :href="route('manage.klass.finalScores',defaultKlass.id)" class="ant-btn">Final Scores</inertia-link>
            <inertia-link :href="route('manage.klass.transcript',defaultKlass.id)" class="ant-btn">Transcript</inertia-link>
            <inertia-link :href="route('manage.klass.transcript',[defaultKlass.id,{type:'summary'}])" class="ant-btn">Transcript Summary</inertia-link>

            <p>The collection of route "manage" is for the general operation management such as serach and preview, which not included setup of year, class or subject etc.</p>
        </div>

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
        }
    },
    methods: {
    },
}
</script>

