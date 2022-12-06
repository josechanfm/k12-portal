<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Year Plan Dashboard
            </h2>
        </template>
        <p>Year: {{year}}</p>
        <p>Grades: {{grades}}</p>
        <p>Next Year: {{nextYear}}</p>
        <p>Grade: {{grade}}</p>
        <p>Next Grade: {{nextGrade}}</p>
        <p>Klass: {{klass}}</p>
        <p>Next Klasses: {{nextKlasses}}</p>
<!-- 
        <p>Year: {{year}}</p>
        
        <p>Grades:{{grades}}</p>
        <hr>
        <p>{{klassesSubjects}}</p> 
 -->
       <div>
        Selected Item:
        <a-select
            style="width: 120px"
        >
            <a-select-option value="a">Promote to: </a-select-option>
        </a-select>
        
       </div>
       <div class="float-right">
        <a-button type="primary">Promote</a-button>
       </div>
       
        
        <table width="100%">
            <thead>
                <tr>
                    <th class="text-left"><a-checkbox v-model:checked="selectAll"/>Selection</th>
                    <th class="text-left">Name</th>
                    <th class="text-left">Gender</th>
                    <th class="text-left">Stream</th>
                    <th class="text-left">State</th>
                    <th class="text-left">Promote</th>
                    <th class="text-left">Promote to</th>
                    <th class="text-left">Operation</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="student in students">
                    <td class="text-left">
                        <a-checkbox v-model:checked="student.selected"/>

                    </td>
                    <td class="text-left">{{student.name_zh}}</td>
                    <td class="text-left">{{student.gender}}</td>
                    <td class="text-left">
                        <StudyStream :stream="student.pivot.stream"/>
                    </td>
                    <td class="text-left">{{student.pivot.state}}</td>
                    <td class="text-left">
                        <PromoteState :state="student.pivot.promote"/>
                    </td>
                    <td class="text-left">
                        <PromoteLetters :grade="1" :student="student"/>
                    </td>
                    <td>
                        actions
                    </td>
                </tr>
            </tbody>
        </table>

        <p></p>
        <div>
            <PromoteState :state="-1"/>
            <PromoteState :state="0"/>
            <PromoteState :state="1"/>
            <PromoteState :state="2"/>
       </div>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';
import PromoteState from '@/Components/PromoteState.vue';
import PromoteLetters from '@/Components/PromoteLetters.vue';
import StudyStream from '@/Components/StudyStream.vue'

export default {
    components: {
        AdminLayout,
        PromoteState,
        PromoteLetters,
        StudyStream
    },
    props: ['year','grades'],
    data() {
        return {
            selectAll:false,
            activeKey:"1",
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
