<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Klasses in the year
            </h2>
        </template>
        Title: {{year.abbr}}-{{year.title}}
        <br>
        Time: {{year.start}}-{{year.end}}
        <br>
        Description: {{year.description}}
        <table border="1" width="100%">
            <tr v-for="subject in subjects">
                <td>{{subject.abbr}}{{subject.title_zh}}</td>
                <td>
                    <a-select
                    v-model:value="subject.klasses"
                    :options="config"
                    mode="tags"
                    placeholder="Please select"
                    style="width: 200px"
                    ></a-select>
                    
                </td>
            </tr>
        </table>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['year','subjects','klasses','config'],
    data() {
        return {
            subjectKlasses: [],
        }
    },
    methods: {

    },
}
</script>