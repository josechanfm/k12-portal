<script setup>
import ManualLayout from '@/Layouts/ManualLayout.vue';

defineProps({
    manual:Object
});


</script>

<template>
    <ManualLayout title="Help">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Help
            </h2>
        </template>

        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <div id="pure-html" v-html="manual.content"/>
            </div>
        </div>
    </ManualLayout>
</template>
<style scope>
#pure-html {
  all: initial
}

#pure-html * {
  all: revert;
}
</style>