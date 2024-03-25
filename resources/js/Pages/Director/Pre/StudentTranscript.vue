<template>
    <div>
        <!-- <p>{{fields.name_ch}}</p>
        <p>{{fields.name_fn}}</p>
        <p>{{fields.academic_year}}</p>
        <p>{{fields.grade_class}}</p>
        <p>{{fields.student_number}}</p>
        <p>{{fields.id_number}}</p>
        <p>{{fields.issue_date}}</p> -->
        <div class="row">
            <div class="column_left">
                <table style="height:600px">
                    <tr>
                        <td rowspan="2" colspan="2">科目</td>
                        <td colspan="3">上學期</td>
                        <td colspan="3">下學期</td>
                        <td rowspan="2" style="width:50px">學年成績<br>100%</td>
                    </tr>
                    <tr>
                        <td style="width:50px">平時<br>27%</td>
                        <td style="width:50px">考試<br>23%</td>
                        <td style="width:50px">平均分<br>50%</td>
                        <td style="width:50px">平時<br>27%</td>
                        <td style="width:50px">考試<br>23%</td>
                        <td style="width:50px">平均分<br>50%</td>
                    </tr>
                    <tr v-for="subject in fields['SUBJECT']">
                        <td colspan="2">{{subject.title_zh}}</td>
                        <template v-for="term in yearTerms">
                            <td>
                                <span v-if="values[term.value]['SUBJECT'][subject.reference_code]">
                                    {{values[term.value]['SUBJECT'][subject.reference_code]['REGULAR']?values[term.value]['SUBJECT'][subject.reference_code]['REGULAR'].value:'-'}}
                                </span>
                            </td>
                            <td>
                                <span v-if="values[term.value]['SUBJECT'][subject.reference_code]">
                                    {{values[term.value]['SUBJECT'][subject.reference_code]['EXAM']?values[term.value]['SUBJECT'][subject.reference_code]['EXAM'].value:'-'}}
                                </span>
                            </td>
                            <td>
                                <span v-if="values[term.value]['SUBJECT'][subject.reference_code]">
                                    {{values[term.value]['SUBJECT'][subject.reference_code]['FINAL']?values[term.value]['SUBJECT'][subject.reference_code]['FINAL'].value:'-'}}
                                </span>
                            </td>

                        </template>
                        <td>
                            <span v-if="values[9]['SUBJECT']">
                                <span v-if="values[9]['SUBJECT'][subject.reference_code]">
                                    {{values[9]['SUBJECT'][subject.reference_code]['FINAL'].value}}
                                </span >
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"></td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                    </tr>
                    <tr>
                        <td colspan="2"></td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                        <td>--</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            {{fields['SUMMARY']['total_score'].title_zh}}</td>
                        <td colspan="3">{{ t1.total_score }}</td>
                        <td colspan="3">{{ t2.total_score }}</td>
                        <td>{{ fin.total_score }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{fields['SUMMARY']['average_score'].title_zh}}</td>
                        <td colspan="3">{{ t1.average_score }}</td>
                        <td colspan="3">{{ t2.average_score }}</td>
                        <td> {{ fin.average_score }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{fields['SUMMARY']['class_size'].title_zh}}</td>
                        <td colspan="3">{{ t1.class_size }}</td>
                        <td colspan="3">{{ t2.class_size }}</td>
                        <td>{{ fin.class_size }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{fields['SUMMARY']['ranking'].title_zh}}</td>
                        <td colspan="3">{{ t1.ranking }}</td>
                        <td colspan="3">{{ t2.ranking }}</td>
                        <td>{{ fin.ranking }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{fields['SUMMARY']['late'].title_zh}}</td>
                        <td colspan="3">{{ t1.late }}</td>
                        <td colspan="3">{{ t2.late }}</td>
                        <td>{{ fin.late }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{fields['SUMMARY']['absent'].title_zh}}</td>
                        <td colspan="3">{{ t1.absent }}</td>
                        <td colspan="3">{{ t2.absent }}</td>
                        <td>{{ fin.absent }}</td>
                    </tr>
                </table>
                <table style="height:350px">
                    <tr>
                        <td rowspan="2" style="width:100px">{{fields['GENERAL']['comment'].title_zh}}</td>
                        <td style="width:80px">上學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">{{ t1.comment }}</td>
                    </tr>
                    <tr>
                        <td style="width:80px">下學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">{{ t2.comment }}</td>
                    </tr>
                    <tr>
                        <td rowspan="2" style="width:100px">{{fields['GENERAL']['reward_punishment'].title_zh}}</td>
                        <td style="width:80px">上學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">{{ t1.reward_punishment }}</td>
                    </tr>
                    <tr>
                        <td style="width:80px">下學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">{{ t2.reward_punishment }}</td>
                    </tr>
                    <tr>
                        <td rowspan="4" style="width:100px">{{fields['GENERAL']['leisure_name'].title_zh}}</td>
                        <td rowspan="2" style="width:80px">上學期</td>
                        <td style="width:70px">活動名稱</td>
                        <td style="width:200px;text-align: left;">{{ t1.leisure_name }}</td>
                    </tr>
                    <tr>
                        <td style="width:70px">活動表現</td>
                        <td style="width:200px;text-align: left;">{{ t1.leisure_performance }}</td>
                    </tr>
                    <tr>
                        <td rowspan="2" style="width:80px">下學期</td>
                        <td style="width:70px">活動名稱</td>
                        <td style="width:200px;text-align: left;">{{ t2.leisure_name }}</td>
                    </tr>
                    <tr>
                        <td style="width:70px">活動表現</td>
                        <td style="width:200px;text-align: left;">{{ t2.leisure_performance }}</td>
                    </tr>
                    <tr>
                        <td rowspan="3" style="width:100px">{{fields['GENERAL']['remark'].title_zh}}</td>
                        <td style="width:80px">上學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">{{ t1.remark }}</td>
                    </tr>
                    <tr>
                        <td style="width:80px">下學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">{{ t2.remark }}</td>
                    </tr>
                    <tr>
                        <td style="width:80px">全學年</td>
                        <td colspan="2" style="width:270px;text-align: left;">{{ fin.remark }}</td>
                    </tr>
                    <tr>
                        <td style="width:100px">{{fields['GENERAL']['appraisal'].title_zh}}</td>
                        <td colspan="3" style="width:270px;text-align: left;">{{ fin.appraisal }}&nbsp;<br>&nbsp;<br></td>
                    </tr>
                </table>
            </div>
            <div class="column_right">
                <table style="height:600px">
                    <tr>
                        <td colspan="2">生活習慣和態度</td>
                        <td style="width:40px">上學期</td>
                        <td style="width:40px">下學期</td>
                    </tr>
                    <tr>
                        <td rowspan="6" style="width:30px">個人衛生</td>
                        <td style="width:200px">{{fields['ATTITUDE']['health_1'].title_zh}}</td>
                        <td>
                            <span v-if="values[1]['ATTITUDE']['health_1']['FINAL']">
                                {{values[1]['ATTITUDE']['health_1']['FINAL'].value}}
                            </span>
                        </td>
                        <td>
                            <span v-if="values[2]['ATTITUDE']['health_1']['FINAL']">
                                {{values[2]['ATTITUDE']['health_1']['FINAL'].value}}
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['health_2'].title_zh}}</td>
                        <td>{{ t1.health_2 }}</td>
                        <td>{{ t2.health_2 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['health_3'].title_zh}}</td>
                        <td>{{ t1.health_3 }}</td>
                        <td>{{ t2.health_3 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['health_4'].title_zh}}</td>
                        <td>{{ t1.health_4 }}</td>
                        <td>{{ t2.health_4 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['health_5'].title_zh}}</td>
                        <td>{{ t1.health_5 }}</td>
                        <td>{{ t2.health_5 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">&nbsp;</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td rowspan="7" style="width:30px">行為習慣</td>
                        <td style="width:200px">{{fields['ATTITUDE']['behaviour_1'].title_zh}}</td>
                        <td>{{ t1.behaviour_1 }}</td>
                        <td>{{ t2.behaviour_1 }}</td>
                </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['behaviour_2'].title_zh}}</td>
                        <td>{{ t1.behaviour_2 }}</td>
                        <td>{{ t2.behaviour_2 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['behaviour_3'].title_zh}}</td>
                        <td>{{ t1.behaviour_3 }}</td>
                        <td>{{ t2.behaviour_3 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['behaviour_4'].title_zh}}</td>
                        <td>{{ t1.behaviour_4 }}</td>
                        <td>{{ t2.behaviour_4 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['behaviour_5'].title_zh}}</td>
                        <td>{{ t1.behaviour_5 }}</td>
                        <td>{{ t2.behaviour_5 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['behaviour_6'].title_zh}}</td>
                        <td>{{ t1.behaviour_6 }}</td>
                        <td>{{ t2.behaviour_6 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">&nbsp;</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td rowspan="6" style="width:30px">社交態度</td>
                        <td style="width:200px">{{fields['ATTITUDE']['social_1'].title_zh}}</td>
                        <td>{{ t1.social_1 }}</td>
                        <td>{{ t2.social_1 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['social_2'].title_zh}}</td>
                        <td>{{ t1.social_2 }}</td>
                        <td>{{ t2.social_2 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['social_3'].title_zh}}</td>
                        <td>{{ t1.social_3 }}</td>
                        <td>{{ t2.social_3 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['social_4'].title_zh}}</td>
                        <td>{{ t1.social_4 }}</td>
                        <td>{{ t2.social_4 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{fields['ATTITUDE']['social_5'].title_zh}}</td>
                        <td>{{ t1.social_5 }}</td>
                        <td>{{ t2.social_5 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">&nbsp;</td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
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
    </div>
    <!-- <p>{{fields.religion}}</p>
    <p>{{fields.chinese_literature}}</p>
    <p>{{fields.conmon_sense}}</p>
    <p>{{fields.story}}</p>
    <p>{{fields.chinese_writing}}</p>
    <p>{{fields.numeracy}}</p>
    <p>{{fields.english_reading}}</p>
    <p>{{fields.english_writing}}</p>
    <p>{{fields.computer}}</p>
    <p>{{fields.mandarin}}</p>
    <p>{{fields.art_craft}}</p>
    <p>{{fields.playgroup}}</p>
    <p>{{fields.physical_fitness}}</p>
    <p>{{fields.health_1}}</p>
    <p>{{fields.health_2}}</p>
    <p>{{fields.health_3}}</p>
    <p>{{fields.health_4}}</p>
    <p>{{fields.health_5}}</p>
    <p>{{fields.behaviour_1}}</p>
    <p>{{fields.behaviour_2}}</p>
    <p>{{fields.behaviour_3}}</p>
    <p>{{fields.behaviour_4}}</p>
    <p>{{fields.behaviour_5}}</p>
    <p>{{fields.behaviour_}}</p>
    <p>{{fields.social_1}}</p>
    <p>{{fields.social_2}}</p>
    <p>{{fields.social_3}}</p>
    <p>{{fields.social_4}}</p>
    <p>{{fields.social_5}}</p>
    <p>{{fields.total_score}}</p>
    <p>{{fields.average_score}}</p>
    <p>{{fields.class_size}}</p>
    <p>{{fields.ranking}}</p>
    <p>{{fields.late}}</p>
    <p>{{fields.absent}}</p>
    <p>{{fields.comment}}</p>
    <p>{{fields.reward_pusishment}}</p>
    <p>{{fields.leisure}}</p>
    <p>{{fields.remark}}</p>
    <p>{{fields.appraisal}}</p> -->
</template>

<script>

export default {
    props:['yearTerms','transcriptTemplates','transcripts'],
    data(){
        return {
            subjects:{},
            fields:{},
            values:{},
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
        //for template columns
        Object.values(this.transcriptTemplates).forEach((t)=>{
            if(!this.fields[t.category]){
                this.fields[t.category]={}
            }
            this.fields[t.category][t.reference_code]=t;
        });
        //for transcript values, by terms
        this.yearTerms.forEach((term)=>{
            this.values[term.value]={}
        });
        this.values[9]={}
        this.yearTerms.forEach((term)=>{
            Object.values(this.transcriptTemplates).forEach((t)=>{
                if(!this.values[term.value][t.category]){
                    this.values[term.value][t.category]={}
                }
                this.values[term.value][t.category][t.reference_code]={};
            });
        });

        console.log(this.values);
        Object.values(this.transcripts).forEach((t)=>{
            this.values[t.term_id][t.category][t.reference_code][t.field_name]=t
            switch(t.column){
                case 'T1':
                    this.t1[t.field_name]=t.field_value;
                    break;
                case 'T2':
                    this.t2[t.field_name]=t.field_value;
                    break;
                case 'T1E':
                    this.t1e[t.field_name]=t.field_value;
                    break;
                case 'T1P':
                    this.t1p[t.field_name]=t.field_value;   
                    break;
                case 'T1A':
                    this.t1a[t.field_name]=t.field_value;
                    break;
                case 'T2E':
                    this.t2e[t.field_name]=t.field_value;
                    break;
                case 'T2P':
                    this.t2p[t.field_name]=t.field_value;   
                    break;
                case 'T2A':
                    this.t2a[t.field_name]=t.field_value;
                    break;
                case 'FIN':
                    this.fin[t.field_name]=t.field_value;
                    break;
            }
        });

        

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