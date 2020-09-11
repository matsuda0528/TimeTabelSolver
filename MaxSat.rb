require "stringio"

class MaxSat
  def initialize
  end

  def solve(wcnf_file)
    $stdout = StringIO.new
    system("maxsat #{wcnf_file} > output")
  end
end

