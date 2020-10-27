require './ScrapePenguin'
require './ConvertCrow'
require './SolveSwallow'
require 'json'
#scraping
class_list = []
File.open(ARGV[0],"r") do |f|
  f.each_line{|line|
    class_list.append JSON.parse(line)
  }
end
#encode
converter = ConvertCrow.new(class_list)
converter.encode
#maxsat
solver = SolveSwallow.new
solver.solve
#decode
json = converter.decode(solver.result)
File.open("output.json","w") do |f|
  f.write(json)
end
