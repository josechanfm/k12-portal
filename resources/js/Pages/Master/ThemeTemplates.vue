<template>
    <AdminLayout title="學習主題">
        <div class="bg-white shadow sm:rounded-lg my-5 p-5">
            <a-row>
                <a-col :sm="24" :lg="12">
                    <a-typography-title :level="3">學年: {{ year.title }}</a-typography-title>
                    <a-typography-title :level="3">年級: {{ grade.tag }}</a-typography-title>
                </a-col>
                <a-col :sm="24" :lg="12">
                    <template v-for="grade in year.k_grades">
                        <inertia-link class="ant-btn" :href="route('master.grade.themeTemplates.index', grade.id)">{{
                    grade.tag }}</inertia-link>
                    </template>
                </a-col>
            </a-row>
            <a-row class="pt-5">
                <a-col :span="24">

                </a-col>
            </a-row>
        </div>
        <div class="bg-white sm:rounded-lg my-5 p-5">
            <div class="float-right">
                修開 <a-switch v-model:checked="themeEditable" />
                <span class="pr-5">&nbsp;</span>
                <button @click="themeCreate()" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">新增主題</button>
            </div>

            <div  v-if="!themeEditable">
                <a-select v-model:value="selectedThemeId" :options="themeTemplates" :fieldNames="{ value: 'id', label: 'title' }"
                    @change="onChangeSelectedTheme" />
            </div>
            <div v-else class="pb-5">{{ selectedTheme.title }}</div>

            <div class="ant-table" v-if="themeEditable">
            <div class="ant-table-container">
                <div class="ant-table-content">
                    <table style="table-layout: auto;">
                        <thead class="ant-table-thead">
                            <tr>
                                <th class="ant-table-cell">學段</th>
                                <th class="ant-table-cell">主題</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody class="ant-table-tbody">
                            <tr v-for="theme in themeTemplates">
                                <td>{{ theme.term_id }}/{{ theme.id }}</td>
                                <td>
                                    <a @click="selectedTheme = theme">
                                        {{ theme.title }}
                                    </a>
                                </td>
                                <td>
                                    <a-button @click="themeEdit(theme)" :style="'Edit'">修改</a-button>
                                    <a-button @click="themeDelete(theme)" :style="'Delete'">刪除</a-button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        </div>
        <div>
            <div class="text-right">
                <button @click="topicCreate()"
                    class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">新增內容</button>
            </div>
            <a-table :dataSource="selectedTheme.topic_templates" :columns="topicColumns">
                <template #bodyCell="{ column, text, record, index }">
                    <template v-if="column.dataIndex == 'operation'">
                        <a-button @click="topicEdit(record)" :style="'Edit'">修改</a-button>
                        <a-button @click="topicDelete(record)" :style="'Delete'">刪除</a-button>
                    </template>
                    <template v-else>
                        {{ record[column.dataIndex] }}
                    </template>
                </template>
            </a-table>
        </div>

        <!-- modalTheme Start-->
        <a-modal v-model:visible="modalTheme.isOpen" :title="modalTheme.title" @ok="themeOnOk">
            <a-form :model="modalTheme.data" name="Theme" ref="modalThemeRef" :rules="themeRules"
                :validate-messages="validateMessages" :label-col="{ span: 4 }" :wrapper-col="{ span: 20 }">
                <a-form-item label="學段" name="term_id">
                    <a-select v-model:value="modalTheme.data.term_id" :options="yearTerms" />
                </a-form-item>
                <a-form-item label="主題名稱" name="title">
                    <a-input v-model:value="modalTheme.data.title" />
                </a-form-item>
                <a-form-item label="主題簡介" name="description">
                    <a-textarea v-model:value="modalTheme.data.description" />
                </a-form-item>

            </a-form>
        </a-modal>
        <!-- modalTopic Start-->
        <a-modal v-model:visible="modalTopic.isOpen" :title="modalTopic.title" @ok="topicOnOK">
            <a-form :model="modalTopic.data" name="Topic" ref="modalTopicRef" :rules="topicRules"
                :validate-messages="validateMessages" :label-col="{ span: 4 }" :wrapper-col="{ span: 20 }">
                <a-form-item label="分類" name="section_code">
                    <a-select v-model:value="modalTopic.data.section_code" :options="topicSections" />
                </a-form-item>
                <a-form-item label="分組標題" name="abbr">
                    <a-input v-model:value="modalTopic.data.abbr" />
                </a-form-item>
                <a-form-item label="分組全稱" name="title">
                    <a-input v-model:value="modalTopic.data.title" />
                </a-form-item>
            </a-form>
        </a-modal>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Modal } from 'ant-design-vue';
import { ExclamationCircleOutlined } from '@ant-design/icons-vue';
import { ref, createVNode } from 'vue';

