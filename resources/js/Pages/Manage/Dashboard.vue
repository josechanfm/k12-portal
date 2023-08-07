<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Manage Dashboard
            </h2>
        </template>
        {{ $page.props.user }}
        <div>
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
    props: [],
    data() {
        return {
        }
    },
    methods: {
    },
}
</script>

