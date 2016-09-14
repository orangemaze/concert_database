module LocationHelper
  require 'json'
  require 'open-uri'

  def get_lat_lon_from_ip
    location = JSON.parse(open("http://ipinfo.io/#{request.remote_ip}", &:read))
    lat_lon = "#{location['loc']}".split(",")
    puts lat_lon.inspect.blue
  end

  def get_city_name_from_lat_lon(lat_lon)
    user_location = Geocity.where('latitude = ? and longitude = ?', lat_lon[0], lat_lon[1])
  end

  def get_time_zone_from_lat_lon(lat_lon)
    json = JSON.parse(open("http://ws.geonames.org/timezoneJSON?lat=#{lat_lon[0]}&lng=#{lat_lon[1]}&username=orangemaze", &:read))
  end

end