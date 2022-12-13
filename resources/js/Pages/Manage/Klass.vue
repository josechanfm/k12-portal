<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                班別管理
            </h2>
        </template>
        {{klass}}
        <hr>
        {{courses}}
        <p></p>
        <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Abbr</th>
                            <th class="text-left">Title Zh</th>
                            <th class="text-left">Stream</th>
                            <th class="text-left">Elective</th>
                            <th class="text-left">Active</th>
                            <th class="text-left">Score Scheme</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(course, courseKey) in courses" :course_id="course.id">
                            <td class="text-left">{{ course.abbr }}</td>
                            <td class="text-left">{{ course.title_zh }}</td>
                            <td class="text-left">{{ course.stream }}</td>
                            <td class="text-left">{{ course.elective }}</td>
                            <td class="text-left">{{ course.active }}</td>
                            <th class="text-left"><span @click="modify_score_scheme(courseKey)">Score Scheme</span></th>
                        </tr>
                    </tbody>
                </table>

                <a-modal v-model:visible="modelScoreScheme" title="Score Scheme" @ok="handleOk">
                    <p>{{course}}</p>
                    <p>{{courseSchemeConfig}}</p>
                    <p>Some contents...</p>
                    <a-select
                        v-model:value="value"
                        mode="tags"
                        style="width: 100%"
                        placeholder="Tags Mode"
                        :options="score_columns.map(col => {
                            const entr = Object.entries(col)[0]
                            return { label: entr[1], value: entr[0]}
                        })"
                        @change="handleChange"
                    ></a-select>
                    <p>
                        {{score_columns}}
                        <ul>
                            <li v-for="column in JSON.parse(this.course.score_column).semester">{{column}}</li>
                        </ul>
                    </p>
                </a-modal>                

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';


export default {
    components: {
        AdminLayout
    },
    props: ['grade','klass','courses','students','score_columns'],
    data() {
        return {
            value: [],
            modelScoreScheme:false,
            course:{},
            courseSchemeConfig:{
                "scope":[
                    {"REG":"平時分"},
                    {"TST":"測驗分"},
                    {"CLS":"課堂表現"},
                    {"EXM":"考試分"},
                ],
                "mark":[
                    {"P100":"0-100分"},
                    {"P999":"無限制數值分"},
                    {"GAF":"等級: A,B,C,D,E,F"},
                    {"G16":"等級: 甲、乙、丙、丁、戊、己"},
                    {"MPF":"合格/不合格"},
                ],
                "mark":[
                    {"P100":"0-100分"},
                    {"P999":"無限制數值分"},
                    {"GAF":"等級: A,B,C,D,E,F"},
                    {"G16":"等級: 甲、乙、丙、丁、戊、己"},
                    {"MPF":"合格/不合格"},
                ],
                "formula":{

                }
            }
        }
    },
    mounted(){
    },
    methods: {
        modify_score_scheme(courseKey){
            this.course={...this.courses[courseKey]};
            console.log(this.course);
            this.modelScoreScheme=true;
        },
        handleOk(){

        }
    },
}
</script>




