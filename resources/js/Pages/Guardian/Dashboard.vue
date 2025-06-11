<template>
    <WebLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Guardian Dashboard
            </h2>
        </template>
        <div>
            Guardian Dashboard
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
    props: [],
    data() {
        return {
        }
    },
    methods: {

    },
}
</script>