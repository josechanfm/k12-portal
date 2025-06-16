<template>
    <WebLayout title="Guardian">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Guardian Dashboard
            </h2>
        </template>
        <div class="p-6">
            <div class="mb-4">
                <h3 class="text-lg font-semibold flex justify-between items-center">
                    <span>Guardian Information</span>
                    <span class="text-right">
                        <inertia-link :href="route('guardian.profile.index')" class="text-sm">Change</inertia-link>
                    </span>
                </h3>

                <div class="bg-white shadow rounded-lg p-4">
                    <div>Name: <span class="font-bold">{{ guardian.name_zh }}</span></div>
                </div>
            </div>

            <div>
                <h3 class="text-lg font-semibold flex justify-between items-center">
                    <span>messages</span>
                    <span class="text-right">
                        <inertia-link :href="route('guardian.messages.index')" class="text-sm">History</inertia-link>
                    </span>
                </h3>

                <div v-for="message in guardian.messages" :key="message.id" class="bg-white shadow rounded-lg p-4 mb-2">
                    <div class="font-bold">Category: <span class="font-normal">{{ message.category }}</span></div>
                    <div class="font-bold">Title: <span class="font-normal">{{ message.title }}</span></div>
                    <div>Content: {{ message.content }}</div>
                    <a-button type="primary" @click="acknowledgeMessage(message.id)" class="mt-2">Acknowledge</a-button>
                </div>
            </div>


            <div v-if="forms.length>0">
                <h3 class="text-lg font-semibold flex justify-between items-center">
                    <span>Forms</span>
                </h3>
                <div v-for="form in forms" :key="form.id" class="bg-white shadow rounded-lg p-4 mb-2">
                    <div class="font-bold">Title: <span class="font-normal">{{ form.title }}</span></div>
                    <div>Content: {{ form.content }}</div>
                    <inertia-link :href="'form?t='+form.uuid" target="_blank">Fill</inertia-link>
                </div>
            </div>

            <div>
                <h3 class="text-lg font-semibold">Student(s)</h3>
                <a-tabs v-model:activeKey="activeTab" class="mb-4">
                    <a-tab-pane v-for="(student, index) in guardian.students" :key="student.id" :tab="student.name_zh">
                        <div class="bg-white shadow rounded-lg p-4">
                            <h4 class="font-bold">Basic Info</h4>
                            <div>ID: {{ student.suid }}</div>
                            <h5 class="mt-4 font-semibold">Courses</h5>

                            <div class="bg-white shadow rounded-lg p-4">
                                <h4 class="font-bold">Basic Info</h4>
                                <div>ID: {{ student.suid }}</div>
                                <h5 class="mt-4 font-semibold">Courses</h5>

                                <div class="flex flex-col">
                                    <div class="flex font-bold border-b border-gray-200 pb-2">
                                        <div class="flex-1">Course Code</div>
                                        <div class="flex-1">Course Title</div>
                                        <div class="flex-1">Score</div>
                                        <div class="flex-1 text-right">Actions</div>
                                    </div>

                                    <div v-for="course in student.courses" :key="course.id"
                                        class="flex flex-col md:flex-row border-b border-gray-200 py-2">
                                        <div class="flex-1">{{ course.code }}</div>
                                        <div class="flex-1">{{ course.title_zh }}</div>
                                        <div class="flex-1">{{ course.score }}</div>
                                        <div class="flex-1 text-right">
                                            <a-button type="link" @click="viewCourseDetails(course.id)">View
                                                Details</a-button>
                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </a-tab-pane>
                </a-tabs>
            </div>

        </div>
    </WebLayout>
</template>

<script>
import WebLayout from '@/Layouts/WebLayout.vue';

export default {
    components: {
        WebLayout,
    },
    props: ['guardian','forms'],
    data() {
        return {
            activeTab: this.guardian.students.length ? this.guardian.students[0].id : null,
        };
    },
    methods: {
        acknowledgeMessage(messageId) {
            console.log(`message ${messageId} acknowledged.`);
        },
        viewCourseDetails(courseId) {
            console.log(`Viewing details for course ${courseId}`);
        },
    },
};
</script>

<style scoped>
/* Additional styles if needed */
</style>