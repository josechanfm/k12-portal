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
        {{base_path().'/storage/'}}fonts/SimHei.ttf<br>
        <div style="font-family: DejaVu Sans, sans-serif;">José</div>
        <p>{{ $klass->tag }}</p>
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
            @foreach($theme->topics as $topic)
                <tr>
                    <td style="font-family: SimHei, sans-serif;" width="120">{{ $topic->section}}</td>
                    <td style="font-family: SimHei, sans-serif;">{{ $topic->abbr}}</td>
                    <td>{{ json_encode($abilities[$theme->id][$topic->id]['credit']) }}</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            @endforeach

        </table>
        <div class="page_break"></div>
        <div>New page</div>

    </body>
</html>

<style>
    .page_break { page-break-before: always; }

</style>


