<script setup>
import { Link } from '@inertiajs/vue3';
import { UserOutlined } from '@ant-design/icons-vue';
</script>

<template>
    <Link :href="'/'" class="p-3 bg-slate-100 rounded-full">
        <svg class=" h-14 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
            fill="currentColor" viewBox="0 0 24 24">
            <path fill-rule="evenodd"
                d="M12 4a4 4 0 1 0 0 8 4 4 0 0 0 0-8Zm-2 9a4 4 0 0 0-4 4v1a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2v-1a4 4 0 0 0-4-4h-4Z"
                clip-rule="evenodd" />
        </svg>


    </Link>
</template>
