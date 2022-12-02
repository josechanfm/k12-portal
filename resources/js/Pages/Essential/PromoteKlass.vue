<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Promote Klass
            </h2>
        </template>

                
        <p>{{klass}}</p>
        <p>{{klassStudents}}</p>
        <ul>
            <li v-for="student in klassStudents.students">{{student.name_zh}}</li>
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
    props: ['klass','klassStudents'],
    data() {
        return {
        }
    },
    methods: {

    },
}
</script>
