require_relative 'spec_helper'

describe MUStatsParser do
  describe '#stats' do
    it 'yeilds subsequent stats' do
      MUStatsParser.new('spec/fixtures/log').stats.first.must_equal({
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
end
