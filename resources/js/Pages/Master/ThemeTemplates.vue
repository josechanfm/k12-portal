<template>
    <AdminLayout title="學習主題">
        <!--  -->
        <div class="flex flex-col gap-1">
        <div class="flex flex-wrap font-bold text-sm gap-1">
            <div class="flex bg-gray-300 rounded-lg p-1 px-2 items-center gap-1">
                <div class="text-gray-600 font-black rounded-l-lg bg-gray-100 p-1">
                學年代號
                </div>
                <div class=" ">{{ year.code }}</div>
            </div>
            <div class="flex bg-gray-300 rounded-lg p-1 items-center gap-1">
                <div class="text-gray-600 font-black rounded-l-lg bg-gray-100 p-1">
                學年全稱
                </div>
                <div class=" ">{{ year.title }}</div>
            </div>
            <div class="flex bg-gray-300 rounded-lg p-1 items-center gap-1">
                <div class="text-gray-600 font-black rounded-l-lg bg-gray-100 p-1">
                年級
                </div>
                <template v-for="y_grade in year.k_grades" :key="y_grade">
                        <a-button as="link" class="font-black"
                        :class="y_grade.tag==grade.tag?'hover:!text-black bg-blue-500/90 text-white':''"
                        :href="route('master.grade.themeTemplates.index', y_grade.id)">
                            {{y_grade.tag }}
                        </a-button>
                 </template>
            </div>
            <div class="flex bg-gray-300 rounded-lg p-1 items-center gap-1">
                <div class="text-gray-600 font-black rounded-l-lg bg-gray-100 p-1">
                    基力學習主題
                </div>
                <a-select v-model:value="selectedThemeId" :options="themeTemplates"
                    :fieldNames="{ value: 'id', label: 'title' }" @change="onChangeSelectedTheme" />
            </div>
            <div class="flex bg-gray-300 rounded-lg p-1 items-center gap-1">
                <div class="text-gray-600 font-black rounded-l-lg bg-gray-100 p-1">
                    修改學習主題
                </div>
                 <a-switch v-model:checked="themeEditable" />
            </div>
        </div>
        <!--  -->
        <!-- topic section-->
        <Transition >
        <div class="h-[80vh] overflow-y-scroll bg-white rounded-lg border border-gray-300 p-3" v-if="themeEditable">
                <div class="flex ">
                    <div class="text-slate-500 text-lg font-black flex-1">修改學習主題</div>
                    <span class="pr-5">&nbsp;</span>
                    <a-button @click="themeCreate()"
                    size="small"   type="create">新增主題</a-button>
                </div>
                <a-table :dataSource="themeTemplates" :columns="themeColumns">
                    <template #bodyCell="{ column, text, record, index }">
                        <div class="flex gap-1" v-if="column.dataIndex == 'operation'">
                            <a-button @click="themeEdit(theme)" type="edit" size="small">修改</a-button>
                            <a-button @click="themeDelete(theme)" type="delete" size="small" >刪除</a-button>
                        </div>
                        <template v-else-if="column.dataIndex == 'term_id'">
                            {{ record.term_id }} / {{ record.id }}
                        </template>
                        <template v-else>
                            <a @click="selectedTheme = record">
                                {{ record.title }}
                            </a>

                        </template>
                    </template>
                </a-table>
        </div>
        </Transition>

        <!--Topics section-->
        <div class="flex flex-col gap-1 rounded-lg border p-2 bg-white !border-gray-300">
            <div class="flex">
                <div class="flex-1 text-lg text-slate-500 font-black"> 基力項目</div>
                <div >
                    <a-button @click="topicCreate()"
                    size="small"   type="create">新增內容</a-button>
                </div>
            </div>
            <a-table :dataSource="selectedTheme.topic_templates" :columns="topicColumns">
                <template #bodyCell="{ column, text, record, index }">
                    <div class="flex gap-1" v-if="column.dataIndex == 'operation'">
                        <a-button @click="topicEdit(record)" type="edit" size="small">修改</a-button>
                        <a-button @click="topicDelete(record)" type="delete" size="small">刪除</a-button>
                    </div>
                    <template v-else>
                        {{ record[column.dataIndex] }}
                    </template>
                </template>
            </a-table>
        </div>

        <!-- modalTheme Start-->
        <a-modal :cancelButtonProps="{type:'delete',size:'small'}"  cancelText="取消"
                :okButtonProps="{type:modalTheme.mode.toLowerCase(),size:'small'}"   :okText="modalTheme.mode=='CREATE'?'新增':'保存'"
                v-model:open="modalTheme.isOpen" :title="modalTheme.title" @ok="themeOnOk">
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
        <a-modal  :cancelButtonProps="{type:'delete',size:'small'}"  cancelText="取消"
                    :okButtonProps="{type:modalTheme.mode.toLowerCase(),size:'small'}"   :okText="modalTheme.mode=='CREATE'?'新增':'保存'"
            v-model:open="modalTopic.isOpen" :title="modalTopic.title" @ok="topicOnOK">
            <a-form :model="modalTopic.data" name="Topic" ref="modalTopicRef" :rules="topicRules"
                :validate-messages="validateMessages" :label-col="{ span: 4 }" :wrapper-col="{ span: 20 }">
                <a-form-item label="分類" name="section_code">
                    <a-select v-model:value="modalTopic.data.section_code" :options="topicAbilities" />
                </a-form-item>
                <a-form-item label="分組標題" name="abbr">
                    <a-input v-model:value="modalTopic.data.abbr" />
                </a-form-item>
                <a-form-item label="分組全稱" name="title">
                    <a-input v-model:value="modalTopic.data.title" />
                </a-form-item>
            </a-form>
        </a-modal>
    </div>
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
    props: ['yearTerms', 'year', 'grade', 'themeTemplates', 'topicAbilities'],
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
            themeColumns: [
                {
                    title: '學段',
                    dataIndex: 'term_id',
                }, {
                    title: '主題',
                    dataIndex: 'title',
                }, {
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],
            topicColumns: [
                {
                    title: '分類代號',
                    dataIndex: 'ability_code',
                }, {
                    title: '分類全稱',
                    dataIndex: 'ability',
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
<style scoped>
.v-enter-active,
.v-leave-active {
    transition: opacity 0.3s ease-out, height 0.3s linear;
}
.v-enter-from,
.v-leave-to {
    opacity:0;
    height:0px;
  }
</style>
