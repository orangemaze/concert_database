module LocationHelper
  require 'json'
  require 'open-uri'

  def get_lat_lon_from_ip
    location = JSON.parse(open("http://ipinfo.io/#{request.remote_ip}", &:read))
    "#{location['loc']}".split(",")
  end

  def get_city_name_from_lat_lon(lat_lon)
     Geocity.where('latitude = ? and longitude = ?', lat_lon[0], lat_lon[1])
  end

  def get_time_zone_from_lat_lon(lat_lon)
    JSON.parse(open("http://ws.geonames.org/timezoneJSON?lat=#{lat_lon[0]}&lng=#{lat_lon[1]}&username=orangemaze", &:read))
  end

  def get_cities_within_range(lat_lon, distance)
    sql = "SELECT country, region, city, postalCode as postal_code, metroCode as metro_code, areaCode as area_code, ( 3959 * acos( cos( radians(#{lat_lon[0]}) ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians(#{lat_lon[1]}) ) + sin( radians(#{lat_lon[0]}) ) * sin( radians( latitude ) ) ) ) AS geo_distance FROM geo_city where geo_city.activated = 'y' GROUP BY city HAVING geo_distance < #{distance} ORDER BY geo_distance"
    Geocity.find_by_sql(sql)
  end


end