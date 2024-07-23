<template>
  <a-layout>
    <a-layout-sider v-model:collapsed="collapsed" :trigger="null" collapsible>
      </a-button :href="route('director.dashboard')">
        <div class="logo">AIMS</div>
      </inertia-link>
      <AdminMenu />
    </a-layout-sider>
    <a-layout class="!min-h-screen ">
      <a-layout-header class="h-fit" style="background: #fff; padding: 0">
        <menu-unfold-outlined v-if="collapsed" class="trigger" @click="() => (collapsed = !collapsed)" />
        <menu-fold-outlined v-else class="trigger" @click="() => (collapsed = !collapsed)" />
        <a-space direction="horizontal">
          <div class="inline">
            學校網站
          </div>
          <div class="inline">
            資產管理
          </div>
          <div class="inline">
            家校通
          </div>
          <div class="inline">
            工作評核
          </div>
        </a-space>
        <div class="float-right pr-5">
          {{ $page.props.user.name }}
        </div>
      </a-layout-header>
      <a-layout-content :style="{ margin: '10px 10px', background: '#fff', minHeight: '280px' }">
        <header class="flex justify-between items-center bg-gray-200 py-1 px-6 mb-3 bg-white shadow sm:rounded-lg">
          <div class="gap-1 rounded-lg p-1 flex items-center !font-black text-lg">
                <TagOutlined class="pb-1 !text-sky-700 "></TagOutlined>
                <div class="text-sky-600">{{ title }}</div>
          </div>
          <nav class="text-sm " v-if="breadcrumb">
            <div class="list-none flex ">
              <div class="breadcrumb-item hidden md:inline" v-for="(item, idx) in breadcrumb">
                </a-button v-if="item.url" :href="item.url">{{ item.label }}</inertia-link>
                <span v-else>{{ item.label }}</span>
                <span class="pl-2 pr-2" v-if="idx < breadcrumb.length - 1">&gt;</span>
              </div>
              <div class="breadcrumb-item block md:hidden">
                <span v-if="breadcrumb.length > 1">
                  </a-button :href="breadcrumb[breadcrumb.length - 2].url">
                    {{ breadcrumb[breadcrumb.length - 2].label }}
                  </inertia-link>
                </span>
                <span v-else>
                  </a-button :href="route('director.dashboard')">
                    Home
                  </inertia-link>
                </span>
              </div>
              <div>
                <span class="pl-2 pr-2">|</span>
                <a href="javascript:history.back();" class="inline">返回</a>
              </div>
              <div>
                
                  <a :href="route('manual',{route:route().current()})" target="_blank">
                    <div class="flex items-center pl-1 pt-0.5"><QuestionCircleOutlined /></div></a>
                
              </div>
            </div>

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
import { QuestionCircleOutlined ,TagOutlined} from '@ant-design/icons-vue';
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
const selectedKeys = ref(['1']);
const collapsed = ref(false);

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

.ant-layout-sider {
  background: #fff;
}

.ant-layout-content {
  background: #f0f2f5 !important;
}
</style>