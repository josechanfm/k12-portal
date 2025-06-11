<template>
    <WebLayout title="Student">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Student Dashboard
            </h2>
        </template>
        <div>
            Student Dashboard
            <div>Name: {{ student.name_zh }}</div>
            <div>Gender: {{ student.gender }}</div>
            <div>Date of Birth:{{ student.dob }}</div>
            <div>{{ student.notices }}</div>
        </div>


    </WebLayout>

</template>

<script>
import WebLayout from '@/Layouts/WebLayout.vue';
import { defineComponent, reactive } from 'vue';

export default {
    components: {
        WebLayout,
    },
    props: ['student'],
    data() {
        return {
        }
    },
    methods: {

    },
}
</script>