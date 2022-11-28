<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Klasses in the year
            </h2>
        </template>
        <ul>
            <li v-for="klass in klasses">
                <a :href="'/year/klass/disciplines/'+klass.id">{{klass.grade}}{{klass.initial}}</a>
            </li>
        </ul>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['klasses'],
    data() {
        return {
        }
    },
    methods: {

    },
}
</script>