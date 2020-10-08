require 'json'

json = ""
tt = []
unit = 0
File.open("output.json","r") do |f|
  json = f.readlines
end
result = JSON.parse(json.first)

result.each do |e|
  tt[e[1]["period_id"].to_i] = e[1]["name"]
  unit += 0.5
end


str = <<-EOS
<!DOCTYPE html>
<html lang="ja">
  <head>
    <title>時間割</title>
    <meta charset="utf-8">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>

    <style>

    th{
      background: #eee;
    }
   th,td {
      border: solid 1px;
      width:auto;
      padding:20px 40px;
   }


   table{
      border: solid 1px;
      border-collapse:  collapse;
      /*white-space: nowrap;
    }

    </style>

  </head>

  <body>
  <table>
  <tr>
  <th>Mon</th>
  <th>Tue</th>
  <th>Wed</th>
  <th>Thu</th>
  <th>Fri</th>
  </tr>
  <tr>
  <td>#{tt[0]}</td>
  <td>#{tt[8]}</td>
  <td>#{tt[16]}</td>
  <td>#{tt[24]}</td>
  <td>#{tt[32]}</td>
  </tr>
  <tr>
  <td>#{tt[1]}</td>
  <td>#{tt[9]}</td>
  <td>#{tt[17]}</td>
  <td>#{tt[25]}</td>
  <td>#{tt[33]}</td>
  </tr>
  <tr>
  <td>#{tt[2]}</td>
  <td>#{tt[10]}</td>
  <td>#{tt[18]}</td>
  <td>#{tt[26]}</td>
  <td>#{tt[34]}</td>
  </tr>
  <tr>
  <td>#{tt[3]}</td>
  <td>#{tt[11]}</td>
  <td>#{tt[19]}</td>
  <td>#{tt[27]}</td>
  <td>#{tt[35]}</td>
  </tr>
  <tr>
  <td>#{tt[4]}</td>
  <td>#{tt[12]}</td>
  <td>#{tt[20]}</td>
  <td>#{tt[28]}</td>
  <td>#{tt[36]}</td>
  </tr>
  <tr>
  <td>#{tt[5]}</td>
  <td>#{tt[13]}</td>
  <td>#{tt[21]}</td>
  <td>#{tt[29]}</td>
  <td>#{tt[37]}</td>
  </tr>
  <tr>
  <td>#{tt[6]}</td>
  <td>#{tt[14]}</td>
  <td>#{tt[22]}</td>
  <td>#{tt[30]}</td>
  <td>#{tt[38]}</td>
  </tr>
  <tr>
  <td>#{tt[7]}</td>
  <td>#{tt[15]}</td>
  <td>#{tt[23]}</td>
  <td>#{tt[31]}</td>
  <td>#{tt[39]}</td>
  </tr>
  </table>
  <h3>単位数：#{unit.ceil}</h3>
  </body>
</html>
EOS
File.open("index.html","w") do |f|
  f.write(str)
end

system("firefox index.html &")
