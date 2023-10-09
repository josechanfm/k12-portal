<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import Welcome from '@/Components/Welcome.vue';


</script>

<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Dashboard..
            </h2>
        </template>
        <div class="py-12">
                <div class="p-5 bg-white overflow-hidden shadow-xl sm:rounded-lg">
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
                    <a-typography-title :level="3">升班 Promote</a-typography-title>
                    <p>在klass_student table上, 增加了多個欄位,用於區分以學生為單位的 "在學狀況" "文理方向", "升班情況"</p>
                    <p>這表格以在讀班級為單位,換而言之,是某學生在某一年,所在讀的年級與班別.</p>
                    <p>state: 在學狀況</p>
                    <p>stream: 文理方向</p>
                    <p>promote: 當年是否以升班或留班</p>
                    <p>promote_to: 下年升或留至哪一班</p>
                    <a-typography-title :level="3">Course</a-typography-title>
                    <a-typography-title :level="5">Relationships</a-typography-title>
                        <p>belongsToMany('teachers')</p>                    
                    <a-typography-title :level="3">Teacher</a-typography-title>
                    <a-typography-title :level="5">Relationships</a-typography-title>
                        <p>belongsToMany('course')</p>
                        <p>belongsto('staff')</p>
                    <a-typography-title :level="3">Staff</a-typography-title>
                </div>

        </div>
    </AdminLayout>
</template>