export default {
    components: {
        AdminLayout, Modal, createVNode, ExclamationCircleOutlined
    },
    props: ['yearTerms', 'year', 'grade', 'themeTemplates', 'topicSections'],
    data() {
        return {
            themeEditable: false,
            selectedThemeId: null,
            selectedTheme: null,
            modalTheme: {
                mode: null,
                isOpen: false,
                title: 'Theme',
                data: {}
            },
            modalTopic: {
                mode: null,
                isOpen: false,
                title: 'Topic',
                data: {}
            },
            topicColumns: [
                {
                    title: '分類簡稱',
                    dataIndex: 'section_code_label',
                }, {
                    title: '分類全稱',
                    dataIndex: 'section',
                }, {
                    title: '分組簡稱',
                    dataIndex: 'abbr',
                }, {
                    title: '分組全稱',
                    dataIndex: 'title',
                }, {
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],
            themeRules: {
                term_id: {
                    required: true,
                },
                title: {
                    required: true,
                },
            },
            topicRules: {
                section_code: {
                    required: true,
                },
                abbr: {
                    required: true,
                },
                title: {
                    required: true,
                }
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

        }
    },
    created() {
        this.selectedTheme = this.themeTemplates[0]
        if (this.themeTemplates.length > 0) {
            this.selectedThemeId = this.themeTemplates[0].id
        }
    },
    methods: {
        themeCreate() {
            this.modalTheme.data = {}
            this.modalTheme.data.grade_id = this.grade.id
            this.modalTheme.data.grade_year = this.grade.grade_year
            this.modalTheme.title = "新增"
            this.modalTheme.mode = 'CREATE'
            this.modalTheme.isOpen = true
        },
        themeEdit(theme) {
            this.modalTheme.data = { ...theme }
            this.modalTheme.isOpen = true
            this.modalTheme.mode = 'EDIT'
            this.modalTheme.title = "修改"
        },
        themeOnOk() {
            if (this.modalTheme.mode == 'CREATE') {
                this.themeStore();
            } else {
                this.themeUpdate();
            }
        },
        themeStore() {
            this.$inertia.post(route('master.themeTemplates.store', this.modalTheme.data.id), this.modalTheme.data, {
                onSuccess: (page) => {
                    this.modalTheme.data = {}
                    this.modalTheme.isOpen = false;
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
        themeUpdate() {
            this.$inertia.put(route('master.themeTemplates.update', this.modalTheme.data.id), this.modalTheme.data, {
                onSuccess: (page) => {
                    this.modalTheme.data = {}
                    this.modalTheme.isOpen = false;
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
        themeDelete(theme) {
            Modal.confirm({
                title: '是否確定',
                icon: createVNode(ExclamationCircleOutlined),
                content: '刪除所選之主題?',
                okText: '確定',
                cancelText: '取消',
                onOk: () => {
                    this.$inertia.delete(route('master.grade.themeTemplates.destroy', [this.grade.id, theme.id]), {
                        onSuccess: (page) => {
                            this.modalTheme.data = {}
                            this.modalTheme.isOpen = false;
                        },
                        onError: (error) => {
                            alert(error.message);
                        }
                    });
                }
            })
        },
        topicCreate() {
            this.modalTopic.data = {}
            this.modalTopic.data.theme_template_id = this.selectedThemeId
            this.modalTopic.title = "新增"
            this.modalTopic.mode = 'CREATE'
            this.modalTopic.isOpen = true
        },
        topicEdit(topic) {
            console.log(topic)
            this.modalTopic.data = { ...topic }
            this.modalTopic.isOpen = true
            this.modalTopic.mode = 'EDIT'
            this.modalTopic.title = "修改"
        },
        topicOnOK() {
            if (this.modalTopic.mode == 'CREATE') {
                this.topicStore()
            } else {
                this.topicUpdate()
            }
        },
        topicStore() {
            console.log(this.modalTopic.data);
            this.$refs.modalTopicRef.validateFields().then(() => {
                this.$inertia.post(route('master.grade.topicTemplates.store', this.grade.id), this.modalTopic.data, {
                    onSuccess: (page) => {
                        this.modalTopic.data = {}
                        this.modalTopic.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });
        },
        topicUpdate() {
            this.$inertia.put(route('master.topicTemplates.update', this.modalTopic.data.id), this.modalTopic.data, {
                onSuccess: (page) => {
                    this.modalTopic.data = {}
                    this.modalTopic.isOpen = false;
                    this.selectedTheme = this.themeTemplates.find(t => t.id == this.selectedTheme.id)
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
        topicDelete(topic) {
            Modal.confirm({
                title: '是否確定',
                icon: createVNode(ExclamationCircleOutlined),
                content: '刪除所選之項目?',
                okText: '確定',
                cancelText: '取消',
                onOk: () => {
                    this.$inertia.delete(route('master.grade.topicTemplates.destroy', [this.grade.id, topic.id]), {
                        onSuccess: (page) => {
                            this.modalTopic.data = {}
                            this.modalTopic.isOpen = false;
                        },
                        onError: (error) => {
                            alert(error.message);
                        }
                    });
                },
            });
        },

        onChangeSelectedTheme() {
            console.log('selected Theme changed');
            this.selectedTheme = this.themeTemplates.find(t => t.id == this.selectedThemeId)
            console.log(this.selectedTheme)
        }
    },
}
</script>
