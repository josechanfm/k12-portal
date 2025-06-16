<template>
  <WebLayout title="表格" :breadcrumb="breadcrumb">
    <div class="flex-auto pb-3 text-right">
      <!-- <a-button
          :href="route('admin.notice.messages.create',{notice:notice.id})"
          as="link"
          type="primary"
      >
        {{ $t("create_form") }}
      </a-button> -->
    </div>
    <div class="container mx-auto">
      <div class="flex flex-auto gap-2">
        <a-input
          v-model:value="search.name"
          :placeholder="$t('please_input_name')"
          class="w-64"
        ></a-input>
        <a-input
          v-model:value="search.title"
          :placeholder="$t('please_input_title')"
          class="w-64"
        ></a-input>
        <a-button type="primary" @click="searchData">{{ $t("search") }}</a-button>
      </div>
    </div>
    <div class="container mx-auto py-5">
      <div class="bg-white relative shadow rounded-lg overflow-x-auto">
        <a-table :dataSource="messages.data" :columns="columns" :pagination="pagination" @change="onPaginationChange" >
          <template #headerCell="{ column }">
            {{ column.i18n ? $t(column.i18n) : column.title }}
          </template>
          <template #bodyCell="{ column, text, record, index }">
            <template v-if="column.dataIndex == 'operation'">
              <a-button @click="onClickShow(record)">{{ $t("show") }}</a-button>
            </template>
            <template v-else-if="column.type == 'yesno'">
              <span v-if="record[column.dataIndex] == 1">{{ $t("yes") }}</span>
              <span v-else>{{ $t("no") }}</span>
            </template>
            <template v-else-if="column.dataIndex == 'categories'">
              {{ categories.find(c=>c.value==text)?.label }}
            </template>

            <template v-else-if="column.dataIndex == 'entries'">
              {{ record.entries_count }}
            </template>
            <template v-else>
              {{ record[column.dataIndex] }}
            </template>
          </template>
        </a-table>
      </div>
    </div>
    <p></p>

        <!-- Modal Start-->
    <a-modal v-model:open="modal.isOpen" :title="modal.title">
      <a-form :model="modal.data" name="Staff" ref="modalRef" :rules="rules" :validate-messages="validateMessages"
        :label-col="{ span: 4 }" :wrapper-col="{ span: 20 }">
        <a-form-item label="Category" name="category">
          {{ modal.data.category }}
        </a-form-item>
        <a-form-item label="Title" name="title">
          {{ modal.data.title }}
        </a-form-item>
        <a-form-item label="Content" name="content">
          {{ modal.data.content }}
        </a-form-item>
        <a-form-item label="Start at" name="date_start">
          {{ modal.data.date_start }}
        </a-form-item>
        <a-form-item label="Due at" name="date_due">
          {{ modal.data.date_due }}
        </a-form-item>
        <a-form-item label="acknowledge" name="acknowledge">
          {{ modal.data.acknowledge }}
        </a-form-item>
      </a-form>
      <template #footer>
        <a-button key="back" @click="modalCancel">Return</a-button>
        <a-button v-if="modal.mode == 'EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
        <a-button v-if="modal.mode == 'CREATE'" key="Store" type="primary" @click="storeRecord()">Create</a-button>
      </template>

    </a-modal>
  </WebLayout>
</template>

<script>
import WebLayout from "@/Layouts/WebLayout.vue";
import {
  UploadOutlined,
  LoadingOutlined,
  PlusOutlined,
  InfoCircleFilled,
} from "@ant-design/icons-vue";
import Icon, { RestFilled } from "@ant-design/icons-vue";
// import { quillEditor, Quill } from "vue3-quill";
import { message } from "ant-design-vue";

export default {
  components: {
    WebLayout,
    UploadOutlined,
    LoadingOutlined,
    PlusOutlined,
    RestFilled,
    // quillEditor,
    message,
  },
  props: ["guardian","messages","categories"],
  data() {
    return {
      breadcrumb: [{ label: "信息列表", url: null }],
      loading: false,
      imageUrl: null,
      search: {},
      dateFormat:'YYYY-MM-DD',
      pagination: {
        total: this.messages.total,
        current: this.messages.current_page,
        pageSize: this.messages.per_page,
      },
      modal: {
        isOpen: false,
        data: {},
        title: "Modal",
        mode: "",
      },
      columns: [
        {
          title: "Category",
          dataIndex: "category",
        },
        {
          title: "Title",
          dataIndex: "title",
        },
        {
          title: "Operation",
          dataIndex: "operation",
          key: "operation",
        },
      ],
      rules:{
          category:{
              required:true,
          },
          title:{
              required:true,
          },
          date_start:{
              required:true,
          }
      },
      validateMessages:{
          required: '${label} is required!',
          types: {
              email: '${label} is not a valid email!',
              number: '${label} is not a valid number!',
          },
          number: {
              range: '${label} must be between ${min} and ${max}',
          },
      },
      labelCol: {
          style: {
          width: '150px',
          },
      },
      layout2col: {
          labelCol: {
              span: 8,
          },
          wrapperCol: {
              span: 20,
          },
      }

    };
  },
  created() {},
  mounted() {
   
    this.pagination = {
      currentPage: this.route().params.currentPage ?? 1,
      pageSize: this.route().params.pageSize ?? 10,
    };
    this.search = this.route().params.search ?? {};
  },
  methods: {
      onPaginationChange(page, filters, sorter){
        this.$inertia.get(route('admin.messages.index'),{
            page:page.current,
            per_page:page.pageSize,
            //filter:filters,
            //sorter:sorter
        },{
            onSuccess: (page)=>{
                console.log(page);
            },
            onError: (error)=>{
                console.log(error);
            }
        });
    },

    onClickShow(record) {
      this.modal.data = { ...record };
      this.modal.title = "修改";
      this.modal.mode = 'EDIT';
      this.modal.isOpen = true;
    },
    searchData() {
      this.$inertia.get(
        route("admin.notice.messages.index"),
        { search: this.search, pagination: this.pagination },
        {
          onSuccess: (page) => {
            console.log(page);
          },
          preserveState: true,
        }
      );
    },
    modalCancel(){
      this.modal.data={}
      this.modal.isOpen=false
    },

  },
};
</script>
