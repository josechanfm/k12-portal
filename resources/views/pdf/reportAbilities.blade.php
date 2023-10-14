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
        新疆是中国陆地面积最大的省份
        {{ $klass.tag }}
        <div style="font-family: DejaVu Sans, sans-serif;">✔</div>
        <div style="font-family: DejaVu Sans, sans-serif;">✗</div>
        <div style="font-family: SimHei, sans-serif;">新疆是中国陆地面积最大的省份</div>


        <table width="100%" border="1">
            <tr style="background-color: lightgray">
                <th>a</th>
                <th>b</th>
                <th>c</th>
            </th>
        </table>
    </body>
</html>

