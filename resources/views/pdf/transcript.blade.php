<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
        <title>App Name </title>
    </head>
    
    <body>
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
                    <span v-if="transcripts[$subject[1]['REGULAR']['id']]" >
                        {{ $transcripts[$subject[1]['REGULAR']['id']]['value'] }}
                    </span>
                </td>
                <td>
                    <span v-if="transcripts[$subject[1]['TERM']['id']]">
                        {{ $subject[1]['TERM']['id'] }}
                        {{ $transcripts[$subject[1]['TERM']['id']]['value'] }}
                    </span>

                </td>
                <td>
                    <span v-if="transcripts[$subject[1]['YEAR']['id']]">
                        {{ $subject[1]['YEAR']['id'] }}
                        {{ $transcripts[$subject[1]['YEAR']['id']]['value'] }}
                    </span>
                </td>
                <td>
                    <span v-if="transcripts[$subject[2]['REGULAR']['id']]">
                        {{ $transcripts[$subject[2]['REGULAR']['id']]['value'] }}
                    </span>
                </td>
                <td>
                    <span v-if="transcripts[$subject[2]['TERM']['id']]">
                        {{ $transcripts[$subject[2]['TERM']['id']]['value'] }}
                    </span>

                </td>
                <td>
                    <span v-if="transcripts[$subject[2]['YEAR']['id']]">
                        {{ $transcripts[$subject[2]['YEAR']['id']]['value'] }}
                    </span>
                </td>
                <td>
                    <span v-if="transcripts[$subject[9]['FINAL']['id']]">
                        {{ $transcripts[$subject[9]['FINAL']['id']]['value'] }}
                    </span>
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


