require './MaxSat'
require './ScrapePenguin'
require './ConvertCrow'
require './SolveSwallow'
#scraping
driver = ScrapePenguin.new('理学部','数学科','第１学期')
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
converter.decode(solver.result)
