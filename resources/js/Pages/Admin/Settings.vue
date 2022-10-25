<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import Supplier from '@/Pages/Admin/Supplier.vue';

import { defineComponent, ref } from 'vue';

const activeKey = ref('1');

</script>

<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Dashboard
            </h2>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-tabs v-model:activeKey="activeKey">
                        <a-tab-pane key="1" tab="Tab 1">
                            <Supplier/>
                        </a-tab-pane>
                        <a-tab-pane key="2" tab="Tab 2" force-render>
                            Content of Tab Pane 2
                        </a-tab-pane>
                        <a-tab-pane key="3" tab="Tab 3">
                            Content of Tab Pane 3
                        </a-tab-pane>
                    </a-tabs>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>
