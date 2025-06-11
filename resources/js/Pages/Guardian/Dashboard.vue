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
                        <inertia-link href="#" class="text-sm">Change</inertia-link>
                    </span>
                </h3>

                <div class="bg-white shadow rounded-lg p-4">
                    <div>Name: <span class="font-bold">{{ guardian.name_zh }}</span></div>
                </div>
            </div>

<div>
    <h3 class="text-lg font-semibold flex justify-between items-center">
        <span>Notices</span>
        <span class="text-right">
            <inertia-link href="#"  class="text-sm">History</inertia-link>
        </span>
    </h3>
    
    <div v-for="notice in guardian.notices" :key="notice.id" class="bg-white shadow rounded-lg p-4 mb-2">
        <div class="font-bold">Category: <span class="font-normal">{{ notice.category }}</span></div>
        <div class="font-bold">Title: <span class="font-normal">{{ notice.title }}</span></div>
        <div>Content: {{ notice.content }}</div>
        <a-button type="primary" @click="acknowledgeNotice(notice.id)" class="mt-2">Acknowledge</a-button>
    </div>
</div>



            <div>
                <h3 class="text-lg font-semibold">Student(s)</h3>
                <a-tabs v-model:activeKey="activeTab" class="mb-4">
                    <a-tab-pane
                        v-for="(student, index) in guardian.students"
                        :key="student.id"
                        :tab="student.name_zh"
                    >
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

        <div v-for="course in student.courses" :key="course.id" class="flex flex-col md:flex-row border-b border-gray-200 py-2">
            <div class="flex-1">{{ course.code }}</div>
            <div class="flex-1">{{ course.title_zh }}</div>
            <div class="flex-1">{{ course.score }}</div>
            <div class="flex-1 text-right">
                <a-button type="link" @click="viewCourseDetails(course.id)">View Details</a-button>
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
    props: ['guardian'],
    data() {
        return {
            activeTab: this.guardian.students.length ? this.guardian.students[0].id : null,
        };
    },
    methods: {
        acknowledgeNotice(noticeId) {
            console.log(`Notice ${noticeId} acknowledged.`);
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