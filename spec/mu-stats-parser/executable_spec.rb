require_relative '../spec_helper'

module MUStatsParser class Executable
  describe '#run' do
    it 'processes the given log and marshals it to the given file' do
      file = Tempfile.new ''
      Executable.new(['spec/fixtures/log', file.path]).run
      File.read(file.path).must_equal File.read 'spec/fixtures/log.pstore'
    end
  end
end end
