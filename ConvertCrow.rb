require 'json'
class ConvertCrow
  def initialize(fish)
    @crow = Crow.new(fish)
  end

  def encode
    @crow.gen_hclauses
    @crow.gen_sclauses
    @crow.mk_cnffile
  end

  def decode(result)
    JSON.generate(@crow.to_timetable(result))
    #@crow.print_timetable
  end


  class Crow
    def initialize(fish)
      @table = {
        月1: 1,
        月2: 2,
        月3: 3,
        月4: 4,
        月5: 5,
        月6: 6,
        月7: 7,
        月8: 8,
        火1: 9,
        火2: 10,
        火3: 11,
        火4: 12,
        火5: 13,
        火6: 14,
        火7: 15,
        火8: 16,
        水1: 17,
        水2: 18,
        水3: 19,
        水4: 20,
        水5: 21,
        水6: 22,
        水7: 23,
        水8: 24,
        木1: 25,
        木2: 26,
        木3: 27,
        木4: 28,
        木5: 29,
        木6: 30,
        木7: 31,
        木8: 32,
        金1: 33,
        金2: 34,
        金3: 35,
        金4: 36,
        金5: 37,
        金6: 38,
        金7: 39,
        金8: 40
      }
      @fish = fish
      @cnf_list = []
      @cell_list = []
      @clauses = 0
      @hclauses_weight = @fish.size * 4
    end

    def gen_hclauses
      40.times do |i|
        s = ""
        @fish.size.times do |j|
          s += ((i+1)+j*40).to_s + " "
        end
        @cell_list.append(s)
      end
      #１コマに授業はたかだか１つ
      @cell_list.each do |e|
        tmp = e.split
        tmp.combination(2).each do |l|
          @cnf_list.append(@hclauses_weight.to_s + " -" + l[0].to_s + " -" + l[1].to_s + " " + 0.to_s)
          @clauses+=1
        end
      end

      #１つの授業がもつコマはすべて埋まる（すべて埋まらない）
      @fish.each_with_index do |e,i|
        e["date_and_time"].split(",").combination(2).each do |l|
          @cnf_list.append(@hclauses_weight.to_s + " " + (@table[l[0].to_sym]+i*40).to_s + " -" + (@table[l[1].to_sym]+i*40).to_s + " " + 0.to_s)
          @clauses+=1
          @cnf_list.append(@hclauses_weight.to_s + " " + (@table[l[1].to_sym]+i*40).to_s + " -" + (@table[l[0].to_sym]+i*40).to_s + " " + 0.to_s)
          @clauses+=1
        end
      end
    end

    def gen_sclauses
      #受講可能な授業
      @fish.each_with_index do |e,i|
        e["date_and_time"].split(",").each do |l|
          @cnf_list.append(1.to_s + " " + (@table[l.to_sym]+i*40).to_s + " " + 0.to_s)
          @clauses+=1
        end
      end
    end

    def mk_cnffile
      File.open('output.wcnf',mode="w"){|f|
        f.write("p wcnf #{@fish.size*40} #{@clauses} #{@hclauses_weight}\n")
        @cnf_list.each do |e|
          f.write(e + "\n")
        end
      }
    end

    def to_timetable(result)
      @timetable = {}
      result.each_with_index do |e,i|
        if e.to_i > 0
          day = ""
          cls_name = ""
          if e.to_i%40 == 0
            day = @table.key(40).to_s
            cls_name = @fish[(e.to_i)/40-1]["class"]
          else
            day = @table.key(e.to_i%40).to_s
            cls_name = @fish[(e.to_i)/40]["class"]
          end
          @timetable["Lecture#{i}"] = {"name" => cls_name, "period_id" => @table[day.to_sym]-1} 
        end
      end
      @timetable
    end

    #def print_timetable
    #  @timetable.sort_by!{|x| x[2]}
    #  table_counter = 0
    #  40.times do |i|
    #    class_name = ""
    #    #p @timetable
    #    if @timetable[table_counter] != nil && @timetable[table_counter][2] == i+1
    #      class_name = @timetable[table_counter][0]
    #      table_counter+=1
    #    else
    #      class_name = "-"
    #    end
    #    puts "#{@table.key(i+1).to_s} : #{class_name}"
    #  end
    #end
  end
end
