<template>
    <div>
        {{klassStudent.student.name_zh}}
        <br>
        {{klassStudent.klass.tag}}

        <ol>
            <li v-for="item in templates['PERSONAL']">
                {{item.title_zh}}

            </li>
        </ol>
        
        <ol>
            <li v-for="subject in templates['SUBJECT'][1]">
                {{subject['REGULAR']['title_zh']}}
            </li>
        </ol>

        <div class="row" style="height:600px">
            <table style="height:600px; width:750px" >
                <tr>
                    <td rowspan="2" colspan="2">科目</td>
                    <td colspan="3">上學期</td>
                    <td colspan="3">下學期</td>
                    <td rowspan="2" style="width:80px">學年成績<br>100%</td>
                </tr>
                <tr>
                    <td style="width:80px">平時<br>27%</td>
                    <td style="width:80px">考試<br>23%</td>
                    <td style="width:80px">平均分<br>50%</td>
                    <td style="width:80px">平時<br>27%</td>
                    <td style="width:80px">考試<br>23%</td>
                    <td style="width:80px">平均分<br>50%</td>
                </tr>
                <tr v-for="subject in templates['SUBJECT']">
                    <td colspan="2">{{ subject[1]['REGULAR'].title_zh }}
                    </td>
                    <td>
                        <span v-if="transcripts[subject[1]['REGULAR'].id]">
                            {{ subject[1]['REGULAR'].value }}
                            {{ transcripts[subject[1]['REGULAR'].id].value }}
                        </span>
                    </td>
                    <td>
                        <span v-if="transcripts[subject[1]['EXAM'].id]">
                            {{ transcripts[subject[1]['EXAM'].id].value }}
                        </span>

                    </td>
                    <td>
                        <span v-if="transcripts[subject[1]['TERM'].id]">
                            {{ transcripts[subject[1]['TERM'].id].value }}
                        </span>
                    </td>
                    <td>
                        <span v-if="transcripts[subject[2]['REGULAR'].id]">
                            {{ transcripts[subject[2]['REGULAR'].id].value }}
                        </span>
                    </td>
                    <td>
                        <span v-if="transcripts[subject[2]['EXAM'].id]">
                            {{ transcripts[subject[2]['EXAM'].id].value }}
                        </span>

                    </td>
                    <td>
                        <span v-if="transcripts[subject[2]['TERM'].id]">
                            {{ transcripts[subject[2]['TERM'].id].value }}
                        </span>
                    </td>
                    <td>
                        <span v-if="transcripts[subject[9]['FINAL'].id]">
                            {{ transcripts[subject[9]['FINAL'].id].value }}
                        </span>
                    </td>
                </tr>
            </table>
        </div>


        <div class="row" sytle="height:350">
            <div class="column_left">
                <table style="height:350px">
                    <tr>
                        <td rowspan="2" style="width:100px">
                            {{templates['GENERAL'][1]['comment'].title_zh}}
                        </td>
                        <td style="width:80px">上學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{templates['GENERAL'][1]['comment'].value}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px">下學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{templates['GENERAL'][2]['comment'].value}}
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="2" style="width:100px">
                            {{templates['GENERAL'][1]['reward_punishment'].title_zh}}
                        </td>
                        <td style="width:80px">上學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{templates['GENERAL'][1]['reward_punishment'].value}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px">下學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{templates['GENERAL'][2]['reward_punishment'].value}}
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="4" style="width:100px">
                            {{templates['GENERAL'][1]['leisure_name'].title_zh}}
                        </td>
                        <td rowspan="2" style="width:80px">上學期</td>
                        <td style="width:70px">活動名稱</td>
                        <td style="width:200px;text-align: left;">
                            {{templates['GENERAL'][1]['leisure_name'].value}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:70px">活動表現</td>
                        <td style="width:200px;text-align: left;">
                            {{templates['GENERAL'][1]['leisure_performance'].value}}
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="2" style="width:80px">下學期</td>
                        <td style="width:70px">活動名稱</td>
                        <td style="width:200px;text-align: left;">
                            {{templates['GENERAL'][2]['leisure_name'].value}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:70px">活動表現</td>
                        <td style="width:200px;text-align: left;">
                            {{templates['GENERAL'][2]['leisure_performance'].value}}
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="3" style="width:100px">
                            {{templates['GENERAL'][1]['remark'].title_zh}}
                        </td>
                        <td style="width:80px">上學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{templates['GENERAL'][1]['remark'].value}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px">下學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{templates['GENERAL'][2]['remark'].value}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px">全學年</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{templates['GENERAL'][2]['remark'].value}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:100px">
                            {{templates['APPRAISAL']['appraisal'].title_zh}}
                        </td>
                        <td colspan="3" style="width:270px;text-align: left;">
                            {{templates['APPRAISAL']['appraisal'].value}}
                        &nbsp;<br>&nbsp;<br></td>
                    </tr>
                </table>
            </div>
            <div class="column_right">
                <table style="width:300px;height:350px">
                    <tr style="height:10px">
                        <td>校長</td>
                        <td>副校長</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr style="height:10px">
                        <td>班主任</td>
                        <td>家長</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </div>
        </div>

<!--

        <div class="row" sytle="height:350">
            <div class="column_left">
                <table style="height:350px">
                    <tr>
                        <td rowspan="2" style="width:100px">
                            {{templates['GENERAL']['comment'].title_zh}}
                        </td>
                        <td style="width:80px">上學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{fields['GENERAL'][1]['comment']}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px">下學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{fields['GENERAL'][2]['comment']}}
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="2" style="width:100px">
                            {{templates['GENERAL']['reward_punishment'].title_zh}}
                        </td>
                        <td style="width:80px">上學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{fields['GENERAL'][1]['reward_punishment']}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px">下學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{fields['GENERAL'][2]['reward_punishment']}}
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="4" style="width:100px">
                            {{templates['GENERAL']['leisure_name'].title_zh}}
                        </td>
                        <td rowspan="2" style="width:80px">上學期</td>
                        <td style="width:70px">活動名稱</td>
                        <td style="width:200px;text-align: left;">
                            {{fields['GENERAL'][1]['leisure_name']}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:70px">活動表現</td>
                        <td style="width:200px;text-align: left;">
                            {{fields['GENERAL'][1]['leisure_performance']}}
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="2" style="width:80px">下學期</td>
                        <td style="width:70px">活動名稱</td>
                        <td style="width:200px;text-align: left;">
                            {{fields['GENERAL'][2]['leisure_name']}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:70px">活動表現</td>
                        <td style="width:200px;text-align: left;">
                            {{fields['GENERAL'][2]['leisure_performance']}}
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="3" style="width:100px">
                            {{templates['GENERAL']['remark'].title_zh}}
                        </td>
                        <td style="width:80px">上學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{fields['GENERAL'][1]['remark']}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px">下學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{fields['GENERAL'][2]['remark']}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:80px">全學年</td>
                        <td colspan="2" style="width:270px;text-align: left;">
                            {{fields['GENERAL'][2]['remark']}}
                        </td>
                    </tr>
                    <tr>
                        <td style="width:100px">
                            {{templates['GENERAL']['appraisal'].title_zh}}
                        </td>
                        <td colspan="3" style="width:270px;text-align: left;">
                            {{fields['GENERAL'][9]['appraisal']}}
                        &nbsp;<br>&nbsp;<br></td>
                    </tr>
                </table>
            </div>
            <div class="column_right">
                <table style="width:300px;height:350px">
                    <tr style="height:10px">
                        <td>校長</td>
                        <td>副校長</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr style="height:10px">
                        <td>班主任</td>
                        <td>家長</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </div>
        </div>


    -->
    </div>
</template>

<script>

export default {
    props:['klassStudent','templates','fields','transcripts'],
    data(){
        return {
            t1:{},
            t2:{},
            t1e:{},
            t1p:{},
            t1a:{},
            t2e:{},
            t2p:{},
            t2a:{},
            fin:{}
        }
    },
    created(){

    },
    mounted(){
        // this.fields=this.transcriptTemplate.map((t)=>(
        //     {[t.field_name]:t.title_zh}
        // ));
    }
}
</script>

<style scoped>
table, td, th {
  border: 1px solid;
  text-align: center;
}

table {
  border-collapse: collapse;
}
.column_left {
  float: left;
  width: 460px;
  padding: 5px;
  height: 300px; /* Should be removed. Only for demonstration */
}
.column_right {
  float: left;
  width: 300px;
  padding-top: 5px;
  height: 300px; /* Should be removed. Only for demonstration */
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}
</style>