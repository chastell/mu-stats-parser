module MUStatsParser class Executable
  def initialize args = ARGV
    @from, @to = *args
  end

  def run
    Parser.new(@from).marshal_into @to
  end
end end
