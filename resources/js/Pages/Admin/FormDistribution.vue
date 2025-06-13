<template>
  <AdminLayout :title="form.id ? '表格修改' : '表格新增'" :breadcrumb="breadcrumb">
    <div class="bg-white relative shadow  p-5 rounded-lg overflow-x-auto">
      <div>
        <div>{{ form.title }}</div>
        <div v-html="form.description"/>
      </div>
      <hr>
      <a-form ref="modalRef" :model="distribute" name="From" layout="vertical" autocomplete="off" :rules="rules"
        :validate-messages="validateMessages" @finish="onFinish" @finishFailed="onFinishFailed">

        <a-form-item :label="$t('klasses')" name="klasses">
          <a-checkbox-group v-model:value="distribute.klasses" >
            <a-checkbox v-for="klass in klasses" :value="klass.value" :key="klass.value">{{ klass.name_zh }}</a-checkbox>
          </a-checkbox-group>
        </a-form-item>
        <a-form-item :label="$t('recipient')" name="reciptients">
          <a-checkbox-group v-model:value="distribute.recipients" :options="recipientOptions"/>
        </a-form-item>

        <a-form-item :label="$t('specific_students')" name="specific_students">
          <a-select
            v-model:value="distribute.specific_students"
            mode="tags"
            style="width: 100%"
            :token-separators="[',']"
            placeholder="Automatic tokenization"
          ></a-select>
        </a-form-item>
        <a-form-item :label="$t('specific_guardians')" name="specific_guardians">
          <a-select
            v-model:value="distribute.specific_guardians"
            mode="tags"
            style="width: 100%"
            :token-separators="[',']"
            placeholder="Automatic tokenization"
          ></a-select>
        </a-form-item>

        <a-form-item :wrapper-col="{ offset: 12, span: 10 }">
          <a-button key="back" :href="route('admin.forms.index')">返回</a-button>
          <a-button type="primary" html-type="submit">{{ $t('submit') }}</a-button>
        </a-form-item>
      </a-form>

    </div>

  </AdminLayout>
</template>

<script>
import AdminLayout from "@/Layouts/AdminLayout.vue";
import { message } from "ant-design-vue";
import { PlusOutlined,DeleteOutlined } from "@ant-design/icons-vue";
import RichTextEditor from '@/Components/RichTextEditor.vue'; // Adjust the path accordingly

export default {
  components: {
    AdminLayout,
    RichTextEditor,
    message,
    PlusOutlined, DeleteOutlined
  },
  props: ["form","klasses"],
  data() {
    return {
      breadcrumb: [
        { label: "表格列表", url: route('admin.forms.index') },
        { label: this.form.id ? '表格修改' : '表格新增', url: null }
      ],
      distribute:{},
      dateFormat: "YYYY-MM-DD",
      recipientOptions:[
        {value:'ALL_STUDENT',label:"全部學生"},
        {value:'ALL_GUARDIAN',label:"全部家長"},
        {value:'ALL_STUDENT_GUARDIAN',label:"全部家長及學生"},
      ],

      rules: {
        name: { required: true },
        title: { required: true },
        valid_at: { required: true },
      },
      validateMessages: {
        required: "${label} is required!",
        types: {
          email: "${label} is not a valid email!",
          number: "${label} is not a valid number!",
        },
        number: {
          range: "${label} must be between ${min} and ${max}",
        },
      },
      labelCol: {
        style: {
          width: "150px",
        },
      },
    };
  },
  created() {
  },
  mounted() {
  },
  methods: {

    onFinish(event) {
      console.log(this.distribute);
      this.$inertia.post(route("admin.form.distribute"), this.distribute, {
        onSuccess: (page) => {
          // this.modal.data = {};
          // this.modal.isOpen = false;
        },
        onError: (err) => {
          console.log(err);
        },
      });
    },
    onFinishFailed({ values, errorFields, outOfDate }) {
      message.error("Some required fields are missing!");
    },








  },
};
</script>
