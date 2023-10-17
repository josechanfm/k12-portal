<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
        <title>App Name </title>
    </head>
    <style type="text/css">
        @font-face {
           font-family: SimHei;
           src: url('{{base_path().'/storage/'}}fonts/simhei.ttf') format('truetype');
        }
        /*         
        * {
          font-family: SimHei;
        }
        */
    </style>
    
    <body>
        @php $cnt=0 @endphp
        @foreach($abilities['students'] as $ksid=>$student)
            <p>Class: {{ $klass->tag}}</p>
            <p style="font-family: SimHei, sans-serif;">Theme: {{ $theme->title }}</p>
            <p style="font-family: SimHei, sans-serif;">{{ $student->name_zh }}</p>
            <table width="100%" border="1">
                <tr>
                    <th colspan="2">Student</th>
                    <th width="30px">1</th>
                    <th width="30px">2</th>
                    <th width="30px">3</th>
                    <th width="30px">4</th>
                    <th width="30px">5</th>
                </tr>
                @foreach($abilities['theme']->topics as $topic)
                    @php $score=$abilities['scores'][$ksid][$topic->id]['credit']; @endphp
                    @endphp
                    <tr>
                        <td style="font-family: SimHei, sans-serif;" width="120">{{ $topic->section}}</td>
                        <td style="font-family: SimHei, sans-serif;">{{$topic->title}}</td>
                        <td>{{ $score=='1'?'X':'' }}</td>
                        <td>{{ $score=='2'?'X':'' }}</td>
                        <td>{{ $score=='3'?'X':'' }}</td>
                        <td>{{ $score=='4'?'X':'' }}</td>
                        <td>{{ $score=='5'?'X':'' }}</td>
                    </tr>
                @endforeach
            </table>
            @if (count($abilities['students']) > ++$cnt)
                <div class="page_break"></div>    
            @endif
            
        @endforeach
    </body>
</html>

<style>
    .page_break { page-break-before: always; }

</style>


