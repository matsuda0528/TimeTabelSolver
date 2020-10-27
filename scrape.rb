require './ScrapePenguin'
#require './ConvertCrow'
#require './SolveSwallow'
#scraping
driver = ScrapePenguin.new('工学部','情報系学科','第１学期')
driver.search
driver.parse
File.open(ARGV[0],"w") do |f|
  driver.class_list.each do |e|
    f.write(e.to_json)
    f.write("\n")
  end
end
#p driver.class_list
#p driver.class_list.class
#p driver.class_list[0].class
##encode
#converter = ConvertCrow.new(driver.class_list)
#converter.encode
##maxsat
#solver = SolveSwallow.new
#solver.solve
##decode
#json = converter.decode(solver.result)
#File.open("output.json","w") do |f|
#  f.write(json)
#end
