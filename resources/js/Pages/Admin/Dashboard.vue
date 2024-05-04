<template>
    <AdminLayout title="Admin">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                升班操作
            </h2>
        </template>
        <hr/>
        <ul>
            <li v-for="grade in grades">{{ grade.tag }}</li>
        </ul>
        <p>You may change the additiveStyle from Config table "additive_styles"</p>
        <p>本前沒有報名的步聚,新生註冊表自行政人員直𢮷輸入新生資料,然後成為學生,未正式入學。</p>
        <p>所謂正式入學,指分派年級及班別, 可以新生註冊表選擇進入入學功能(分派年級及班別).</p>
        <inertia-link :href="route('admin.registrations.create')" class="ant-btn">Registration 註冊</inertia-link>
        <inertia-link :href="route('admin.enrollments.create')" class="ant-btn">Enrollement 入學</inertia-link>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['currentYear','grades'],
    data() {
        return {
        }
    },
    methods: {
    }
}
</script>

