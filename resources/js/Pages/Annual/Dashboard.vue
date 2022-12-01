<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Year Plan Dashboard
            </h2>
        </template>

        <p>Year: {{year}}</p>
        <p>Klass: {{klasses}}</p>
        <p>Grades:{{grades}}</p>
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
            <a-tab-pane key="1" tab="Grade">
                <h3>Number of class for each grade</h3>
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Value</th>
                            <th class="text-left">Label</th>
                            <th class="text-left">Number of class</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="grade in grades">
                            <td class="text-left">{{grade.value}}</td>
                            <td class="text-left">{{grade.label}}</td>
                            <td>
                                <a-select
                                    ref="select"
                                    v-model:value="grade.klasses"
                                    style="width: 120px"
                                    :options="klassNumber"
                                ></a-select>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </a-tab-pane>
            <a-tab-pane key="2" tab="Subjects" force-render>
                <h3>Subjects for grades</h3>
                <table width="100%">
                    <thead>
                        <tr>
                            <th class="text-left">Abbr</th>
                            <th class="text-left">Title zh</th>
                            <th class="text-left">Title en</th>
                            <th class="text-left">Type</th>
                            <th class="text-left">For grade</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="subject in subjects" :key="subject.id">
                            <td class="text-left">{{subject.abbr}}</td>
                            <td class="text-left">{{subject.title_zh}}</td>
                            <td class="text-left">{{subject.title_en}}</td>
                            <td class="text-left">{{subject.type}}</td>
                            <td>
                                <a-select
                                    v-model="subject.forGrades"
                                    mode="multiple"
                                    style="width: 100%"
                                    :options="grades"
                                ></a-select>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </a-tab-pane>

            <a-tab-pane key="3" tab="Klass">
                <h3>List all grade class with subjects</h3>
                <a-table :columns="klassColumns" :data-source="klassesSubjects" class="components-table-demo-nested">
                    <template #expandedRowRender="{record}">
                        <a-table :columns="subjectColumns" :data-source="record.subjects" :pagination="false">

                        </a-table>
                    </template>
                </a-table>

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
            activeKey:"1",
            klassNumber:[
                { value: "A", label: 'A' },
                { value: "B", label: 'B' },
                { value: "C", label: 'C' },
                { value: "D", label: 'D' },
                { value: "E", label: 'E' },
                { value: "F", label: 'F' },
            ],
            klassColumns: [
                {
                    title: 'Grade',
                    dataIndex:'grade',
                },
                {
                    title: 'Initial',
                    dataIndex:'initial',
                }
            ],
            subjectColumns: [
                {
                    title: 'Abbr',
                    dataIndex:'abbr',
                },
                {
                    title: 'Title Zh',
                    dataIndex:'title_zh',
                }
            ]
        }
    },
    methods: {

    },
}
</script>
