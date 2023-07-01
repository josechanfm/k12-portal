<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                 {{ course.klass.tag }} {{ course.title_zh }}科 學分管理
                <br/>
                <span v-for="teacher in course.teachers">
                    {{ teacher.name_zh }} 
                    <span v-if="teacher.pivot.is_head">(Head)</span>
                    &nbsp;
                </span>
            </h2>
        </template>
        {{ students_makeups }}
        <div class="py-6">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <a-button type="primary" @click="saveMakups">更新並保存</a-button>
                    <table id="scoreTable" ref="scoreTable">
                        <thead>
                            <tr>
                                <th width="100px">學生姓名</th>
                                <th>Point</th>
                            </tr>
                        </thead>
                        <template v-for="(student,sid) in students_makeups">
                            <tr>
                                <td>{{ student['student_name'] }}</td>
                                <td>{{ student['point'] }}</td>
                            </tr>
                        </template>

                    </table>
                </div>
            </div>
        </div>

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { ContactsOutlined } from '@ant-design/icons-vue';
import { VueDraggableNext } from 'vue-draggable-next'

export default {
    components: {
        AdminLayout,
        draggable: VueDraggableNext,
    },
    props: ['course','students_makeups'],
    data() {
        return {
        }
    },
    created(){
        
    },
    mounted() {
    },
    methods: {
        saveMakups() {
            console.log(this.students_makeups);
        }
    }

}
</script>

<style>
#scoreTable, #scoreTable td, #scoreTable th {
  border: 1px solid;
}

#scoreTable {
  width: 100%;
  border-collapse: collapse;
}
#scoreTable input{
    text-align: center; 
}
        /*定义要拖拽元素的样式*/
        table.itxst {
            color: #333333;
            border: #ddd solid 1px;
            border-collapse: collapse;
        }

            table.itxst th {
                border: #ddd solid 1px;
                padding: 8px;
                background-color: #fafafa;
            }

            table.itxst td {
                border: #ddd solid 1px;
                padding: 8px;
                background-color: #ffffff;
            }

            table.itxst tr {
                cursor: pointer;
            }

            table.itxst td.move:hover {
                cursor: move;
            }
</style>