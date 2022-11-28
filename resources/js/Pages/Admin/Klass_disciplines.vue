<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Disciplines in a Klass
            </h2>
        </template>
        <h3>{{klass.grade}} -{{klass.initial}}</h3>
        <ul>
            <li v-for="discipline in disciplines">
                {{discipline.abbr}} - {{discipline.title_zh}}
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
    props: ['klass','disciplines'],
    data() {
        return {
        }
    },
    methods: {

    },
}
</script>