<script setup>
import {
    Head,
    Link
} from '@inertiajs/vue3';
import { router } from '@inertiajs/vue3';


defineProps({
    canLogin: Boolean,
    canRegister: Boolean,
    laravelVersion: String,
    phpVersion: String,
});
const logout = () => {
    router.post(route('logout'))
}

const goToRoute = (route) => {
    router.visit(route)
}
</script>

<template>
<Head title="Register" />

<div class=" flex items-top justify-center min-h-screen bg-gray-100 dark:bg-gray-900 sm:items-center sm:pt-0">
    <div class="w-1/2 flex  gap-1 ">
        <div class="text-2xl p-4 font-black bg-white flex-1 flex flex-col items-center justify-center">
            <div>Your Account Status</div>
            <div v-if=" $page?.props?.user??false">
                Status : logining <br>
                Username: {{ $page?.props?.user.username }}<br>
                Email: {{ $page?.props?.user.email }}
            </div>
            <div v-else>{{'Non Login' }}</div>

        </div>
        <div class="flex flex-1 flex-rowitems-start gap flex-wrap">
                <a-button class="!w-full !font-black !h-16  !bg-blue-500 !rounded-lg !text-white !text-2xl" @click="goToRoute(route('login'))">login</a-button>
                <a-button  class="!w-full !font-black !h-16  !bg-red-500 !rounded-lg !text-white !text-2xl" @click="logout()">logout</a-button>
                <a-button  class="!w-full !font-black !h-16  !bg-gray-500 !rounded-lg !text-white !text-2xl" @click="goToRoute(route('register'))">register</a-button>
        </div>
    </div>
</div>
</template>
