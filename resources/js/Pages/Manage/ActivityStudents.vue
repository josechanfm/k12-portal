<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                課外活動
            </h2>
        </template>
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
            <a-switch v-model:checked="searchMultiple" @click="">By List</a-switch><br>
            <a-divider></a-divider>
            <a-row class="bg-white">
                <a-col :span="10">
                    <label>名單</label>
                    <div class="h-full overflow-y-scroll border box-border px-2">
                        <template v-if="searchMultiple">
                            <a-textarea v-model:value="importStudents" :rows="20">aa</a-textarea>
                        </template>
                        <template v-else>
                            <div>
                                <a-checkbox-group v-model:value="fromSelected">
                                    <template v-for="student in fromStudents">
                                        <a-checkbox :value="student.id">{{ student.name_zh }}</a-checkbox><br>
                                    </template>
                                </a-checkbox-group>
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
                        <a-button v-if="searchMultiple" @click="onSearchImport" block>滙入</a-button><br>
                    </span>
                </a-col>
                <a-col :span="10">
                    <label>已選</label>
                    <div class="h-full overflow-y-scroll border box-border px-2">
                        <div>
                            <a-checkbox-group v-model:value="toSelected">
                                <template v-for="student in toStudents">
                                    <a-checkbox :value="student.id">{{ student.name_zh }}</a-checkbox><br>
                                </template>
                            </a-checkbox-group>
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
    props: ['terms', 'staffs', 'extracurriculars', 'activities', 'klasses', 'grades','activityStudents'],
    data() {
        return {
            dateFormat: 'YYYY-MM-DD',
            searchMultiple: false,
            selectedGrade: 4,
            //selectedStudents: [],
            importStudents:'',
            fromStudents: {},
            toStudents:{},
            fromSelected:[],
            toSelected:[],
            modal: {
                mode: null,
                isOpen: false,
                title: '課外活動',
                data: {}
            },
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
        this.activityStudents.forEach(std=>{
            this.toStudents[std.id]=std
        })

    },
    methods: {
        onFinish(values) {
            console.log('finished')
            // if (this.modal.mode == 'EDIT') {
            this.$inertia.put(route('admin.activities.update', this.modal.data.id), this.modal.data, {
                onSuccess: (page) => {
                    this.modal.isOpen = false;
                },
                onError: (error) => {
                    console.log(error);
                }
            });
            // }
            // if (this.modal.mode == 'CREATE') {
            //     this.$inertia.post(route('admin.activities.store'), this.modal.data, {
            //         onSuccess: (page) => {
            //             this.modal.isOpen = false;
            //         },
            //         onError: (error) => {
            //             console.log(error);
            //         }
            //     });
            // }
        },
        onSearch(value) {
            this.getStudentByNames(value.split());
        },
        onSearchImport() {
            var items = this.importStudents.split(/[',|;|\r|\n']/).filter(i => i !== '')
            console.log(items);
            this.getStudentByNames(items);
        },
        getStudentsByKlass(klass) {
            this.modal.data.selectedStudents = []
            this.student=[];
            axios.get(route('manage.students.getByKlassId', klass.id), {
                klass: klass.id
            }).then(res => {
                this.fromStudents = res.data
                this.searchMultiple = false
            })
        },
        getStudentByNames(items) {
            this.activityStudents.selectedStudents = []
            axios.post(route('manage.students.getByNames'), items).then(res => {
                this.students = res.data
                this.searchMultiple = false
            })
        },
        moveSelected(){
            this.fromStudents.forEach(std=>{
                if(this.fromSelected.includes(std.id)){
                     this.toStudents[std.id]=std
                }
            })
        },
        moveAll(){
            this.fromStudents.forEach(std=>{
                this.toStudents[std.id]=std
            })

        },
        removeSelected(){
            console.log(this.toStudents);
            if(!this.modal.data.unselectedStudents || this.modal.data.unselectedStudents.length==0) return true;
            Object.entries(this.modal.data.students).forEach(([key,std])=>{
                console.log(key)
                if(this.modal.data.unselectedStudents.includes(std.id)){
                    delete this.modal.data.students[key]
                }
            })
            this.modal.data.unselectedStudents=[]
        },
        removeAllSelected(){
            this.modal.data.students={};
            this.modal.data.unselectedStudents=[]
        },
    },
}
</script>
