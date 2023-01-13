<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                <a-row type="flex">
                    <a-col flex="230px">
                        <a-image
                            :width="200"
                            src="https://zos.alipayobjects.com/rmsportal/jkjgkEfvpUPVyRjUImniVslZfWPnJuuZ.png"
                        />
                    </a-col>
                    <a-col flex="auto">
                        <a-typography-title :level="1">{{ student.name_zh }}</a-typography-title>
                        <a-typography-title :level="3">{{ student.name_fn }}</a-typography-title>
                        <a-typography-title :level="5">{{ student.gender }}</a-typography-title>
                        <a-typography-title :level="5">{{ student.dob }}</a-typography-title>
                    </a-col>
                </a-row>
            </h2>
        </template>
        <div :class="isEdit?'formEditOn':'formEditOff'">
            <a-switch v-model:checked="isEdit" @change="onChangeEditMode"/>

            <a-collapse v-model:activeKey="activeKey">
                <a-collapse-panel key="basic" header="學生基本資料">
                    <a-row>
                        <a-col :span="6">
                            <a-form-item label="姓名" :label-col="labelCol" :wrapper-col="wrapperCol">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                            <a-form-item label="校內編號" :label-col="labelCol" :wrapper-col="wrapperCol">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                            <a-form-item label="教青局編號" :label-col="labelCol" :wrapper-col="wrapperCol">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                            <a-form-item label="衛生局金咭編號" :label-col="labelCol" :wrapper-col="wrapperCol">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                            <a-form-item label="學生手提電話" :label-col="labelCol" :wrapper-col="wrapperCol">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                        </a-col>
                        <a-col :span="12">
                            <a-form-item label="外文姓名" :label-col="{ span:8 }" :wrapper-col="{ span:16 }">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                            <a-form-item label="成綪表顯示英文名稱" :label-col="{ span:8 }" :wrapper-col="{ span:16 }">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                            <a-form-item label="過往就請學校" :label-col="{ span:8 }" :wrapper-col="{ span:16 }">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                            <a-row>
                                <a-col :span="14">
                                    <a-form-item label="學生入學級號" :label-col="{ span:14 }" :wrapper-col="{ span:6 }">
                                        <a-input v-model:value="modelRef.name" />
                                    </a-form-item>
                                </a-col>
                                <a-col :span="10">
                                    <a-form-item label="班別號" :label-col="{span:14 }" :wrapper-col="{ span: 10 }">
                                        <a-input v-model:value="modelRef.name" />
                                    </a-form-item>
                                </a-col>
                            </a-row>
                            <a-row>
                                <a-col :span="16">
                                    <a-form-item label="接收短訊用手提電話" :label-col="{ span:12 }" :wrapper-col="{ span:12 }">
                                        <a-input v-model:value="modelRef.name" />
                                    </a-form-item>
                                </a-col>
                                <a-col :span="8">
                                    <a-form-item label="性別" :label-col="{span:12 }" :wrapper-col="{ span: 12 }">
                                        <a-input v-model:value="modelRef.name" />
                                    </a-form-item>
                                </a-col>
                            </a-row>
                        </a-col>
                        <a-col :span="6">
                            <a-form-item label="出生日期" :label-col="labelCol" :wrapper-col="wrapperCol">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                            <a-form-item label="入學日期" :label-col="labelCol" :wrapper-col="wrapperCol">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                            <a-form-item label="監護人" :label-col="labelCol" :wrapper-col="wrapperCol">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                            <a-form-item label="宗教" :label-col="labelCol" :wrapper-col="wrapperCol">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>
                            <a-form-item label="住宅電話" :label-col="labelCol" :wrapper-col="wrapperCol">
                                <a-input v-model:value="modelRef.name" />
                            </a-form-item>

                        </a-col>
                    </a-row>
                </a-collapse-panel>
                <a-collapse-panel key="address" header="地址資料">
                    <a-descriptions bordered>
                        <a-descriptions-item label="國籍" >
                            <a-input v-model:value="modelRef.name" :bordered="false"/>
                        </a-descriptions-item>
                        <a-descriptions-item label="住址街名" :span="2">
                            <a-input v-model:value="modelRef.name" />
                        </a-descriptions-item>
                        <a-descriptions-item label="籍貫">
                            <a-input v-model:value="modelRef.name" />
                        </a-descriptions-item>
                        <a-descriptions-item label="門牌大廈">
                            <a-input v-model:value="modelRef.name" />
                        </a-descriptions-item>
                        <a-descriptions-item label="居住地區">
                            <a-input v-model:value="modelRef.name" />
                        </a-descriptions-item>
                        <a-descriptions-item label="夜宿地區">
                            <a-input v-model:value="modelRef.name" />
                        </a-descriptions-item>
                        <a-descriptions-item label="夜宿(國內)地址" :span="2">
                            <a-input v-model:value="modelRef.name" />
                        </a-descriptions-item>
                    </a-descriptions>
                </a-collapse-panel>
                <a-collapse-panel key="id_card" header="證件資料">
                    {{ student }}
                </a-collapse-panel>
                <a-collapse-panel key="bank" header="銀行資料">
                    {{ student }}
                </a-collapse-panel>
                <a-collapse-panel key="detail" header="學生詳細資料">
                    {{ student }}
                </a-collapse-panel>
                <a-collapse-panel key="parent" header="父母資料">
                    {{ student }}
                </a-collapse-panel>
                <a-collapse-panel key="guardian" header="監護人資料">
                    {{ student }}
                </a-collapse-panel>
                <a-collapse-panel key="health" header="健康相關">
                    {{ student }}
                </a-collapse-panel>
                <a-collapse-panel key="1" headd="This is panel header 1">
                    <a-form
                        ref="formRef"
                        name="advanced_search"
                        class="ant-advanced-search-form"
                        :model="formState"
                        @finish="onFinish"
                        >
                        <a-row :gutter="24">
                            <template v-for="i in 10" :key="i">
                            <a-col v-show="expand || i <= 6" :span="8">
                                <a-form-item
                                :name="`field-${i}`"
                                :label="`field-${i}`"
                                :rules="[{ required: true, message: 'input something' }]"
                                >
                                <a-input v-model:value="formState[`field-${i}`]" placeholder="placeholder"></a-input>
                                </a-form-item>
                            </a-col>
                            </template>
                        </a-row>
                        <a-row>
                            <a-col :span="24" style="text-align: right">
                            <a-button type="primary" html-type="submit">Search</a-button>
                            <a-button style="margin: 0 8px" @click="() => formRef.resetFields()">Clear</a-button>
                            <a style="font-size: 12px" @click="expand = !expand">
                                <template v-if="expand">
                                <UpOutlined />
                                </template>
                                <template v-else>
                                <DownOutlined />
                                </template>
                                Collapse
                            </a>
                            </a-col>
                        </a-row>
                        </a-form>
                </a-collapse-panel>
                <a-collapse-panel key="2" header="This is panel header 2">
                    <a-form
                        :model="formState"
                        name="time_related_controls"
                        v-bind="formItemLayout"
                    >
                        <a-form-item name="date-picker" label="DatePicker" v-bind="config">
                        <a-date-picker v-model:value="formState['date-picker']" value-format="YYYY-MM-DD" />
                        </a-form-item>
                        <a-form-item name="date-time-picker" label="DatePicker[showTime]" v-bind="config">
                        <a-date-picker
                            v-model:value="formState['date-time-picker']"
                            show-time
                            format="YYYY-MM-DD HH:mm:ss"
                            value-format="YYYY-MM-DD HH:mm:ss"
                        />
                        </a-form-item>
                        <a-form-item name="month-picker" label="MonthPicker" v-bind="config">
                        <a-date-picker
                            v-model:value="formState['month-picker']"
                            value-format="YYYY-MM"
                            picker="month"
                        />
                        </a-form-item>
                        <a-form-item name="range-picker" label="RangePicker" v-bind="rangeConfig">
                        <a-range-picker v-model:value="formState['range-picker']" value-format="YYYY-MM-DD" />
                        </a-form-item>
                        <a-form-item name="range-time-picker" label="RangePicker[showTime]" v-bind="rangeConfig">
                        <a-range-picker
                            v-model:value="formState['range-time-picker']"
                            show-time
                            format="YYYY-MM-DD HH:mm:ss"
                            value-format="YYYY-MM-DD HH:mm:ss"
                        />
                        </a-form-item>
                        <a-form-item name="time-picker" label="TimePicker" v-bind="config">
                        <a-time-picker v-model:value="formState['time-picker']" value-format="HH:mm:ss" />
                        </a-form-item>
                        <a-form-item
                        :wrapper-col="{
                            xs: { span: 24, offset: 0 },
                            sm: { span: 16, offset: 8 },
                        }"
                        >
                        <a-button type="primary" html-type="submit">Submit</a-button>
                        </a-form-item>
                    </a-form>
                </a-collapse-panel>
                <a-collapse-panel key="3" header="This is panel header 3">
                    <a-form :label-col="labelCol" :wrapper-col="wrapperCol">
                        <a-form-item label="Activity name" >
                            <a-input v-model:value="modelRef.name" />
                        </a-form-item>
                        <a-form-item label="Activity zone" >
                        <a-select v-model:value="modelRef.region" placeholder="please select your zone">
                            <a-select-option value="shanghai">Zone one</a-select-option>
                            <a-select-option value="beijing">Zone two</a-select-option>
                        </a-select>
                        </a-form-item>
                        <a-form-item label="Activity type" >
                        <a-checkbox-group v-model:value="modelRef.type">
                            <a-checkbox value="1" name="type">Online</a-checkbox>
                            <a-checkbox value="2" name="type">Promotion</a-checkbox>
                            <a-checkbox value="3" name="type">Offline</a-checkbox>
                        </a-checkbox-group>
                        </a-form-item>
                        <a-form-item :wrapper-col="{ span: 14, offset: 4 }">
                        <a-button type="primary" @click.prevent="onSubmit">Create</a-button>
                        <a-button style="margin-left: 10px" @click="resetFields">Reset</a-button>
                        </a-form-item>
                    </a-form>
                </a-collapse-panel>
                <a-collapse-panel key="4" header="This is panel header 4">
                    {{ student }}
                </a-collapse-panel>
            </a-collapse>
        </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link } from '@inertiajs/inertia-vue3';

export default {
    components: {
        AdminLayout, Link
    },
    props: ['student'],
    data() {
        return {
            activeKey: ['basic'],
            isEdit:false,
            formState: {},
            modelRef:{},
            formItemLayout: {
                labelCol: {
                    xs: { span: 24 },
                    sm: { span: 8 },
                },
                wrapperCol: {
                    xs: { span: 24 },
                    sm: { span: 16 },
                },
            },
            labelCol: {
                span: 10,
            },
            wrapperCol: {
                span: 14,
            },
        }
    },
    methods: {
        onChangeEditMode(){
            console.log(this.isEdit);
        }
    },
}
</script>

<style>
.ant-input{
    border:none
}
.ant-form-item-label label{
    font-weight: bold;
}
.formEditOn .ant-input{
    border:1px solid #ccc
}
.formEditOff .ant-input{
    border:none;
    pointer-events: none;
}

</style>