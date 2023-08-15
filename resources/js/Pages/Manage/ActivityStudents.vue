<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                課外活動
            </h2>
        </template>
            <br>
            <template v-for="grade in grades">
                <a-button :value="grade.id" type="primary" class="mr-3 w-15" @click="selectedGrade = grade.id">
                    {{ grade.tag}}
                </a-button>
            </template>
            <p>&nbsp;</p>
            <template v-for="klass in klasses">
                <a-button v-if="klass.grade_id == selectedGrade" :value="klass.id" type="primary" class="mr-3 w-15"
                    @click="getStudentsByKlass(klass)">{{ klass.tag }}</a-button>
            </template>
            <a-input-search placeholder="Student name" style="width: 200px" @search="onSearch" />
            <label class="pr-1 pl-5">滙入模式</label>
            <a-switch v-model:checked="importMode">By List</a-switch>
            <a-button class="ml-5" @click="saveSelected">Save Selected</a-button>
            <inertia-link :href="route('manage.activities.index')" class="ant-btn">Back</inertia-link>
            <a-divider></a-divider>
            <a-row class="bg-white">
                <a-col :span="10">
                    <label>名單<span>{{  }}</span></label>
                    <div class="h-full overflow-y-scroll border box-border px-2">
                        <template v-if="importMode">
                            <a-textarea v-model:value="importStudents" :rows="20">aa</a-textarea>
                        </template>
                        <template v-else>
                            <div>
                                <template v-for="student in fromStudents">
                                    <a-checkbox v-model:checked="student.selected">{{ student.name_zh }}</a-checkbox><br>
                                </template>
                            </div>
                        </template>
                    </div>
                </a-col>
                <a-col :span="4" :style="{ display: 'flex', alignItems: 'center' }">
                    <span class="m-auto">
                        <p>&nbsp;</p>
                        <a-button @click="moveAll" block class="mb-4">全部人參加 =&gt;</a-button><br>
                        <a-button @click="moveSelected" block class="mb-4">已選人參加 =&gt;</a-button><br>
                        <a-button @click="removeSelected" block class="mb-4"> &lt;= 已選人不參加</a-button><br>
                        <a-button @click="removeAllSelected" block class="mb-4"> &lt;= 全部人不參加</a-button><br>
                        <a-button v-if="importMode" @click="onSearchImport" block>滙入</a-button><br>
                    </span>
                </a-col>
                <a-col :span="10">
                    <label>已選</label>
                    <div class="h-full overflow-y-scroll border box-border px-2">
                        <div>
                            <template v-for="student in toStudents">
                                <a-checkbox v-model:checked="student.selected">{{ student.name_zh }}</a-checkbox><br>
                            </template>
                        </div>
                    </div>
                </a-col>
            </a-row>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { affixProps } from 'ant-design-vue/lib/affix';
import dayjs from 'dayjs';

export default {
    components: {
        AdminLayout,
        dayjs,
    },
    props: ['klasses', 'grades','activity'],
    data() {
        return {
            selectedGrade: 4,
            importMode: false,
            importStudents:'',
            fromStudents: {},
            toStudents:{},
            columns: [
                {
                    title: '學期',
                    dataIndex: 'term_id',
                }, {
                    title: '活動主題',
                    dataIndex: 'title_zh',
                }, {
                    title: '開始日期',
                    dataIndex: 'date_start',
                }, {
                    title: '結束日期',
                    dataIndex: 'date_end',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ],

        }
    },
    created() {
        // dayjs.locale('en');
    },
    mounted(){
        this.activity.students.forEach(std=>{
            std.selected=false
            this.toStudents[std.id]=std
        })
    },
    methods: {
        saveSelected(){
            var data={}
            Object.entries(this.toStudents).forEach(([key,std])=>{
                data[std.id]={klass_id:std.klass.id};
            })
            this.$inertia.put(route('manage.activity.students.sync', {activity:1,student:1}), data, {
                onSuccess: (page) => {
                    console.log(page);
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
        onSearch(value) {
            this.getStudentByNames(value.split());
        },
        onSearchImport() {
            var items = this.importStudents.split(/[',|;|\r|\n']/).filter(i => i !== '')
            this.getStudentByNames(items);
        },
        getStudentsByKlass(klass) {
            //this.modal.data.selectedStudents = []
            this.student=[];
            axios.get(route('manage.students.getByKlassId', klass.id), {
                klass: klass.id
            }).then(res => {
                this.fromStudents={}
                res.data.forEach(std=>{
                    this.fromStudents[std.id]=std
                })
                this.importMode = false
            })
        },
        getStudentByNames(items) {
            axios.post(route('manage.students.getByNames'), items).then(res => {
                this.fromStudents={}
                res.data.forEach(std=>{
                    this.fromStudents[std.id]=std
                })
                this.importMode = false
            })
        },
        moveSelected(){
            Object.entries(this.fromStudents).forEach(([key,std])=>{
                if(std.selected){
                    std.selected=false
                    this.toStudents[std.id]={...std}
                    //this.fromStudents[std]
                    delete this.fromStudents[key]
                }
            })
        },
        moveAll(){
            Object.entries(this.fromStudents).forEach(([key,std])=>{
                this.toStudents[std.id]={...std}
            })
            this.fromStudents={}
        },
        removeSelected(){
            Object.entries(this.toStudents).forEach(([key,std])=>{
                console.log(std)
                if(std.selected==true){
                    std.selected=false
                    this.fromStudents[std.id]={...std}
                    delete this.toStudents[std.id]
                }
            })
        },
        removeAllSelected(){
            Object.entries(this.toStudents).forEach(([key,std])=>{
                std.selected=false
                this.fromStudents[std.id]={...std}
            })
            this.toStudents={}
        },
    },
}
</script>

