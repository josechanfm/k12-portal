<template>
    <div>
        <p>{{fields.name_ch}}</p>
        <p>{{fields.name_fn}}</p>
        <p>{{fields.academic_year}}</p>
        <p>{{fields.grade_class}}</p>
        <p>{{fields.student_number}}</p>
        <p>{{fields.id_number}}</p>
        <p>{{fields.issue_date}}</p>
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
                    <tr>
                        <td colspan="2">{{fields.religion}}</td>
                        <td>{{ t1e.religion }}</td>
                        <td>{{ t1p.religion }}</td>
                        <td>{{ t1a.religion }}</td>
                        <td>{{ t2e.religion }}</td>
                        <td>{{ t2p.religion }}</td>
                        <td>{{ t2a.religion }}</td>
                        <td>{{ fin.religion }}</td>
                    </tr>
                    <tr>
                        <td rowspan="4" style="width:30px">中文</td>
                        <td style="width:70px">{{fields.chinese_literature}}</td>
                        <td>{{ t1e.chinese_literature }}</td>
                        <td>{{ t1p.chinese_literature }}</td>
                        <td>{{ t1a.chinese_literature }}</td>
                        <td>{{ t2e.chinese_literature }}</td>
                        <td>{{ t2p.chinese_literature }}</td>
                        <td>{{ t2a.chinese_literature }}</td>
                        <td>{{ fin.chinese_literature }}</td>
                    </tr>
                    <tr>
                        <td>{{fields.common_sense}}</td>
                        <td>{{ t1e.common_sense }}</td>
                        <td>{{ t1p.common_sense }}</td>
                        <td>{{ t1a.common_sense }}</td>
                        <td>{{ t2e.common_sense }}</td>
                        <td>{{ t2p.common_sense }}</td>
                        <td>{{ t2a.common_sense }}</td>
                        <td>{{ fin.common_sense }}</td>
                    </tr>
                    <tr>
                        <td>{{fields.story}}</td>
                        <td>{{ t1e.story }}</td>
                        <td>{{ t1p.story }}</td>
                        <td>{{ t1a.story }}</td>
                        <td>{{ t2e.story }}</td>
                        <td>{{ t2p.story }}</td>
                        <td>{{ t2a.story }}</td>
                        <td>{{ fin.story }}</td>
                    </tr>
                    <tr>
                        <td>{{fields.chinese_writing}}</td>
                        <td>{{ t1e.chinese_writing }}</td>
                        <td>{{ t1p.chinese_writing }}</td>
                        <td>{{ t1a.chinese_writing }}</td>
                        <td>{{ t2e.chinese_writing }}</td>
                        <td>{{ t2p.chinese_writing }}</td>
                        <td>{{ t2a.chinese_writing }}</td>
                        <td>{{ fin.chinese_writing }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{fields.numeracy}}</td>
                        <td>{{ t1e.numeracy }}</td>
                        <td>{{ t1p.numeracy }}</td>
                        <td>{{ t1a.numeracy }}</td>
                        <td>{{ t2e.numeracy }}</td>
                        <td>{{ t2p.numeracy }}</td>
                        <td>{{ t2a.numeracy }}</td>
                        <td>{{ fin.numeracy }}</td>
                    </tr>
                    <tr>
                        <td rowspan="2">英文</td>
                        <td>{{fields.english_reading}}</td>
                        <td>{{ t1e.english_reading }}</td>
                        <td>{{ t1p.english_reading }}</td>
                        <td>{{ t1a.english_reading }}</td>
                        <td>{{ t2e.english_reading }}</td>
                        <td>{{ t2p.english_reading }}</td>
                        <td>{{ t2a.english_reading }}</td>
                        <td>{{ fin.english_reading }}</td>
                    </tr>
                    <tr>
                        <td>{{fields.english_writing}}</td>
                        <td>{{ t1e.english_writing}}</td>
                        <td>{{ t1p.english_writing}}</td>
                        <td>{{ t1a.english_writing}}</td>
                        <td>{{ t2e.english_writing}}</td>
                        <td>{{ t2p.english_writing}}</td>
                        <td>{{ t2a.english_writing}}</td>
                        <td>{{ fin.english_writing}}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{fields.computer}}</td>
                        <td>{{ t1e.computer }}</td>
                        <td>{{ t1p.computer }}</td>
                        <td>{{ t1a.computer }}</td>
                        <td>{{ t2e.computer }}</td>
                        <td>{{ t2p.computer }}</td>
                        <td>{{ t2a.computer }}</td>
                        <td>{{ fin.computer }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{fields.mandarin}}</td>
                        <td>{{ t1e.mandarin }}</td>
                        <td>{{ t1p.mandarin }}</td>
                        <td>{{ t1a.mandarin }}</td>
                        <td>{{ t2e.mandarin }}</td>
                        <td>{{ t2p.mandarin }}</td>
                        <td>{{ t2a.mandarin }}</td>
                        <td>{{ fin.mandarin }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{fields.art_craft}}</td>
                        <td>{{ t1e.art_craft }}</td>
                        <td>{{ t1p.art_craft }}</td>
                        <td>{{ t1a.art_craft }}</td>
                        <td>{{ t2e.art_craft }}</td>
                        <td>{{ t2p.art_craft }}</td>
                        <td>{{ t2a.art_craft }}</td>
                        <td>{{ fin.art_craft }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{fields.playgroup}}</td>
                        <td>{{ t1e.playgroup }}</td>
                        <td>{{ t1p.playgroup }}</td>
                        <td>{{ t1a.playgroup }}</td>
                        <td>{{ t2e.playgroup }}</td>
                        <td>{{ t2p.playgroup }}</td>
                        <td>{{ t2a.playgroup }}</td>
                        <td>{{ fin.playgroup }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{fields.physical_fitness}}</td>
                        <td>{{ t1e.physical_fitness }}</td>
                        <td>{{ t1p.physical_fitness }}</td>
                        <td>{{ t1a.physical_fitness }}</td>
                        <td>{{ t2e.physical_fitness }}</td>
                        <td>{{ t2p.physical_fitness }}</td>
                        <td>{{ t2a.physical_fitness }}</td>
                        <td>{{ fin.physical_fitness }}</td>
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
                        <td colspan="2">{{ fields.total_score }}</td>
                        <td colspan="3">{{ t1.total_score }}</td>
                        <td colspan="3">{{ t2.total_score }}</td>
                        <td>{{ fin.total_score }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{ fields.average_score }}</td>
                        <td colspan="3">{{ t1.average_score }}</td>
                        <td colspan="3">{{ t2.average_score }}</td>
                        <td> {{ fin.average_score }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{ fields.class_size }}</td>
                        <td colspan="3">{{ t1.class_size }}</td>
                        <td colspan="3">{{ t2.class_size }}</td>
                        <td>{{ fin.class_size }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{ fields.ranking }}</td>
                        <td colspan="3">{{ t1.ranking }}</td>
                        <td colspan="3">{{ t2.ranking }}</td>
                        <td>{{ fin.ranking }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{ fields.late }}</td>
                        <td colspan="3">{{ t1.late }}</td>
                        <td colspan="3">{{ t2.late }}</td>
                        <td>{{ fin.late }}</td>
                    </tr>
                    <tr>
                        <td colspan="2">{{ fields.absent }}</td>
                        <td colspan="3">{{ t1.absent }}</td>
                        <td colspan="3">{{ t2.absent }}</td>
                        <td>{{ fin.absent }}</td>
                    </tr>
                </table>
                <table style="height:350px">
                    <tr>
                        <td rowspan="2" style="width:100px">{{ fields.comment }}</td>
                        <td style="width:80px">上學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">{{ t1.comment }}</td>
                    </tr>
                    <tr>
                        <td style="width:80px">下學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">{{ t2.comment }}</td>
                    </tr>
                    <tr>
                        <td rowspan="2" style="width:100px">{{ fields.reward_punishment }}</td>
                        <td style="width:80px">上學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">{{ t1.reward_punishment }}</td>
                    </tr>
                    <tr>
                        <td style="width:80px">下學期</td>
                        <td colspan="2" style="width:270px;text-align: left;">{{ t2.reward_punishment }}</td>
                    </tr>
                    <tr>
                        <td rowspan="4" style="width:100px">{{ fields.leisure }}</td>
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
                        <td rowspan="3" style="width:100px">{{ fields.remark }}</td>
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
                        <td style="width:100px">{{ fields.appraisal }}</td>
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
                        <td style="width:200px">{{ fields.health_1 }}</td>
                        <td>{{ t1.health_1 }}</td>
                        <td>{{ t2.health_1 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.health_2 }}</td>
                        <td>{{ t1.health_2 }}</td>
                        <td>{{ t2.health_2 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.health_3 }}</td>
                        <td>{{ t1.health_3 }}</td>
                        <td>{{ t2.health_3 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.health_4 }}</td>
                        <td>{{ t1.health_4 }}</td>
                        <td>{{ t2.health_4 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.health_5 }}</td>
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
                        <td style="width:200px">{{ fields.behaviour_1 }}</td>
                        <td>{{ t1.behaviour_1 }}</td>
                        <td>{{ t2.behaviour_1 }}</td>
                </tr>
                    <tr>
                        <td style="width:200px">{{ fields.behaviour_2 }}</td>
                        <td>{{ t1.behaviour_2 }}</td>
                        <td>{{ t2.behaviour_2 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.behaviour_3 }}</td>
                        <td>{{ t1.behaviour_3 }}</td>
                        <td>{{ t2.behaviour_3 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.behaviour_4 }}</td>
                        <td>{{ t1.behaviour_4 }}</td>
                        <td>{{ t2.behaviour_4 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.behaviour_5 }}</td>
                        <td>{{ t1.behaviour_5 }}</td>
                        <td>{{ t2.behaviour_5 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.behaviour_6 }}</td>
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
                        <td style="width:200px">{{ fields.social_1 }}</td>
                        <td>{{ t1.social_1 }}</td>
                        <td>{{ t2.social_1 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.social_2 }}</td>
                        <td>{{ t1.social_2 }}</td>
                        <td>{{ t2.social_2 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.social_3 }}</td>
                        <td>{{ t1.social_3 }}</td>
                        <td>{{ t2.social_3 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.social_4 }}</td>
                        <td>{{ t1.social_4 }}</td>
                        <td>{{ t2.social_4 }}</td>
                    </tr>
                    <tr>
                        <td style="width:200px">{{ fields.social_5 }}</td>
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
    props:['transcriptTemplate','transcript'],
    data(){
        return {
            fields:{},
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
        this.transcriptTemplate.forEach((t)=>{
            this.fields[t.field_name]=t.title_zh
        });
        this.transcript.forEach((t)=>{
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

        console.log(this.t1e);

    },
    mounted(){
        // this.fields=this.transcriptTemplate.map((t)=>(
        //     {[t.field_name]:t.title_zh}
        // ));
    }
}
</script>

<style>
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