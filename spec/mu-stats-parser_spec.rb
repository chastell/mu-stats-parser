require_relative 'spec_helper'

describe MUStatsParser do
  let(:musp) { MUStatsParser.new 'spec/fixtures/log' }

  describe '#stats' do
    it 'yeilds subsequent stats' do
      musp.stats.first.must_equal({
        geoip: {
          city:      'Warsaw',
          continent: 'EU',
          country:   'Poland',
          latitude:  52.25,
          longitude: 21.0,
          timezone:  'Europe/Warsaw',
        },
        ip:       'bc785ac340dc4855b72220038eea4baefbc982b2',
        method:   :get,
        referrer: 'http://university.rubymendicant.com/',
        request:  '/dashboard',
        status:   200,
        time:     Time.parse('2011-11-14 17:19:34 +0100'),
      })
    end
  end

  describe '#yaml_into' do
    it 'parses the log and saves it in the given YAML::Store' do
      file = Tempfile.new ''
      musp.yaml_into file.path
      File.read(file.path).must_equal File.read 'spec/fixtures/log.yml'
    end
  end
end
