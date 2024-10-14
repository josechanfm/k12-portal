<template>
<AdminLayout title="學生註冊表">
    <div class="flex gap-1 font-black">
        <div class="capsule-outline">
            <div class="capsule-label">入讀學年</div>
            <div>{{currentYear.title}}</div>
            <template v-if="currentYear.code!=nextYear.code">
                <div>-</div>
                <div>{{nextYear.title}}</div>
            </template>
        </div>
    </div>
    <div class="flex justify-center  bg-white  rounded-lg flex-wrap  p-2 md:flex-wrap lg:flex-nowrap">
        <div class="bg-slate-200 m-2 p-1 rounded-lg  w-full">
            <div class="text-2xl font-black text-zinc-600">學生</div>
            <div class="flex flex-col gap-1">
                <div class="flex ">
                    <div class="card-label">中文姓名</div>
                    <div class="card-value">{{ student.name_zh }}</div>
                </div>
                <div class="flex">
                    <div class="card-label">外文姓名:</div>
                    <div class="card-value">{{ student.name_fn }}</div>
                </div>
                <div class="flex">
                    <div class="card-label">性別:</div>
                    <div class="card-value">{{ student.gender }}</div>
                </div>
                <div class="flex">
                    <div class="card-label">出生日期:</div>
                    <div class="card-value">{{ student.dob }}</div>
                </div>
            </div>
        </div>
        <div class="bg-slate-200 m-2 p-1 rounded-lg  w-full">
            <div class="text-2xl font-black text-zinc-600">報名表</div>
            <div v-if='candidate' class="flex flex-col gap-1">
                <div class="flex">
                    <div class="card-label">外文姓名:</div>
                    <div class="card-value">{{ candidate.name_fn }}</div>
                </div>
                <div class="flex">
                    <div class="card-label">外文姓名:</div>
                    <div class="card-value">{{ candidate.name_fn }}</div>
                </div>
                <div class="flex">
                    <div class="card-label">性別:</div>
                    <div class="card-value">{{ candidate.name_gender }}</div>
                </div>
                <div class="flex">
                    <div class="card-label">出生日期:</div>
                    <div class="card-value">{{ candidate.name_dob }}</div>
                </div>
                <div class="flex">
                    <div class="card-label">報讀年級:</div>
                    <div class="card-value">{{ candidate.start_grade }}</div>
                </div>
                <div class="flex">
                    <div class="card-label">報讀班別</div>
                    <div class="card-value">{{ candidate.start_klass }}</div>
                </div>
                <a-button type="info"  as="link" :href="route('admin.candidates.edit',candidate.id)" target="_blank">檢看報名表</a-button>
            </div>
        </div>
    </div>
    <div class="bg-white p-1 my-1 rounded-lg">
        <div class="student-form-layout bg-neutral-200 my-1 rounded-lg p-2 flex-col gap-1  ">
            <div class="text-2xl font-black text-zinc-600">報名表</div>
            <a-form class="font-black w-full"  :model="enroll" :rules="rules" @finish="onFinish" @finishFailed="onFinishFailed">
                <a-form-item label="入讀學年" name="year_id">
                    <a-radio-group v-model:value="enroll.year_id" button-style="solid">
                        <a-radio-button :value="currentYear.id" @click="refresh(currentYear)">本學年 {{ currentYear.title }}</a-radio-button>
                        <a-radio-button v-if="currentYear.code!=nextYear.code" :value="nextYear.id" @click="refresh(nextYear)">下學年 {{ nextYear.title }}</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="級別" name="grade_id">
                    <a-select v-model:value="enroll.grade_id" :options="grades" :fieldNames="{value:'id',label:'tag'}" @change="onChangeGrade" />
                </a-form-item>
                <a-form-item label="班別" name="klass_id" v-if="enroll.grade_id">
                    <a-select v-model:value="enroll.klass_id" :options="grades.find(g=>g.id==enroll.grade_id).klasses" :fieldNames="{value:'id',label:'tag'}" />
                </a-form-item>
                <a-form-item>
                    <div class="flex">
                        <div class="flex-1"></div>
                        <a-button class="text-lg h-fit font-black" type="primary" html-type="submit">提交並分配學生</a-button>
                    </div>
                </a-form-item>
            </a-form>
        </div>
    </div>
    <div class="text-red-500">
        若下個學年未創建，此功能再無效！
    </div>
</AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['currentYear', 'nextYear', 'year', 'student', 'candidate'],
    data() {
        return {
            selectedGrade: {},
            selectedKlass: {},
            grades: [],
            klasses: [],
            enroll: {
                candidate_id: this.candidate ? this.candidate.id : null,
                student_id: this.student.id,
                year_id: null,
                grade_id: null,
                klass_id: null,
            },
            rules: {
                year_id: {
                    required: true
                },
                grade_id: {
                    required: true
                },
                klass_id: {
                    required: true
                },
            }
        }
    },
    created() {
        //根據報名表預設入讀年級及班別，班別預設為第一個班
        this.refresh(this.nextYear)
    },
    methods: {
        refresh(year) {
            this.enroll.year_id = year.id
            this.grades = year.grades_klasses
            this.enroll.grade_id = this.grades.find(g => g.tag == this.candidate.start_grade_tag).id
            this.enroll.klass_id = this.grades.find(g => g.id == this.enroll.grade_id).klasses[0].id

        },
        onChangeGrade() {
            this.enroll.klass_id = this.grades.find(g => g.id == this.enroll.grade_id).klasses[0].id
        },
        onFinish() {
            console.log('on finish');
            console.log(this.enroll, this.student);
            this.$inertia.post(route('admin.enrollments.store'), this.enroll, {
                onSuccess: (page) => {
                    console.log('enrolled');
                },
                onError: (error) => {
                    console.log(error);
                }
            });

        },
        onFinishFailed() {
            console.log('on Finish Failed')
        }
    }
}
</script>

<style scoped>
.card-label {
    @apply bg-neutral-300 text-lg text-zinc-500 font-black w-32 rounded-l-lg px-1 text-right
}

.card-value {
    @apply bg-neutral-100 text-lg text-gray-500 font-semibold px-2 text-left w-full
}
</style>
