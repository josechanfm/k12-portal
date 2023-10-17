<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                學習主題
            </h2>
        </template>
        <a-typography-title :level="3">年級: {{ klass.tag }}</a-typography-title>
        <button @click="themeCreate()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">新增主題</button>
        <div class="ant-table">
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
                            <tr v-for="theme in themes">
                                <td>{{ theme.term_id }}</td>
                                <td>{{ theme.title }}</td>
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
            
        <button @click="topicCreate()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">新增內容</button>
        <a-divider type="vertical"></a-divider>
        <a-select v-model:value="selectedThemeId" 
            :options="themes" 
            :fieldNames="{value:'id',label:'title'}"
            style="width:150px"
        />
        <a-table :dataSource="themes.find(theme=>theme.id==selectedThemeId).topics" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex=='operation'">
                    {{record.topics}}
                    <a-button @click="topicEdit(record)" :style="'Edit'">修改</a-button>
                    <a-button @click="topicDelete(record)" :style="'Delete'">刪除</a-button>
                </template>
                <template v-else>
                    {{record[column.dataIndex]}}
                </template>
            </template>
        </a-table>

        <!-- modalTheme Start-->
        <a-modal v-model:visible="modalTheme.isOpen" :title="modalTheme.title" >
            <a-form
                :model="modalTheme.data"
                name="Theme"
                ref="modalThemeRef"
                :rules="themeRules"
                :validate-messages="validateMessages"
                :label-col="{ span: 4 }"
                :wrapper-col="{ span: 20 }"
            >
                <a-form-item label="學段" name="section_code">
                    <a-select v-model:value="modalTheme.data.term_id" :options="yearTerms"/>
                </a-form-item>
                <a-form-item label="主題名稱" name="title">
                    <a-input v-model:value="modalTheme.data.title"/>
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button key="back" @click="themeModalTopicCancel()">Return</a-button>
                <a-button v-if="modalTheme.mode=='EDIT'" key="Update" type="primary" @click="themeUpdate()">Update</a-button>
                <a-button v-if="modalTheme.mode=='CREATE'"  key="Store" type="primary" @click="themeStore()">Create</a-button>
            </template>
        </a-modal>
        <!-- modalTopic Start-->
        <a-modal v-model:visible="modalTopic.isOpen" :title="modalTopic.title" >
            <a-form
                :model="modalTopic.data"
                name="Topic"
                ref="modalTopicRef"
                :rules="topicRules"
                :validate-messages="validateMessages"
                :label-col="{ span: 4 }"
                :wrapper-col="{ span: 20 }"
            >
                <a-form-item label="分類" name="section_code">
                    <a-select v-model:value="modalTopic.data.section_code" :options="topicAbilities"/>
                </a-form-item>
                <a-form-item label="分組標題" name="abbr">
                    <a-input v-model:value="modalTopic.data.abbr" />
                </a-form-item>
                <a-form-item label="分組全稱" name="title">
                    <a-input v-model:value="modalTopic.data.title" />
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button key="back" @click="topicModalTopicCancel()">Return</a-button>
                <a-button v-if="modalTopic.mode=='EDIT'" key="Update" type="primary" @click="topicUpdate()">Update</a-button>
                <a-button v-if="modalTopic.mode=='CREATE'"  key="Store" type="primary" @click="topicStore()">Create</a-button>
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
        AdminLayout,Modal,createVNode,ExclamationCircleOutlined
    },
    props: ['yearTerms','topicAbilities','klass','themes','topicTemplates'],
    data() {
        return {
            selectedThemeId:this.themes[0].id,
            modalTheme: {
                mode:null,
                isOpen: false,
                title:'Theme',
                data:{}
            },
            modalTopic: {
                mode:null,
                isOpen: false,
                title:'Topic',
                data:{}
            },
            columns:[
                {
                    title: '分類名稱',
                    dataIndex: 'section',
                },{
                    title: '分組標題',
                    dataIndex: 'abbr',
                },{
                    title: '分組全稱',
                    dataIndex: 'title',
                },{
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ],
            themeRules:{
                term_id:{
                    required:true,
                },
                title:{
                    required:true,
                },
            },
            topicRules:{
                section_code:{
                    required:true,
                },
                abbr:{
                    required:true,
                },
                title:{
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

        }
    },
    methods: {
        themeCreate(){
            this.modalTheme.data={}
            this.modalTheme.data.klass_id=this.klass.id
            this.modalTheme.title="新增"
            this.modalTheme.mode='CREATE'
            this.modalTheme.isOpen=true
            
        },
        themeUpdate(){
            this.$refs.modalThemeRef.validateFields().then(()=>{
                this.$inertia.put(route('admin.klass.themes.update',[this.klass.id,this.modalTheme.data.id]), this.modalTheme.data,{
                    onSuccess:(page)=>{
                        this.modalTheme.data={}
                        this.modalTheme.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });
        },
        themeStore(){
            this.$refs.modalThemeRef.validateFields().then(()=>{
                this.$inertia.post(route('admin.klass.themes.store',this.klass.id), this.modalTheme.data,{
                    onSuccess:(page)=>{
                        this.modalTheme.data={}
                        this.modalTheme.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });
        },
        themeDelete(theme){
            Modal.confirm({
                title: '是否確定',
                icon: createVNode(ExclamationCircleOutlined),
                content: '刪除所選之主題?',
                okText: '確定',
                cancelText: '取消',
                onOk:() => {
                    this.$inertia.delete(route('admin.klass.themes.destroy',[this.klass.id,theme.id]),{
                        onSuccess:(page)=>{
                            this.modalTheme.data={}
                            this.modalTheme.isOpen=false;
                        },
                        onError:(error)=>{
                            alert(error.message);
                        }
                    });
                }
            })
        },
        themeEdit(theme){
            this.modalTheme.data={...theme}
            this.modalTheme.isOpen=true
            this.modalTheme.mode='EDIT'
            this.modalTheme.title="修改"
        },
        topicCreate(){
            this.modalTopic.data={}
            this.modalTopic.data.theme_id=this.selectedThemeId
            this.modalTopic.title="新增"
            this.modalTopic.mode='CREATE'
            this.modalTopic.isOpen=true
        },
        topicEdit(topic){
            console.log(topic)
            this.modalTopic.data={...topic}
            this.modalTopic.isOpen=true
            this.modalTopic.mode='EDIT'
            this.modalTopic.title="修改"
        },
        topicUpdate(){
            this.$refs.modalTopicRef.validateFields().then(()=>{
                this.$inertia.put(route('admin.klass.topics.update',[this.klass.id,this.modalTopic.data.id]), this.modalTopic.data,{
                    onSuccess:(page)=>{
                        this.modalTopic.data={}
                        this.modalTopic.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });
        },
        topicStore(){
            this.$refs.modalTopicRef.validateFields().then(()=>{
                this.$inertia.post(route('admin.klass.topics.store',this.klass.id), this.modalTopic.data,{
                    onSuccess:(page)=>{
                        this.modalTopic.data={}
                        this.modalTopic.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });
        },
        topicDelete(topic){
            Modal.confirm({
                title: '是否確定',
                icon: createVNode(ExclamationCircleOutlined),
                content: '刪除所選之項目?',
                okText: '確定',
                cancelText: '取消',
                onOk:()=>{
                    this.$inertia.delete(route('admin.klass.topics.destroy',[this.klass.id,topic.id]),{
                        onSuccess:(page)=>{
                            this.modalTopic.data={}
                            this.modalTopic.isOpen=false;
                        },
                        onError:(error)=>{
                            alert(error.message);
                        }
                    });
                },
            });
        },
        themeModalTopicCancel(){
            this.modalTheme.isOpen=false
        },
        topicModalTopicCancel(){
            this.modalTopic.isOpen=false
        }


    },
}
</script>

