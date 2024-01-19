<template>
    <a-layout>
        <a-layout-sider v-model:collapsed="collapsed" :trigger="null" collapsible >
            <inertia-link :href="route('manage')"><div class="logo" >AIMS</div></inertia-link>
            <AdminMenu />
        </a-layout-sider>
        <a-layout>
            <a-layout-header style="background: #fff; padding: 0">
                <menu-unfold-outlined v-if="collapsed" class="trigger" @click="() => (collapsed = !collapsed)" />
                <menu-fold-outlined v-else class="trigger" @click="() => (collapsed = !collapsed)" />
            </a-layout-header>
            <a-layout-content :style="{ margin: '24px 16px', padding: '24px', background: '#fff', minHeight: '280px' }">

              <header class="flex justify-between items-center bg-gray-200 py-4 px-6 mb-5 bg-white shadow sm:rounded-lg">
                <div class="text-lg font-bold">
                  {{ title }}
                </div>
                <nav class="text-sm" v-if="breadcrumb">
                  <ol class="list-none flex">
                    <li class="breadcrumb-item hidden md:inline" v-for="(item, idx) in breadcrumb">
                      <inertia-link v-if="item.url" :href="item.url">{{ item.label }}</inertia-link>
                      <span v-else>{{ item.label }}</span>
                    <span class="pl-2 pr-2" v-if="idx < breadcrumb.length-1">&gt;</span>
                    </li>
                    <li class="breadcrumb-item block md:hidden">
                      <span v-if="breadcrumb.length>1">
                        <inertia-link :href="breadcrumb[breadcrumb.length-2].url">
                          {{ breadcrumb[breadcrumb.length-2].label }}
                        </inertia-link>
                      </span>
                      <span v-else>
                        <inertia-link :href="route('manage')">
                          Home
                        </inertia-link>
                      </span>
                    </li>
                    <li>
                      <span class="pl-2 pr-2">|</span>
                      <a href="javascript:history.back();location.reload();" class="inline">Back</a>
                    </li>
                  </ol>
                  
                </nav>
              </header>
            <main>
              <slot />
            </main>


            </a-layout-content>
        </a-layout>
    </a-layout>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  import { Inertia } from '@inertiajs/inertia';
  
  import {
    MenuUnfoldOutlined,
    MenuFoldOutlined,
  } from '@ant-design/icons-vue';
  
  import AdminMenu from '@/Components/Admin/AdminMenu.vue';
  
  defineProps({
    title: String,
    breadcrumb: Object,
  });
  
  const showingNavigationDropdown = ref(false);
  const selectedKeys= ref(['1']);
  const collapsed= ref(false);
  
  const switchToTeam = (team) => {
    Inertia.put(route('current-team.update'), {
        team_id: team.id,
    }, {
        preserveState: false,
    });
  };
  
  </script>
    
  <style>
  #app .trigger {
    font-size: 18px;
    line-height: 64px;
    padding: 0 24px;
    cursor: pointer;
    transition: color 0.3s;
  }
  
  #app .trigger:hover {
    color: #1890ff;
  }
  
  #app .logo {
    height: 32px;
    background: rgba(255, 255, 255, 0.3);
    margin: 16px;
  }
  
  .site-layout .site-layout-background {
    background: #fff;
  }
  .ant-layout-sider{
    background: #fff;
  }
  .ant-layout-content{
    background: #f0f2f5!important;
  }
  </style>
  