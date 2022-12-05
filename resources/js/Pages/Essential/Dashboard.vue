<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Year Plan Dashboard
            </h2>
        </template>

        <p>Year: {{year}}</p>
        <!-- <p>Klass: {{klasses}}</p> -->
        <!-- <p>Grades:{{grades}}</p> -->
        <hr>
        <p>{{klassesSubjects}}</p> 


        <a-steps :current="1">
            <a-step>
            <!-- <span slot="title">Finished</span> -->
            <template #title>Finished</template>
            <template #description>
                <span>This is a description.</span>
            </template>
            </a-step>
            <a-step title="In Progress" sub-title="Left 00:00:08" description="This is a description." />
            <a-step title="Waiting" description="This is a description." />
        </a-steps>        
        <a-tabs v-model:activeKey="activeKey">
            <a-tab-pane key="grade" tab="Grade">
                <h3>Number of class for each grade</h3>
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Level</th>
                            <th class="text-left">Initial</th>
                            <th class="text-left">Tag</th>
                            <th class="text-left">Titile Zh</th>
                            <th class="text-left">Version</th>
                            <th class="text-left">Active</th>
                            <th class="text-left">Operation</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(grade, key) in grades">
                            <td class="text-left">{{grade.level}}</td>
                            <td class="text-left">{{grade.initial}}</td>
                            <td class="text-left">{{grade.tag}}</td>
                            <td class="text-left">{{grade.title_zh}}</td>
                            <td class="text-left">{{grade.version}}</td>
                            <td class="text-left">{{grade.active}}</td>
                            <td class="text-left"><span @click="selectGrade(key)">Klass</span></td>
                        </tr>
                    </tbody>
                </table>
            </a-tab-pane>
            <a-tab-pane key="klass" :tab="'Klass '+ (selectedGrade.tag!=='undefined'?selectedGrade.tag:'')" :disabled="(selectedGrade.length===0)">
                <h3>Level: {{selectedGrade.level}}</h3>
                <h3>Initial: {{selectedGrade.initial}}</h3>
                <h3>Tag: {{selectedGrade.tag}}</h3>
                <h3>Title: {{selectedGrade.title_zh}}</h3>
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Letter</th>
                            <th class="text-left">Tag</th>
                            <th class="text-left">Acronym</th>
                            <th class="text-left">Room</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="klass in selectedGrade.klasses">
                            <td class="text-left">{{klass.letter}}</td>
                            <td class="text-left">{{klass.tag}}</td>
                            <td class="text-left">{{klass.acronym}}</td>
                            <td class="text-left">{{klass.room}}</td>
                        </tr>
                    </tbody>
                </table>
            </a-tab-pane>
        </a-tabs>
                
        <p></p>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['year','subjects', 'klasses','config','grades','klassesSubjects'],
    data() {
        return {
            activeKey:"grade",
            selectedGrade:[],
            // klassNumber:[
            //     { value: "A", label: 'A' },
            //     { value: "B", label: 'B' },
            //     { value: "C", label: 'C' },
            //     { value: "D", label: 'D' },
            //     { value: "E", label: 'E' },
            //     { value: "F", label: 'F' },
            // ],
            // klassColumns: [
            //     {
            //         title: 'Grade',
            //         dataIndex:'grade',
            //     },
            //     {
            //         title: 'Initial',
            //         dataIndex:'initial',
            //     }
            // ],
            // subjectColumns: [
            //     {
            //         title: 'Abbr',
            //         dataIndex:'abbr',
            //     },
            //     {
            //         title: 'Title Zh',
            //         dataIndex:'title_zh',
            //     }
            // ]
        }
    },
    methods: {
        selectGrade(gradeId){
            console.log(gradeId);
            this.selectedGrade = {...this.grades[gradeId]};
            this.activeKey="klass";
        }
    },
}
</script>
