<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                升班操作
            </h2>
        </template>
        {{ currentYear }}
        <hr/>
        <ul>
            <li v-for="grade in grades">{{ grade }}</li>
        </ul>
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

