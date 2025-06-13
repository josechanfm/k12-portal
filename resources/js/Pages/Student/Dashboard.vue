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


        <div class="p-6">
            <div class="mb-4">
                <h3 class="text-lg font-semibold flex justify-between items-center">
                    <span>Guardian Information</span>
                    <span class="text-right">
                        <inertia-link href="#" class="text-sm">Change</inertia-link>
                    </span>
                </h3>

                <div class="bg-white shadow rounded-lg p-4">
                    <div>Name: <span class="font-bold">{{ student.name_zh }}</span></div>
                </div>
            </div>


<div>
    <h3 class="text-lg font-semibold flex justify-between items-center">
        <span>Notices</span>
        <span class="text-right">
            <inertia-link href="#"  class="text-sm">History</inertia-link>
        </span>
    </h3>
    
    <div v-for="notice in student.notices" :key="notice.id" class="bg-white shadow rounded-lg p-4 mb-2">
        <div class="font-bold">Category: <span class="font-normal">{{ notice.category }}</span></div>
        <div class="font-bold">Title: <span class="font-normal">{{ notice.title }}</span></div>
        <div>Content: {{ notice.content }}</div>
        <a-button type="primary" @click="acknowledgeNotice(notice.id)" class="mt-2">Acknowledge</a-button>
    </div>
</div>
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
    props: ['student','forms'],
    data() {
        return {
        }
    },
    methods: {

    },
}
</script>