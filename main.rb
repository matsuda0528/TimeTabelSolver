require './ScrapePenguin'
require './ConvertCrow'
require './SolveSwallow'
#scraping
driver = ScrapePenguin.new('工学部','機械システム系学科','第１学期')
driver.search
driver.parse
driver.class_list
#encode
converter = ConvertCrow.new(driver.class_list)
converter.encode
#maxsat
solver = SolveSwallow.new
solver.solve
#decode
json = converter.decode(solver.result)
File.open("output.json","w") do |f|
  f.write(json)
end
system("ruby timetable.rb")
