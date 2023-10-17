<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Year: {{ klass.year_code }}
            </h2>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Class: {{ klass.tag }}
            </h2>
        </template>

        <div class="py-12">
            <div class="mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-button type="primary" @click="saveAbilities">更新並保存</a-button>
                    <a-divider type="vertical" />
                    <a-select
                        v-model:value="selectedThemeId"
                        :options="klass.themes.filter(theme=>theme.term_id==selectedTermId)"
                        :field-names="{value:'id',label:'title'}"
                    ></a-select>
                    
                    <a-divider type="vertical" />
                    <a-radio-group v-model:value="selectedTermId" button-style="solid" @change="onChangeTerm">
                        <template v-for="term in yearTerms">
                            <a-radio-button :value="term.value">{{term.label}}</a-radio-button>
                        </template>
                    </a-radio-group>
                    <a-divider type="vertical" />
                    <a :href="route('manage.pre.klass.abilities.pdf',klass.id)" class="ant-btn">報告by Theme</a>
                    <a-divider type="vertical" />
                    <a :href="route('manage.pre.klass.abilities.pdf',klass.id)" class="ant-btn">報告</a>
                    <table id="abilityTable" ref="abilityTable">
                        <thead>
                            <tr>
                                <th rowspan="2">Student name</th>
                                <template v-for="topic in klass.themes.find(theme=>theme.id==selectedThemeId).topics"  >
                                    <th class="text-center">
                                        {{ topic.section }} 
                                    </th>
                                </template>
                                <td rowspan="2">Report</td>
                            </tr>
                            <tr>
                                <template v-for="topic in klass.themes.find(theme=>theme.id==selectedThemeId).topics"  >
                                    <th class="text-center">
                                        {{ topic.abbr }}
                                        <!-- <a-tooltip>
                                            <template #title>[{{topic.theme.title}}]<br>{{ topic.title }}</template>
                                            {{ topic.abbr }} 
                                        </a-tooltip> -->
                                    </th>
                                </template>
                            </tr>

                        </thead>
                        <tbody>
                            <template v-for="(student, ksid) in abilities['students']">
                                <tr>
                                    <td>{{ student.name_zh }}{{ ksid }}</td>
                                    <template v-for="topic in klass.themes.find(theme=>theme.id==selectedThemeId).topics"  >
                                        <td>
                                            <a-input v-model:value="abilities['scores'][ksid][topic.id].credit" 
                                                @keyup.arrow-keys="onKeypressed" 
                                                @click="onFocusInput($event)"
                                                class="text-center"
                                            />
                                        </td>
                                    </template>
                                <td>
                                    <template v-for="theme in klass.themes">
                                        <span v-if="theme.id==selectedThemeId">
                                            <a :href="route('manage.pre.klassStudent.theme',{klassStudent:ksid,theme:theme.id})" target="_blank">Pdf</a>
                                        </span>
                                    </template>
                                    
                                </td>
                                </tr>
                            </template>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['klass','theme', 'abilities'],
    data() {
        return {
            keypressed:"",
            selectedTermId:1,
            
        }
    },
    created(){
    },
    mounted() {
    },
    methods: {
    }
}
</script>

<style>
#abilityTable, #abilityTable td, #abilityTable th {
  border: 1px solid;
}

#abilityTable {
  width: 100%;
  border-collapse: collapse;
}
</style>