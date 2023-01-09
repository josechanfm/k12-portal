<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import Welcome from '@/Components/Welcome.vue';
</script>

<template>
    <AppLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Dashboard..
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <p>This Dashboard page is not for production, it's to descripting the system structure and design.</p>
                    <a-typography-title :level="3">Year</a-typography-title>
                    <a-typography-title :level="5">Appended Column</a-typography-title>
                    <p>GradeGroup</p>
                    <a-typography-title :level="5">Relationships</a-typography-title>
                    <p>grades</p>
                    <p>klasses</p>
                    <p>courses</p>
                    <p>students</p>
                    <p>currentYear</p>
                    <p>nextYear</p>
                    <hr/>
                    <a-typography-title :level="3">Grade</a-typography-title>
                    <a-typography-title :level="5">Relationships</a-typography-title>
                    <p>klasses</p>
                    <p>year</p>
                    <a-typography-title :level="3">Klass</a-typography-title>
                    <a-typography-title :level="5">Appended Column</a-typography-title>
                    <p>initial:Letter of the class. eg: A, B, C</p>
                    <p>acronym: Also call tag. grade and lattger of the class: eg: P1A</p>
                    <p>student_count: Also called class size. total number of student is the class</p>
                    <p>promoted_count: total number of promoted students in the class, should match with the student_count eventually, to make sure all student had beed planned for the next year.</p>
                    <a-typography-title :level="5">Relationships</a-typography-title>
                    <p>grade: Belongs to which grade</p>
                    <p>courses: Has Many courses</p>
                    <p>students: Has many students</p>
                    <p>promoteTo: </p>
                    <p>klass_scores/{klassId}:</p>
                </div>
            </div>
        </div>
    </AppLayout>
</template>
