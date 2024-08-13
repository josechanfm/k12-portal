<template>
  <a-layout class="">

    <!-- side menu -->
    <a-layout-sider class="shadow-md" v-model:collapsed="collapsed" :trigger="null" collapsible
      style="background: #fff">
      <a :href="route('director.dashboard')" class="flex justify-center">
        <div class="h-12 flex items-center">AIMS</div>
      </a>
      <AdminMenu />
    </a-layout-sider>

    <!-- above menu -->
    <a-layout class="!min-h-screen ">
      <a-layout-header class="h-fit rounded-l shadow-md" style="background: #fff; padding: 0">
        <div class="flex h-fit  items-center gap-3">
          <menu-unfold-outlined v-if="collapsed" class="trigger" @click="() => (collapsed = !collapsed)" />
          <menu-fold-outlined v-else class="trigger" @click="() => (collapsed = !collapsed)" />
          <div >
            學校網站
          </div>
          <div >
            資產管理
          </div>
          <div >
            家校通
          </div>
          <div >
            工作評核
          </div>
          <div class="flex-1"></div>
          <div>
            {{ $page.props.user.name }}
          </div>
        </div>
        <!-- 
        <a-space direction="horizontal">
        
        </a-space>
       -->
      </a-layout-header>
      <a-layout-content :style="{ margin: '5px 15px', background: '#fff', minHeight: '50px' }">
        <header class="bg-slate-300/30 py-1 flex justify-between items-center px-3 mb-3 sm:rounded-lg">
          <!-- <div class="gap-1 rounded-lg p-1 flex items-center !font-black text-lg">
            <TagOutlined class="pb-1 !text-sky-700 "></TagOutlined>
            <div class="text-sky-600">{{ title }}</div>
          </div> -->
          <div class="text-xl text-slate-600 font-black">
            <!-- <a-page-header :breadcrumb="{ 'routes': headerBreadcrumb }" :title="title" > -->
            <!-- v-if="breadcrumb <a-page-header :title="title" >
              <template #breadcrumb>
                <template v-for="( crumb,key ) in headerBreadcrumb" >
                  <span v-if=" key+1 == headerBreadcrumb.length"><span class="!text-black">{{ crumb.breadcrumbName }}</span></span>
                  <span v-else><a class="!text-black opacity-50" :href="crumb.path">{{ crumb.breadcrumbName }} </a> ／ </span>
                </template>
              </template>
            </a-page-header> -->
            <TagOutlined class="pb-1  "></TagOutlined> {{ title }}
          </div>

          <nav class="text-sm " v-if="breadcrumb">
            <div class="list-none flex ">
              <div class="breadcrumb-item hidden md:inline" v-for="(item, idx) in breadcrumb">
                <a v-if="item.url" :href="item.url">{{ item.label }}</a>
                <span v-else>{{ item.label }}</span>
                <span class="pl-2 pr-2" v-if="idx < breadcrumb.length - 1">&gt;</span>
              </div>
              <div class="breadcrumb-item block md:hidden">
                <span v-if="breadcrumb.length > 1">
                  <a :href="breadcrumb[breadcrumb.length - 2].url">
                    {{ breadcrumb[breadcrumb.length - 2].label }}
                  </a>
                </span>
                <span v-else>
                  <a :href="route('director.dashboard')">
                    Home
                  </a>
                </span>
              </div>
              <div>
                <span class="pl-2 pr-2">|</span>
                <a href="javascript:history.back();" class="inline">返回</a>
              </div>
              <div>
                <a :href="route('manual', { route: route().current() })" target="_blank">
                  <div class="flex items-center pl-1 pt-0.5">
                    <QuestionCircleOutlined />
                  </div>
                </a>
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
import { ref, onMounted } from 'vue';
import { router } from '@inertiajs/vue3';
import { QuestionCircleOutlined, TagOutlined } from '@ant-design/icons-vue';
import {
  MenuUnfoldOutlined,
  MenuFoldOutlined,
} from '@ant-design/icons-vue';

import AdminMenu from '@/Components/Admin/AdminMenu.vue';

  
const props = defineProps({
  title: String,
  breadcrumb: Object,
});


const headerBreadcrumb = ref([]);

onMounted(() => {
  if (props.breadcrumb) {
    headerBreadcrumb.value = props.breadcrumb.map(x => ({
      path: x.url,
      breadcrumbName: x.label
    }));
  }
});

const showingNavigationDropdown = ref(false);
const selectedKeys = ref(['1']);
const collapsed = ref(false);

const switchToTeam = (team) => {
  router.put(route('current-team.update'), {
    team_id: team.id,
  }, {
    preserveState: false,
  });
};
window.onresize=()=>{
  if(window.innerWidth<=1024){
    collapsed.value=true
  }else{
    collapsed.value=false

  }
}
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