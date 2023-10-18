<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                學年階段之班別
            </h2>
        </template>
        <a-typography-title :level="4">學年:{{ grade.year.title }}</a-typography-title>
        <a-typography-title :level="4">年級:{{ grade.tag }}</a-typography-title>
        <inertia-link v-for="g in grades" :href="route('admin.grade.klasses.index', g.id)"
            class="px-3 py-2 mr-2 rounded text-white text-sm font-bold whitespace-no-wrap bg-blue-600 hover:bg-blue-800">{{
                g.tag }}</inertia-link>
        <a-button @click="createRecord()" type="primary">新增班別</a-button>
        <a-table :dataSource="klasses" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <inertia-link v-if="record.grade.grade_year <= 3" :href="route('admin.klass.themes.index', record.id)"
                        class="ant-btn">主題</inertia-link>
                    <inertia-link v-else :href="route('admin.klass.courses.index', record.id)" class="ant-btn">科目</inertia-link>
                    <inertia-link :href="route('admin.select.students.index', {type:'klass',id:record.id})" class="ant-btn">學生</inertia-link>
                    <a-button @click="editRecord(record)">修改</a-button>
                    <a-button @click="lockTranscript(record)">鎖定成積表</a-button>
                </template>
                <template v-else-if="column.dataIndex == 'head_teacher'">
                    <!-- {{ record.klass_heads }} -->
                    {{ record.klass_heads.map(t=>t.name_zh).toString() }}
                </template>
                <template v-else-if="column.dataIndex == 'room'">
                    {{ record.courses.teachers }}
                </template>
                <template v-else-if="column.dataIndex == 'courses'">
                    {{ record.course_count }}
                    <!-- <a-popover :title="'Courses for ' + record.tag">
                        <template #content>
                            <span v-for="course in record.courses">
                                <p v-if="course != undefined && course.type == 'SUB'">
                                    {{ course.code }}-{{ course.title_zh }}
                                </p>
                            </span>
                        </template>
                        <a>{{ record.courses.length }}</a>
                    </a-popover> -->
                </template>
                <template v-else-if="column.dataIndex == 'students'">
                    {{ record.student_count }}
                    <!-- {{ record.students.length }} -->
                </template>
                <template v-else-if="column.dataIndex == 'transcript_migrated'">
                    <span v-if="text == 9">
                        <svg fill="#e13737" height="20px" width="20px" version="1.1" id="Layer_1"
                            xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                            viewBox="0 0 330 330" xml:space="preserve" stroke="#e13737">
                            <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                            <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                            <g id="SVGRepo_iconCarrier">
                                <g id="XMLID_504_">
                                    <path id="XMLID_505_"
                                        d="M65,330h200c8.284,0,15-6.716,15-15V145c0-8.284-6.716-15-15-15h-15V85c0-46.869-38.131-85-85-85 S80,38.131,80,85v45H65c-8.284,0-15,6.716-15,15v170C50,323.284,56.716,330,65,330z M207.481,219.356l-42.5,42.5 c-2.929,2.929-6.768,4.394-10.606,4.394s-7.678-1.465-10.606-4.394l-21.25-21.25c-5.858-5.858-5.858-15.354,0-21.213 c5.857-5.858,15.355-5.858,21.213,0l10.644,10.643l31.894-31.893c5.857-5.858,15.355-5.858,21.213,0 C213.34,204.002,213.34,213.498,207.481,219.356z M110,85c0-30.327,24.673-55,55-55s55,24.673,55,55v45H110V85z">
                                    </path>
                                </g>
                            </g>
                        </svg>
                    </span>
                    <span v-else-if="text == 1">
                        <svg height="20px" width="20px" xmlns="http://www.w3.org/2000/svg" fill="#1c9504"
                            viewBox="0 0 24 24" stroke="#1c9504">
                            <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                            <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                            <g id="SVGRepo_iconCarrier">
                                <path
                                    d="M3.8 9.2c0-.9 1-2.6 2.3-3.1s3.3-.5 6-.5c2.9 0 5.8.5 5.8.5l-2.3-2.3 1-1.9L22 7.4l-5.5 5.5-1-1.9 2.3-2.3s-2.9-.5-5.9-.5c-2.6 0-4.6 0-5.9.5s-2.2 3.7-2.2 3.7V9.2z">
                                </path>
                                <path
                                    d="M20.2 14.8c0 .9-1 2.6-2.3 3.1s-3.3.5-6 .5c-2.9 0-5.8-.5-5.8-.5l2.3 2.3-1 1.9L2 16.6l5.5-5.5 1 1.9-2.3 2.3s2.9.5 5.9.5c2.6 0 4.6 0 5.9-.5s2.2-3.7 2.2-3.7v3.2z">
                                </path>
                            </g>
                        </svg>
                    </span>
                    <span v-else>
                        <svg height="28px" width="28px" viewBox="0 0 2050 2050" data-name="Layer 3" id="Layer_3"
                            xmlns="http://www.w3.org/2000/svg" fill="#6e6e6e" stroke="#6e6e6e">
                            <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                            <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                            <g id="SVGRepo_iconCarrier">
                                <path class="cls-1"
                                    d="M503.6,1165.9a45,45,0,0,1-44.8-48.9l14.4-164.6a44.9,44.9,0,0,1,13-27.9L947.8,462.9a45.1,45.1,0,0,1,63.6,0l150.2,150.3a44.9,44.9,0,0,1,0,63.6L700,1138.4a44.4,44.4,0,0,1-27.9,13l-164.5,14.3Zm164.6-59.4Z">
                                </path>
                                <path class="cls-1" d="M1560.8,1113.6H926.3a45,45,0,0,1,0-90h634.5a45,45,0,1,1,0,90Z">
                                </path>
                                <path class="cls-1" d="M1560.8,1338.4H503.6a45,45,0,1,1,0-90H1560.8a45,45,0,0,1,0,90Z">
                                </path>
                                <path class="cls-1" d="M1560.8,1563.2H503.6a45,45,0,0,1,0-90H1560.8a45,45,0,0,1,0,90Z">
                                </path>
                            </g>
                        </svg> </span>
                </template>
                <template v-else>
                    {{ record[column.dataIndex] }}
                </template>
            </template>
        </a-table>

        <!-- Modal Start-->
        <a-modal v-model:visible="modal.isOpen" :title="modal.title" width="60%">
            <a-form ref="modalRef" :model="modal.data" name="klasses" :label-col="{ span: 8 }" :wrapper-col="{ span: 16 }"
                autocomplete="off" :rules="rules" :validate-messages="validateMessages">
                <a-form-item label="年級代號" name="grade">
                    {{ grade.tag }}
                </a-form-item>
                <a-form-item label="班別號" name="letter">
                    <a-select v-model:value="modal.data.letter" style="width: 100%" placeholder="請選擇..."
                        max-tag-count="responsive" :options="klassLetters"></a-select>
                </a-form-item>
                <a-form-item label="學生計劃" name="study_id">
                    <a-select v-model:value="modal.data.study_id" style="with:100%" placeholder="請選擇..."
                        max-tag-count="responsive" :options="studies"
                        :field-names="{ label: 'title_zh', value: 'id' }"></a-select>
                </a-form-item>
                <a-form-item label="教室編號" name="room">
                    <a-input v-model:value="modal.data.room" />
                </a-form-item>
                <a-form-item label="班主任" name="klass_head_ids">
                    <a-select v-model:value="modal.data.klass_head_ids" style="with:100%" placeholder="請選擇..."
                        max-tag-count="responsive" :options="teachers" mode="multiple"
                        :field-names="{ label: 'name_zh', value: 'id' }"></a-select>
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button v-if="modal.mode == 'EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
                <a-button v-if="modal.mode == 'CREATE'" key="Store" type="primary" @click="storeRecord()">Add</a-button>
            </template>
        </a-modal>
        <!-- Modal End-->
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';

