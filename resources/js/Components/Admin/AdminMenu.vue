<template>
    <div id="main_menu" >
      <a-menu
        v-model:openKeys="openKeys"
        v-model:selectedKeys="selectedKeys"
        mode="inline"
        theme="light"
        :inline-collapsed="collapsed"
      >
        <template v-for="item in list" :key="item.key">
          <template v-if="!item.children">
            <a-menu-item :key="item.key">
              <template #icon>
                <PieChartOutlined />
              </template>
              {{ item.title }}
            </a-menu-item>
          </template>
          <template v-else>
            <span  v-role="item.roles">
              <sub-menu :key="item.key" :menu-info="item" />
            </span>
             
          </template>
        </template>
        <a-menu-item>
          <a @click='logout'>Logout</a>
        </a-menu-item>
      </a-menu>
    </div>
  </template>
  <script>
  import { defineComponent, ref } from 'vue';
  import { MenuFoldOutlined, MenuUnfoldOutlined, PieChartOutlined, MailOutlined } from '@ant-design/icons-vue'; // you can rewrite it to a single file component, if not, you should config vue alias to vue/dist/vue.esm-bundler.js
  import { Link } from '@inertiajs/inertia-vue3';
  import { Inertia } from '@inertiajs/inertia';

  const logout = () => {
      if(confirm('Sure to logout?')){
        Inertia.post(route('logout'));
      }
  };

  const SubMenu = {
    name: 'SubMenu',
    props: {
      menuInfo: {
        type: Object,
        default: () => ({}),
      },
    },
    template: `
      <a-sub-menu :key="menuInfo.key" >
        <template #icon><MailOutlined /></template>
        <template #title>{{ menuInfo.title }}</template>
        <template v-for="item in menuInfo.children" :key="item.key">
          <template v-if="!item.children">
            <a-menu-item :key="item.key">
              <template #icon>
                <PieChartOutlined />
              </template>
                <Link :href="item.url">
                  {{ item.title }}
                </Link>
            </a-menu-item>
          </template>
          <template v-else>
            <sub-menu :menu-info="item" :key="item.key" />
          </template>
        </template>
      </a-sub-menu>
    `,
    components: {
      PieChartOutlined,
      MailOutlined,
      Link
    },
  };
  const list = [{
    key: '0',
    roles:['master'],
    title: '系統管理',
    children: [{
      key: '0.1',
      title: '全校學科總表',
      url:'/master/subjects',
      route:'master.subjects'
    },{
      key: '0.2',
      title: '學習計劃',
      url:'/master/studies',
    },{
      key: '0.3',
      title: '基力設置',
      url:'/master/theme_templates',
    },{
      key: '0.4',
      title: '成積表欄位',
      url:'/master/transcriptTemplate',
    },{
      key: '0.5',
      title: '系統參數',
      url:'/master/configs',
    },{
      key: '0.6',
      title: '角色及權限',
      url:'/master/roles',
    }],
  },{
    key: '1',
    roles:['master','admin'],
    title: '行政管理',
    children: [{
      key: '1.2',
      title: '學年',
      url:'/admin/years',
    },{
      key: '1.3',
      title: '年級',
      url:'/admin/grades',
    },{
      key: '1.4',
      title: '班別',
      url:'/admin/klasses',
    }],
  },{
    key: '2',
    roles:['master','admin','director'],
    title: '班級管理',
    children: [{
      key: '2.1',
      title: '年級班別',
      url:'/manage/grades',
    },{
      key: '2.2',
      title: '教師',
      url:'/manage/teachers',
    },{
      key: '2.3',
      title: '升班預處理',
      url:'/manage/promotes',
    }],
  },{
    key: '3',
    roles:['teacher'],
    title: '教師',
    children: [{
      key: '3.1',
      title: '任教',
      url:'/teacher',
    }],
  },{
    key: '4',
    roles:['master','admin','director'],
    title: '健康狀況',
    children: [{
      key: '4.1',
      title: '健康記錄',
      url:'/medical',
    },{
      key: '4.2',
      title: '就診記錄',
      url:'/medical/treatments',
    }],
  },{
    key: '5',
    roles:['master','admin','director'],
    title: 'Navigation 4',
    children: [{
      key: '4.1',
      title: 'Navigation 4',
      children: [{
        key: '4.1.1',
        title: 'Option 4.1.1',
      }],
    }],
}];



  export default defineComponent({
    components: {
      'sub-menu': SubMenu,
      MenuFoldOutlined,
      MenuUnfoldOutlined,
      PieChartOutlined,
    },
  
    setup() {
      const collapsed = ref(false);
  
      const toggleCollapsed = () => {
        collapsed.value = !collapsed.value;
      };
  
      return {
        list,
        collapsed,
        toggleCollapsed,
        selectedKeys: ref(['']),
        openKeys: ref(['']),
        logout
      };
    },
  
  });
  </script>
