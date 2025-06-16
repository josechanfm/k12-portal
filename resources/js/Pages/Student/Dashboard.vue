<template>
    <WebLayout title="Student">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Student Dashboard
            </h2>
        </template>
        <div class="p-6">
            <div class="mb-4">
                <h3 class="text-lg font-semibold flex justify-between items-center">
                    <span>Student Information</span>
                </h3>
                <div class="bg-white shadow rounded-lg p-4">
                    <div>Name: {{ student.name_zh }}</div>
                    <div>Gender: {{ student.gender }}</div>
                    <div>Date of Birth:{{ student.dob }}</div>

                </div>
            </div>
            <div v-if="student.messages.length>0">
                <h3 class="text-lg font-semibold flex justify-between items-center">
                    <span>messages</span>
                </h3>
                <div v-for="message in student.messages" :key="message.id" class="bg-white shadow rounded-lg p-4 mb-2">
                    <div class="font-bold">Category: <span class="font-normal">{{ message.category }}</span></div>
                    <div class="font-bold">Title: <span class="font-normal">{{ message.title }}</span></div>
                    <div>Content: {{ message.content }}</div>
                    <a-button type="primary" @click="acknowledgeMessage(message.id)" class="mt-2">Acknowledge</a-button>
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
    props: ['student', 'forms'],
    data() {
        return {
        }
    },
    methods: {

    },
}
</script>