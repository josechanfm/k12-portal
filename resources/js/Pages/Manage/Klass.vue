<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別管理
            </h2>
        </template>
        {{klass}}
        <hr>
        {{courses}}
        <p></p>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';


export default {
    components: {
        AdminLayout
    },
    props: ['klass','courses','students'],
    data() {
        return {
        }
    },
    methods: {
    },
}
</script>

