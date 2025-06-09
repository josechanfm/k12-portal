<template>
    <AdminLayout title="主題列表" :breadcrumb="breadcrumb">
        <a-typography-title :level="3">班別: {{ klass.tag }}</a-typography-title>
        <div class="flex">
            <a-button @click="themeCreate()"
                type="primary">新增主題
            </a-button>
            <div class="flex-1"></div>
            <a-button @click="hiddenTheme=!(hiddenTheme)"
                type="">摺疊主題
            </a-button>
        </div>
        <div :class="hiddenTheme?'h-16 overflow-hidden':'h-[70vh] overflow-y-scroll'" class=" duration-500 transition-all">
            <a-table :dataSource="themes" :pagination="false">
                <a-table-column title="學段"  align="center">
                    <template #default="{record}">
                        {{ record.term_id }}
                        </template>
                </a-table-column>
                <a-table-column title="主題" align="center">
                    <template #default="{record}">
                        {{ record.title }}
                        </template>
                </a-table-column>
                <a-table-column title="操作" align="center">
                    <template #default="{record}">
                        <a-button @click="themeEdit(record)" :style="'Edit'">修改</a-button>
                        <a-button @click="themeDelete(record)" :style="'Delete'">刪除</a-button>
                        </template>
                </a-table-column>
            </a-table>
        </div>

        <template v-if="themes.length > 0">
            <a-button @click="topicCreate()" type="primary">新增基力項目</a-button>
            <a-divider type="vertical"></a-divider>
            <a-select v-model:value="selectedThemeId" :options="themes" :fieldNames="{ value: 'id', label: 'title' }" style="width:150px" />
            <template v-if="themes && selectedThemeId">
                <a-table :pagination="false" :dataSource="themes.find(theme => theme.id == selectedThemeId).topics" :columns="columns">
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
            </template>

        </template>


        <!-- modalTheme Start-->
        <a-modal v-model:open="modalTheme.isOpen" :title="modalTheme.title">
            <a-form :model="modalTheme.data" name="Theme" ref="modalThemeRef" :rules="themeRules"
                :validate-messages="validateMessages" :label-col="{ span: 4 }" :wrapper-col="{ span: 20 }">
                <a-form-item label="學段" name="ability_code">
                    <a-select v-model:value="modalTheme.data.term_id" :options="yearTerms" />
                </a-form-item>
                <a-form-item label="主題名稱" name="title">
                    <a-input v-model:value="modalTheme.data.title" />
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button key="back" @click="themeModalTopicCancel()">Return</a-button>
                <a-button v-if="modalTheme.mode == 'EDIT'" key="Update" type="primary"
                    @click="themeUpdate()">Update</a-button>
                <a-button v-if="modalTheme.mode == 'CREATE'" key="Store" type="primary"
                    @click="themeStore()">Create</a-button>
            </template>
        </a-modal>
        <!-- modalTopic Start-->
        <a-modal v-model:open="modalTopic.isOpen" :title="modalTopic.title">
            <a-form :model="modalTopic.data" name="Topic" ref="modalTopicRef" :rules="topicRules"
                :validate-messages="validateMessages" :label-col="{ span: 4 }" :wrapper-col="{ span: 20 }">
                <a-form-item label="基力項目分類" name="ability_code">
                    <a-select v-model:value="modalTopic.data.ability_code" :options="topicAbilities" />
                </a-form-item>
                <a-form-item label="基力項目標題" name="abbr">
                    <a-input v-model:value="modalTopic.data.abbr" />
                </a-form-item>
                <a-form-item label="基力項目全稱" name="title">
                    <a-input v-model:value="modalTopic.data.title" />
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button key="back" @click="topicModalTopicCancel()">Return</a-button>
                <a-button v-if="modalTopic.mode == 'EDIT'" key="Update" type="primary"
                    @click="topicUpdate()">Update</a-button>
                <a-button v-if="modalTopic.mode == 'CREATE'" key="Store" type="primary"
                    @click="topicStore()">Create</a-button>
            </template>
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
    props: ['yearTerms', 'topicAbilities', 'klass', 'themes'],
    data() {
        return {
            hiddenTheme:false,
            breadcrumb:[
                {label:"行政管理" ,url:route('admin.dashboard')},
                {label:"學年" ,url:route('admin.years.index')},
                {label:"年級" ,url:route('admin.year.grades.index',this.klass.grade.year_id)},
                {label:"班別" ,url:route('admin.grade.klasses.index',this.klass.grade.id)},
                {label:"主題" ,url:null},
            ],
            selectedThemeId: null,
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
            columns: [
                {
                    title: '基力項目名稱',
                    dataIndex: 'ability',
                }, {
                    title: '基力項目標題',
                    dataIndex: 'abbr',
                }, {
                    title: '基力項目全稱',
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
                ability_code: {
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
    created(){
        if(this.themes.length>0){
            this.selectedThemeId=this.themes[0].id
        }
    },
    methods: {
        themeCreate() {
            this.modalTheme.data = {}
            this.modalTheme.data.klass_id = this.klass.id
            this.modalTheme.title = "新增主題"
            this.modalTheme.mode = 'CREATE'
            this.modalTheme.isOpen = true

        },
        themeEdit(theme) {
            this.modalTheme.data = { ...theme }
            this.modalTheme.isOpen = true
            this.modalTheme.mode = 'EDIT'
            this.modalTheme.title = "修改主題"
        },
        themeUpdate() {
            this.$refs.modalThemeRef.validateFields().then(() => {
                this.$inertia.put(route('admin.klass.themes.update', [this.klass.id, this.modalTheme.data.id]), this.modalTheme.data, {
                    onSuccess: (page) => {
                        this.modalTheme.data = {}
                        this.modalTheme.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });
        },
        themeStore() {
            this.$refs.modalThemeRef.validateFields().then(() => {
                this.$inertia.post(route('admin.klass.themes.store', this.klass.id), this.modalTheme.data, {
                    onSuccess: (page) => {
                        this.modalTheme.data = {}
                        this.modalTheme.isOpen = false;
                        if(this.selectedThemeId==null){
                            this.selectedThemeId=page.props.themes[0].id
                        }
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
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
                    this.$inertia.delete(route('admin.klass.themes.destroy', [this.klass.id, theme.id]), {
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
            this.modalTopic.data.theme_id = this.selectedThemeId
            this.modalTopic.title = "新增基力項目"
            this.modalTopic.mode = 'CREATE'
            this.modalTopic.isOpen = true
        },
        topicEdit(topic) {
            console.log(topic)
            this.modalTopic.data = { ...topic }
            this.modalTopic.isOpen = true
            this.modalTopic.mode = 'EDIT'
            this.modalTopic.title = "修改基力項目"
        },
        topicUpdate() {
            this.$refs.modalTopicRef.validateFields().then(() => {
                this.$inertia.put(route('admin.klass.topics.update', [this.klass.id, this.modalTopic.data.id]), this.modalTopic.data, {
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
        topicStore() {
            this.$refs.modalTopicRef.validateFields().then(() => {
                this.$inertia.post(route('admin.klass.topics.store', this.klass.id), this.modalTopic.data, {
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
        topicDelete(topic) {
            Modal.confirm({
                title: '是否確定',
                icon: createVNode(ExclamationCircleOutlined),
                content: '刪除所選之項目?',
                okText: '確定',
                cancelText: '取消',
                onOk: () => {
                    this.$inertia.delete(route('admin.klass.topics.destroy', [this.klass.id, topic.id]), {
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
        themeModalTopicCancel() {
            this.modalTheme.isOpen = false
        },
        topicModalTopicCancel() {
            this.modalTopic.isOpen = false
        }
    },
}
</script>

