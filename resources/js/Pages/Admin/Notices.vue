<template>
  <AdminLayout title="表格" :breadcrumb="breadcrumb">
    <div class="container mx-auto">
      <div class="flex flex-auto gap-2">
        <a-input v-model:value="search.name" :placeholder="$t('please_input_name')" class="w-64"></a-input>
        <a-input v-model:value="search.title" :placeholder="$t('please_input_title')" class="w-64"></a-input>
        <a-button type="primary" @click="searchData">{{ $t("search") }}</a-button>
        <div class="flex-auto pb-3 text-right">
          <a-button @click="onClickCreate()" type="primary">新增</a-button>
        </div>
      </div>
    </div>
    <div class="container mx-auto py-5">
      <div class="bg-white relative shadow rounded-lg overflow-x-auto">
        <a-table :dataSource="notices.data" :columns="columns" :pagination="pagination" @change="onPaginationChange" >
          <template #headerCell="{ column }">
            {{ column.i18n ? $t(column.i18n) : column.title }}
          </template>
          <template #bodyCell="{ column, text, record, index }">
            <template v-if="column.dataIndex == 'operation'">
              <a-button :href="route('admin.notice.messages.index', record.id)" type="secondary">
                {{ $t("messages") }}
              </a-button>
              <a-button :href="route('admin.notices.show', record.id)" type="info">
                {{ $t("distribute") }}
              </a-button>
              <a-button @click="onClickEdit(record)">{{ $t("edit") }}</a-button>
              <a-popconfirm :title="$t('confirm_delete_record')" :ok-text="$t('yes')" :cancel-text="$t('no')"
                @confirm="deleteConfirmed(record)" :disabled="record.entries_count > 0">
                <a-button type="primary" ghost danger>{{ $t("delete") }}</a-button>
              </a-popconfirm>
              <a-button @click="backupRecords(record)" v-if="record.entries_count > 0">
                {{ $t("backup") }}
              </a-button>
            </template>
            <template v-else-if="column.type == 'yesno'">
              <span v-if="record[column.dataIndex] == 1">{{ $t("yes") }}</span>
              <span v-else>{{ $t("no") }}</span>
            </template>
            <template v-else-if="column.dataIndex== 'category'">
              {{ categories.find(c=>c.value==text )?.label }}
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
    <a-modal v-model:open="modal.isOpen" width="80%" :title="modal.title">
      <a-form :model="modal.data" name="Staff" ref="modalRef" :rules="rules" :validate-messages="validateMessages"
        :label-col="{ span: 4 }" :wrapper-col="{ span: 20 }">
        <a-form-item label="Category" name="category">
          <a-input v-model:value="modal.data.category" />
        </a-form-item>
        <a-form-item label="Title" name="title">
          <a-input v-model:value="modal.data.title" />
        </a-form-item>
        <a-form-item label="Content" name="content">
          <a-textarea v-model:value="modal.data.content" rows="10"/>
        </a-form-item>
        <a-form-item label="Start at" name="date_start">
          <a-date-picker v-model:value="modal.data.date_start" :format="dateFormat" :valueFormat="dateFormat"/>
        </a-form-item>
        <a-form-item label="Due at" name="date_due">
          <a-date-picker v-model:value="modal.data.date_due" :format="dateFormat" :valueFormat="dateFormat"/>
        </a-form-item>
        <a-form-item label="acknowledge" name="acknowledge">
          <a-switch v-model:checked="modal.data.is_teacher"/>
        </a-form-item>
      </a-form>
      <template #footer>
        <a-button key="back" @click="modalCancel">Return</a-button>
        <a-button v-if="modal.mode == 'EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
        <a-button v-if="modal.mode == 'CREATE'" key="Store" type="primary" @click="storeRecord()">Create</a-button>
      </template>

    </a-modal>

  </AdminLayout>
</template>

<script>
import AdminLayout from "@/Layouts/AdminLayout.vue";
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
    AdminLayout,
    UploadOutlined,
    LoadingOutlined,
    PlusOutlined,
    RestFilled,
    // quillEditor,
    message,
  },
  props: ["notices",'categories'],
  data() {
    return {
      breadcrumb: [{ label: "表格列表", url: null }],
      loading: false,
      imageUrl: null,
      search: {},
      dateFormat:'YYYY-MM-DD',
      pagination: {
        total: this.notices.total,
        current: this.notices.current_page,
        pageSize: this.notices.per_page,
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
  created() { },
  mounted() {
    this.pagination = {
      currentPage: this.route().params.currentPage ?? 1,
      pageSize: this.route().params.pageSize ?? 10,
    };
    this.search = this.route().params.search ?? {};
  },
  methods: {
      onPaginationChange(page, filters, sorter){
        this.$inertia.get(route('admin.notices.index'),{
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

    onClickCreate(record) {
      this.modal.data = {};
      this.modal.title = "新增";
      this.modal.mode = 'CREATE';
      this.modal.isOpen = true;
    },
    onClickEdit(record) {
      this.modal.data = { ...record };
      this.modal.title = "修改";
      this.modal.mode = 'EDIT';
      this.modal.isOpen = true;
    },
    deleteConfirmed(record) {
      this.$inertia.delete(route("admin.notices.destroy", { form: record.id }), {
        onSuccess: (page) => {
          console.log(page);
        },
        onError: (error) => {
          alert(error.message);
        },
      });
    },
    backupRecords(record) {
      if (!confirm("Do you sure want to backup?")) return;
      this.$inertia.post(route("admin.form.backup", record.id), {
        onSuccess: (page) => {
          console.log(page);
        },
        onError: (error) => {
          alert(error.message);
        },
      });
    },
    searchData() {
      this.$inertia.get(
        route("admin.notices.index"),
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
