<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
        <title>App Name </title>
    </head>
    <body>
        @php
        /* 把成積表分數轉成Array方便提取 */
        $data=[];
        foreach($transcripts as $transcript){
            if($transcript['field_name']!=null){
                $data[
                        $transcript['term_id']
                    ][
                        $transcript['category']
                    ][
                        $transcript['reference_code']
                    ][
                        $transcript['field_name']
                    ]=$transcript;
            }else{
                $data[
                        $transcript['term_id']
                    ][
                        $transcript['category']
                    ][
                        $transcript['reference_code']
                    ]=$transcript;
            }
        };
        @endphp
        <p>Appraisal</p>
        <!-- 注意:分數轉換中暫時只是hardcode, 轉入介面也還沒有 -->
        @isset($data[9]['APPRAISAL'])
            <p>Appraisal :{{ $data[9]['APPRAISAL']['appraisal']['value'] }}</p>
        @endisset
        <!-- 合格分數由transcript template 中提取 -->
        <p>Passing</p>
        @isset($templates['PASSING'])
            <p>Passing :{{ $templates['PASSING']['passing']['value'] }}</p>
        @endisset
        <hr>
        <p>Personal</p>
        @isset($data[9]['PERSONAL'])
            <p>Name (fn) :{{ $data[9]['PERSONAL']['name_fn']['value'] }}</p>
            <p>Academic Year :{{ $data[9]['PERSONAL']['academic_year']['value'] }}</p>
            <p>Grade Class :{{ $data[9]['PERSONAL']['grade_class']['value'] }}</p>
            <p>Student Number :{{ $data[9]['PERSONAL']['student_number']['value'] }}</p>
            <p>ID Number :{{ $data[9]['PERSONAL']['id_number']['value'] }}</p>
            <p>Issue Date :{{ $data[9]['PERSONAL']['issue_date']['value'] }}</p>
        @endisset
        
        <p>GENERAL (term 9)</p>
        @isset($data['9']['GENERAL'])
            <p>Comment :{{ $data['9']['GENERAL']['comment']['value'] }}</p>
            <p>Leisure Name :{{ $data['9']['GENERAL']['leisure_name']['value'] }}</p>
            <p>Leisure Performance :{{ $data['9']['GENERAL']['leisure_performance']['value'] }}</p>
            <p>Remark :{{ $data['9']['GENERAL']['remark']['value'] }}</p>
            <p>Reward Punishment :{{ $data['9']['GENERAL']['reward_punishment']['value'] }}</p>
        @endisset
        <p>GENERAL (term 1)</p>
        @isset($data['1']['GENERAL'])
            <p>Comment :{{ $data['1']['GENERAL']['comment']['value'] }}</p>
            <p>Leisure Name :{{ $data['1']['GENERAL']['leisure_name']['value'] }}</p>
            <p>Leisure Performance :{{ $data['1']['GENERAL']['leisure_performance']['value'] }}</p>
            <p>Remark :{{ $data['1']['GENERAL']['remark']['value'] }}</p>
            <p>Reward Punishment :{{ $data['1']['GENERAL']['reward_punishment']['value'] }}</p>
        @endisset
        <p>GENERAL (term 2)</p>
        @isset($data['2']['GENERAL'])
        <p>Comment :{{ $data['2']['GENERAL']['comment']['value'] }}</p>
            <p>Leisure Name :{{ $data['2']['GENERAL']['leisure_name']['value'] }}</p>
            <p>Leisure Performance :{{ $data['2']['GENERAL']['leisure_performance']['value'] }}</p>
            <p>Remark :{{ $data['2']['GENERAL']['remark']['value'] }}</p>
            <p>Reward Punishment :{{ $data['2']['GENERAL']['reward_punishment']['value'] }}</p>
        @endisset


        <table style="height:600px; width:750px" >
            <thead>
                <tr class="chinese">
                    <td rowspan="2" colspan="2">科目</td>
                    <td colspan="3">上學期</td>
                    <td colspan="3">下學期</td>
                    <td rowspan="2" style="width:80px">學年成績<br>100%</td>
                </tr>
                <tr class="chinese">
                    <td style="width:80px">平時<br>27%</td>
                    <td style="width:80px">考試<br>23%</td>
                    <td style="width:80px">平均分<br>50%</td>
                    <td style="width:80px">平時<br>27%</td>
                    <td style="width:80px">考試<br>23%</td>
                    <td style="width:80px">平均分<br>50%</td>
                </tr>
            </thead>
            <tbody>
            @foreach($templates['SUBJECT'] as $subject)
            <tr>
                <td colspan="2" class="chinese">{{ $subject[1]['REGULAR']['title_zh'] }}</td>
                <td>
                    @isset($transcripts[$subject[1]['REGULAR']['id']])
                        {{ $transcripts[$subject[1]['REGULAR']['id']]['value']}}
                    @endisset
                </td>
                <td>
                    @isset($transcripts[$subject[1]['TERM']['id']])
                        {{ $transcripts[$subject[1]['TERM']['id']]['value']}}
                    @endisset
                </td>
                <td>
                    @isset($transcripts[$subject[1]['YEAR']['id']])
                        {{ $transcripts[$subject[1]['YEAR']['id']]['value']}}
                    @endisset
                </td>
                <td>
                    @isset($transcripts[$subject[2]['REGULAR']['id']])
                        {{ $transcripts[$subject[2]['YEAR']['id']]['value'] }}
                    @endisset
                </td>
                <td>
                    @isset($transcripts[$subject[2]['TERM']['id']])
                        {{ $transcripts[$subject[2]['TERM']['id']]['value']}}
                    @endisset
                </td>
                <td>
                    @isset($transcripts[$subject[2]['YEAR']['id']])
                        {{ $transcripts[$subject[2]['YEAR']['id']]['value']}}
                    @endisset
                </td>
                <td>
                    @isset($transcripts[$subject[9]['FINAL']['id']])
                        {{ $transcripts[$subject[9]['FINAL']['id']]['value']}}
                    @endisset
                </td>
            </tr>
            @endforeach
            </tbody>
        </table>

    </body>
</html>

<style>
    .page_break { page-break-before: always; }
    .chinese { font-family: SimHei, sans-serif; }
</style>


