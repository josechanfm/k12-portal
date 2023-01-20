<template>
    <div>
      <a-button v-can="'add'">Add</a-button>
      <a-button v-role="'admin'">Is admin</a-button>
      <a-menu
        v-model:openKeys="openKeys"
        v-model:selectedKeys="selectedKeys"
        mode="inline"
        theme="dark"
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
            <sub-menu :key="item.key" :menu-info="item" />
          </template>
        </template>
      </a-menu>
    </div>
  </template>
  <script>
  import { defineComponent, ref } from 'vue';
  import { MenuFoldOutlined, MenuUnfoldOutlined, PieChartOutlined, MailOutlined } from '@ant-design/icons-vue'; // you can rewrite it to a single file component, if not, you should config vue alias to vue/dist/vue.esm-bundler.js
  import { Link } from '@inertiajs/inertia-vue3';

  const SubMenu = {
    name: 'SubMenu',
    props: {
      menuInfo: {
        type: Object,
        default: () => ({}),
      },
    },
    template: `
      <a-sub-menu :key="menuInfo.key">
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
    key: '1',
    title: 'Essentials',
    children: [{
      key: '1.1',
      title: 'Subject Template',
      url:'/essential/subjectTemplate',
    },{
      key: '1.2',
      title: 'Years',
      url:'/essential/years',
    },{
      key: '1.3',
      title: 'Grades',
      url:'/essential/grades',
    },{
      key: '1.4',
      title: 'Class',
      url:'/essential/klasses',
    }],
  },{
    key: '2',
    title: 'Manage',
    children: [{
      key: '2.1',
      title: 'Grade',
      url:'/manage/grades',
    },{
      key: '2.2',
      title: 'Teacher',
      url:'/manage/teacher',
    },{
      key: '2.3',
      title: 'Promotion',
      url:'/promote',
    }],
  },{
    key: '3',
    title: 'Teacher',
    children: [{
      key: '3.1',
      title: 'Teaching',
      url:'/manage/teaching',
    },{
      key: '3.2',
      title: 'Teacher',
      url:'/manage/teacher',
    },{
      key: '3.3',
      title: 'Promotion',
      url:'/promote',
    }],
  },{
    key: '4',
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
        selectedKeys: ref(['1']),
        openKeys: ref(['2']),
      };
    },
  
  });
  </script>