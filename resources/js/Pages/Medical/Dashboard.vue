<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                健康記錄
            </h2>
        </template>
        <div class="py-5">
            <KlassSelector routePath="medical.klass" :param="[]"  />
        </div>


    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import dayjs from 'dayjs';
import KlassSelector from '@/Components/KlassSelector.vue';

export default {
    components: {
        AdminLayout,
        dayjs,
        KlassSelector
    },
    props: [],
    data() {
        return {
            dateFormat: 'YYYY-MM-DD',
        }
    },
    created() {
    },
    mounted(){
    },
    methods: {
    },
}
</script>
