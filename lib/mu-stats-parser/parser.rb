module MUStatsParser class Parser
  def initialize path
    @geoip  = GeoIP.new 'data/GeoLiteCity.dat'
    @path   = path
    @parser = ApacheLogRegex.new '%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\"'
  end

  def stats
    Enumerator.new do |yielder|
      File.open(@path).lines do |line|
        parsed = @parser.parse line
        geoip  = @geoip.country parsed['%h']
        method, request, _ = parsed['%r'].split

        yielder.yield({
          geoip: {
            city:      geoip.city_name,
            continent: geoip.continent_code,
            country:   geoip.country_name,
            latitude:  geoip.latitude,
            longitude: geoip.longitude,
            timezone:  geoip.timezone,
          },
          ip:       Digest::SHA1.hexdigest(parsed['%h']),
          method:   method.downcase.to_sym,
          referrer: parsed['%{Referer}i'],
          request:  request,
          status:   parsed['%>s'].to_i,
          time:     Time.strptime(parsed['%t'], '[%d/%b/%Y:%H:%M:%S %Z]'),
        })
      end
    end
  end

  def marshal_into path
    persist path, PStore
  end

  def yaml_into path
    persist path, YAML::Store
  end

  private

  def persist path, storage
    store = storage.new path
    store.transaction do
      store['stats'] ||= []
      stats.each { |stat| store['stats'] << stat }
    end
  end
end end