export default {
    components: {
        AdminLayout,
        ButtonLink,
    },
    props: ['grades', 'grade', 'klasses', 'klassLetters', 'studyStreams', 'studies','teachers'],
    data() {
        return {
            gradeSelected: 1,
            modal: {
                mode: null,
                isOpen: false,
                title: 'Klasses',
                data: {}
            },
            dataSource: [],
            columns: [
                {
                    title: '班別代號',
                    dataIndex: 'tag',
                }, {
                    title: '班主任',
                    dataIndex: 'head_teacher',
                }, {
                    title: '教室編號',
                    dataIndex: 'room',
                }, {
                    title: '科目數目',
                    dataIndex: 'courses',
                }, {
                    title: '學生人數',
                    dataIndex: 'students',
                }, {
                    title: '成積表鎖定',
                    dataIndex: 'transcript_migrated',
                }, {
                    title: '操作',
                    dataIndex: 'operation',
                },
            ],
            rules: {
                letter: {
                    required: true,
                },
                study_id: {
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

        }
    },
    methods: {
        closeModal() {
            this.isOpen = false;
            this.reset();
            this.editMode = false;
        },
        storeRecord() {
            console.log(this.modal.data);
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.post('/admin/klasses/', this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                        console.log(page);
                    },
                    onError: (err) => {
                        console.log(err);
                    }
                });
            }).catch(err => {
                console.log(err);
            });
        },
        updateRecord() {
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.put('/admin/klasses/' + this.modal.data.id, this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });

        },
        editRecord(record) {
            this.modal.data = { ...record };
            this.modal.mode = 'EDIT';
            this.modal.title = "修改班別";
            this.modal.isOpen = true;
        },
        createRecord() {
            this.modal.data = {};
            this.modal.data.grade_id = this.grade.id;
            this.modal.mode = 'CREATE';
            this.modal.title = "新增班別";
            this.modal.isOpen = true;
            this.klasses.forEach(klass => {
                this.klassLetters.forEach((kl, idx) => {
                    if (klass.letter == kl.value) {
                        this.klassLetters[idx].disabled = true;
                    }
                })
            })
        },
        onChangeGradeSelect() {
            console.log(this.gradeSelected);
            //this.$inertia.get('klasses?gid='+this.gradeSelected);
        },
        getStudyPlan(text) {
            const study = this.studyPlans.find(study => study.id == text)
            return text;
            //return study.title_zh + " (v."+study.version+")"
        },
        lockTranscript(record) {
            if (!confirm('鎖定成積表分數轉換功能，是不確定？')) return;
            this.$inertia.get(route('admin.lockTranscripts'), { scope: 'klass', id: record.id }, {
                onSuccess: (page) => {
                    console.log(page);
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        }

    },
}
</script>
