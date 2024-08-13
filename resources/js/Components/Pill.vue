<script setup>
import { onMounted, ref } from 'vue';

</script>

<template>
    <div class="flex border rounded-lg h-10">
        <div class="px-2" style="border-right:1px solid gray">
            <slot name="head"></slot>
        </div>

        <div>
            <slot name="body"></slot>
        </div>
    </div>
</template>
