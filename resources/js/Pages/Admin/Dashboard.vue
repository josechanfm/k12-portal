<template>
    <AdminLayout title="Admin">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                升班操作
            </h2>
        </template>
        <hr/>
        <ul>
            <li v-for="grade in grades">{{ grade.tag }}</li>
        </ul>

        <p>You may change the additiveStyle from Config table "additive_styles"</p>

        <inertia-link :href="route('admin.registrations.create')" class="ant-btn">Registration</inertia-link>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['currentYear','grades'],
    data() {
        return {
        }
    },
    methods: {
    }
}
</script>

