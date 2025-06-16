<template>
    <WebLayout title="Guardian" :breadcrumb="breadcrumb">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Guardian Dashboard
            </h2>
        </template>
        <div class="p-6">
            <div class="mb-4">
                <h3 class="text-lg font-semibold flex justify-between items-center">
                    <span>Guardian Information</span>
                </h3>
                <div class="bg-white shadow rounded-lg p-4">
                    <a-form name="Form" 
                        :model="guardian" 
                        :rules="rules" 
                        :validate-messages="validateMessages"
                        :label-col="{ span: 4 }" 
                        :wrapper-col="{ span: 20 }" 
                        @finish="onFinish"
                    >
                        <a-form-item label="Name (zh)" name="name_zh">
                            <a-input v-model:value="guardian.name_zh" />
                        </a-form-item>
                        <a-form-item label="Name (en)" name="name_en">
                            <a-input v-model:value="guardian.name_en" />
                        </a-form-item>
                        <a-form-item label="gender" name="gender">
                            <a-radio-group v-model:value="guardian.gender" button-style="solid">
                                <a-radio-button value="M">男</a-radio-button>
                                <a-radio-button value="F">女</a-radio-button>
                            </a-radio-group>
                        </a-form-item>
                        <a-form-item label="Dob" name="dob">
                            <a-date-picker v-model:value="guardian.dob" :format="dateFormat"
                                :valueFormat="dateFormat" />
                        </a-form-item>
                        <a-form-item label="Relationship" name="relationship">
                            <a-select v-model:value="guardian.relationship" :options="relationships"
                                :fieldNames="{ value: 'value', label: 'label_zh' }" />
                        </a-form-item>
                        <a-form-item :wrapper-col="{ span: 14, offset: 4 }">
                            <a-button key="back" :href="route('guardian.dashboard')">返回</a-button>
                            <a-button key="store" type="primary" html-type="submit"
                                style="margin-left: 10px">保存</a-button>
                        </a-form-item>
                    </a-form>
                </div>
            </div>
        </div>
    </WebLayout>
</template>

<script>
import WebLayout from '@/Layouts/WebLayout.vue';

export default {
    components: {
        WebLayout,
    },
    props: ['guardian', 'relationships'],
    data() {
        return {
            breadcrumb: [{ label: "個人資訊", url: null }],
            dateFormat: 'YYYY-MM-DD',
            columns: [
                {
                    title: 'Key',
                    dataIndex: 'key',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                },
            ],
            rules: {
                code: {
                    required: true,
                },
                title_zh: {
                    required: true,
                },
                title_en: {
                    required: true,
                },
                type: {
                    required: true,
                },
                stream: {
                    required: true,
                },
                eletive: {
                    required: true,
                },
            },
            validateMessages: {
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
    methods: {
        acknowledgeNotice(noticeId) {
            console.log(`Notice ${noticeId} acknowledged.`);
        },
        viewCourseDetails(courseId) {
            console.log(`Viewing details for course ${courseId}`);
        },
        onFinish(){
            console.log('onfinish');
            this.$inertia.put(route('guardian.profile.update',this.guardian.id), this.guardian,{
                onSuccess:(page)=>{
                    console.log(page)
                },
                onError:(error)=>{
                    console.log(error);
                }
            });

        },
    },
};
</script>

<style scoped>
/* Additional styles if needed */
</style>