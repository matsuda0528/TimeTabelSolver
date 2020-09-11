class SolveSwallow
  def initialize
    @swallow = Swallow.new
  end

  def solve
    @swallow.call_maxsat
  end

  def result
    @swallow.parse_output
  end

  class Swallow
    def initialize
    end

    def call_maxsat
      system("maxsat output.wcnf > output.result")
    end

    def parse_output
      result = ""
      File.open("output.result",mode="rt"){|f|
        f.readlines.each do |e|
          if e.start_with?('v')
            result = e
          end
        end
      }
      result.split.drop(1)
    end
  end
end
